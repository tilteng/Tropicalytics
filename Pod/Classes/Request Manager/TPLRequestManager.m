//
//  TPLRequestManager.m
//  Pods
//
//  Created by KattMing on 1/22/16.
//
//

#import "TPLRequestManager.h"
#import "TPLAPIClient.h"
#import "TPLDatabase.h"
#import "TPLBatchDetails.h"
#import "TPLEvent.h"
#import "TPLLogger.h"
#import "TPLConfiguration.h"
#import "TPLRequestStructure.h"
#import "Reachability.h"
#import "TPLDeviceUtilities.h"

@interface TPLRequestManager ()

@property (nonatomic, strong) TPLAPIClient     *apiClient;
@property (nonatomic, strong) TPLConfiguration *configuration;
@property (nonatomic, strong) TPLBatchDetails  *batchDetails;

@property (nonatomic, strong) TPLDatabase *database;

@property (nonatomic)         BOOL outstandingDataTask;
@property (nonatomic, strong) NSArray *batchEvents;

@property (nonatomic, strong) TPLRequestStructure *requestStructure;

@property (nonatomic) NetworkStatus networkStatus;

@end

@implementation TPLRequestManager

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype) initWithConfiguration:(TPLConfiguration *)configuration  {
    self = [super init];
    if (self) {
        _configuration = configuration;
        _requestStructure = configuration.requestStructure;
        _apiClient = configuration.apiClient;
        _database = [[TPLDatabase alloc] initWithAPIClientUniqueIdentifier:self.apiClient.uniqueIdentifier];
        Reachability *reachability = [Reachability reachabilityForInternetConnection];
        _networkStatus = [reachability currentReachabilityStatus];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    }

    return self;
}

#pragma mark - Add Events

- (void) recordEvent:(TPLEvent *)event {
    [self queueEventPayload:event];
}

- (void) queueEventPayload:(TPLEvent *)event {
    [self.database addEventToQueue:[event dictionaryRepresentation]];
    [self flushQueue];
}

#pragma mark - Send Events

- (void) flushQueue {
    if (self.networkStatus != NotReachable && !self.outstandingDataTask && [self.database getEventsArrayCount] >= self.flushRate) {
        [self flush];
    }
}

- (void) flush {
    self.outstandingDataTask = YES;
    
    if ([self.database getEventsArrayCount] >= self.maxBatchSize) {
        self.batchEvents = [[self.database getEventsArray] subarrayWithRange:NSMakeRange(0, self.maxBatchSize)];
    } else {
        self.batchEvents =  [self.database getEventsArray];
    }
    
    if(self.requestStructure.batchDetails) {
        self.requestStructure.batchDetails.totalEvents = [self.batchEvents count];
    }
    
    [self.requestStructure setEvents:[self.database getEventsAsJSONFromArray:self.batchEvents]];
    
    [self.apiClient postWithParameters:[self.requestStructure dictionaryRepresentation] completion:^(NSData *response, NSError *error) {
        if (error) {
            self.outstandingDataTask = NO;
            self.batchEvents = nil;
            NSLog(@"Error flushing payload");
        } else {
            [self.database removeEventsFromQueue:self.batchEvents];
            self.outstandingDataTask = NO;
            self.batchEvents = nil;
            [self flushQueue];
        }
    }];
}

#pragma mark - Setters

- (NSUInteger) maxBatchSize {
    if (!_maxBatchSize) {
        _maxBatchSize = 50;
    }

    return _maxBatchSize;
}

#pragma mark - Database Reset Helper

- (void) resetDatabase {
    [self.database resetDatabase];
}

#pragma mark - Reachability Changed
- (void)reachabilityChanged:(NSNotification *)note {
    Reachability* curReach = [note object];
    self.networkStatus = [curReach currentReachabilityStatus];
}

@end

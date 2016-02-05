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
#import "TPLLogger.h"
#import "TPLConfiguration.h"
#import "TPLRequestStructure.h"
#import "TPLReachability.h"
#import "TPLDeviceUtilities.h"
#import "TPLConstants.h"
#import "TPLFieldGroup.h"

@interface TPLRequestManager ()

@property (nonatomic, strong) TPLRequestStructure *requestStructure;
@property (nonatomic, strong) TPLAPIClient        *apiClient;
@property (nonatomic, strong) TPLBatchDetails     *batchDetails;
@property (nonatomic, strong) TPLDatabase         *database;
@property (nonatomic, strong) NSArray             *batchEvents;

@property (nonatomic) TPLNetworkStatus  networkStatus;
@property (nonatomic) BOOL              outstandingDataTask;

@end

@implementation TPLRequestManager

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype) initWithConfiguration:(TPLConfiguration *)configuration  {
    self = [super init];
    if (self) {
        _requestStructure = [[TPLRequestStructure alloc] init];
        _apiClient = configuration.apiClient;
        _flushRate = configuration.flushRate;
        _database = [[TPLDatabase alloc] initWithAPIClientUniqueIdentifier:self.apiClient.uniqueIdentifier];
        TPLReachability *reachability = [TPLReachability reachabilityForInternetConnection];
        _networkStatus = [reachability currentReachabilityStatus];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kTPLReachabilityChangedNotification object:nil];
    }

    return self;
}

#pragma mark - Add Events

- (void) recordEvent:(NSDictionary *)eventDictionary {
    [self.database addEventToQueue:eventDictionary];
    [self flushQueue];
}

- (void) recordEventWithFieldGroup:(TPLFieldGroup *)fieldGroup {
    [self recordEvent:[fieldGroup dictionaryRepresentation]];
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

    if (self.requestStructure.batchDetails) {
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
- (void) reachabilityChanged:(NSNotification *)note {
    TPLReachability *curReach = [note object];

    self.networkStatus = [curReach currentReachabilityStatus];
}

- (void) addEntry:(NSDictionary *)entry forKey:(NSString *)key {
    if (key.length) {
        [self.requestStructure addEntries:@{ key : entry }];
    } else {
        [self.requestStructure addEntries:entry];
    }
}

- (void) replaceRequestStructure:(TPLRequestStructure *)requestStructure {
    self.requestStructure = requestStructure;
}

- (void) removeEntryForKey:(NSString *)key {
    [self.requestStructure removeEntryForKey:key];
}

- (void) addEntryForFieldGroup:(TPLFieldGroup *)fieldGroup {
    [self.requestStructure addFieldGroup:fieldGroup];
}

- (void) removeEntryForFieldGroup:(TPLFieldGroup *)fieldGroup {
    [self.requestStructure removeEntryForFieldGroup:fieldGroup];
}

@end
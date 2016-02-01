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
#import "TPLConfiguration.h"

@interface TPLRequestManager ()

@property (nonatomic, strong) TPLAPIClient     *apiClient;
@property (nonatomic, strong) TPLConfiguration *configuration;
@property (nonatomic, strong) TPLBatchDetails  *batchDetails;

@property (nonatomic, strong) TPLDatabase *database;

@property (nonatomic, strong) NSURLSessionDataTask *outstandingDataTask;
@property (nonatomic, strong) NSArray *batchEvents;

@end

@implementation TPLRequestManager

- (instancetype) initWithConfiguration:(TPLConfiguration *)configuration  {
    self = [super init];
    if (self) {
        _configuration = configuration;
        _apiClient = configuration.apiClient;
        _database = [[TPLDatabase alloc] initWithAPIClientUniqueIdentifier:self.apiClient.uniqueIdentifier];
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
    if (self.outstandingDataTask == nil && [self.database getEventsArrayCount] >= self.flushRate) {
        [self flush];
    }
}

- (void) flush {
    if ([self.database getEventsArrayCount] >= self.maxBatchSize) {
        self.batchEvents = [[self.database getEventsArray] subarrayWithRange:NSMakeRange(0, self.maxBatchSize)];
    } else {
        self.batchEvents =  [self.database getEventsArray];
    }

    // Ignore BatchDetails for now in Issue #12 as this will be modified later.
    TPLBatchDetails *batchDetails = [[TPLBatchDetails alloc] init];
    batchDetails.totalEvents = [self.batchEvents count];

    // We should probably abstract this out into a larger request that will be a dictionary instead of setting random keys and values.
    // Will leave that to another github issue.
    NSMutableDictionary *payloadDictionary = [[NSMutableDictionary alloc] init];
    [payloadDictionary setObject:[batchDetails dictionaryRepresentation] forKey:@"batch"];
    [payloadDictionary setObject:[self.database getEventsAsJSONFromArray:self.batchEvents] forKey:@"events"];
    [payloadDictionary addEntriesFromDictionary:[self.configuration dictionaryRepresentation]];

    // Only allow one outbound task at a time.
    self.outstandingDataTask = [self.apiClient postWithParameters:payloadDictionary completion:^(NSDictionary *response, NSError *error) {
        if (error) {
            NSLog(@"Error flushing payload");
        } else {
            [self.database removeEventsFromQueue:self.batchEvents];
            self.outstandingDataTask = nil;
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

@end

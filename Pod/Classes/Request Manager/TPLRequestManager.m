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

@interface TPLRequestManager ()

@property (nonatomic, strong) TPLAPIClient *apiClient;
@property (nonatomic, strong) TPLBatchDetails *batchDetails;

@property (nonatomic, strong) TPLDatabase *database;

@property (nonatomic, strong) NSURLSessionDataTask *outstandingDataTask;
@property (nonatomic, strong) NSArray *batchEvents;

@end

@implementation TPLRequestManager

- (instancetype) initWithAPIClient:(TPLAPIClient *)apiClient {
    self = [super init];
    if (self) {
        _apiClient = apiClient;
        _database = [[TPLDatabase alloc] initWithAPIClientUniqueIdentifier:apiClient.uniqueIdentifier];
    }

    return self;
}

- (void) recordEvent:(NSDictionary *)eventData {
    [self queueEventPayload:eventData];
}

- (void) queueEventPayload:(NSDictionary *)eventPayload {
    [self.database addEventToQueue:eventPayload];
    [self flushQueue];
}

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

- (NSUInteger) maxBatchSize {
    if (!_maxBatchSize) {
        _maxBatchSize = 50;
    }

    return _maxBatchSize;
}

- (NSUInteger) flushRate {
    if (!_flushRate) {
        _flushRate = 20;
    }

    return _flushRate;
}

- (void) resetDatabase {
    [self.database resetDatabase];
}

- (NSArray *) getEventsAsJSONArray {
    return [self.database getEventsAsJSONArray];
}

@end

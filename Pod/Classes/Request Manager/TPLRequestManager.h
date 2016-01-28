//
//  TPLRequestManager.h
//  Pods
//
//  Created by KattMing on 1/22/16.
//
//

#import <Foundation/Foundation.h>

@class TPLAPIClient;

@interface TPLRequestManager : NSObject

/**
 *  The Maximum batch size to be sent. If no size is specified will default to 50.
 */
@property (nonatomic, assign) NSUInteger maxBatchSize;

/**
 *  The number of requests required to initiate a request. The default is 20.
 */
@property (nonatomic, assign) NSUInteger flushRate;

/**
 *  Default initializer that will set the appropriate API client with the request.
 *
 *  @param apiClient an instance of TPLApiClient
 *
 *  @return instance of TPLRequestManager
 */
- (instancetype) initWithAPIClient:(TPLAPIClient *)apiClient;

/**
 *  Sample way to record an event. This will change as we build out the structure of this.
 *
 *  @param eventData NSDictionary containing the event data.
 */
- (void) recordEvent:(NSDictionary *)eventData;

/**
 *  Send events in queue to server
 */
- (void) flushQueue;

/**
 *  Remove all events from local storage to start fresh for this instance of the request manager. If more than one instance has been created, they will remain.
 */
- (void) resetDatabase;

// Debugging placeholder.
- (NSArray *) getEventsAsJSONArray;

@end
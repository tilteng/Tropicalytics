//
//  TPLRequestManager.h
//  Pods
//
//  Created by KattMing on 1/22/16.
//
//

#import <Foundation/Foundation.h>

@class TPLConfiguration;
@class TPLEvent;

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
 *  @param configuration an instance of TPLConfiguration
 *
 *  @return instance of TPLRequestManager
 */
- (instancetype) initWithConfiguration:(TPLConfiguration *)configuration;

/**
 *  Sample way to record an event. This will change as we build out the structure of this.
 *
 *  @param eventData NSDictionary containing the event data.
 */
- (void) recordEvent:(TPLEvent *)event;

/**
 *  Send events in queue to server
 */
- (void) flushQueue;

/**
 *  Remove all events from local storage to start fresh for this instance of the request manager. If more than one instance has been created, they will remain.
 */
- (void) resetDatabase;

@end
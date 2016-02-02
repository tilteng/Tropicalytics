//
//  TPLConfiguration.h
//  Pods
//
//  Created by KattMing on 1/20/16.
//
//

#import <Foundation/Foundation.h>
#import "TPLFieldGroup.h"

@class TPLAPIClient;
@class TPLRequestStructure;

@interface TPLConfiguration : NSObject

/**
 *  Default Initializer that will create the configuration and the underlying API client.
 *  This will not create a header.
 *
 *  @param basePath The URL to receive the event
 *
 *  @return An instance of TPLConfiguration
 */
- (id) initWithBasePath:(NSURL *)basePath;

/**
 *  Number of events in the queue before a network request will be fired.
 */
@property (nonatomic, assign)   NSUInteger flushRate;

/**
 *  The underlying TPLAPIClient created from initWithBasePath:
 */
@property (nonatomic, readonly) TPLAPIClient *apiClient;

@property (nonatomic, strong) TPLRequestStructure *requestStructure;

/**
 *  Optional: configure how requests are structured.
 *   Uses the default structure:
 *   All requests have "header", "device_info", "user_info" field groupings
 *   in addition to the "event" structure:
 *       {
 *           "header": {...},
 *           "device_info": {...},
 *           "user_info": {...},
 *           "event": {...}
 *       }
 *   The request can also be configured however you desire:
 *   config.requeststructure = @{
 *   All requests will then consist of:
 *       {
 *           "environment": {},
 *           "event": {...}
 *           }
 *           @"environment": @{},
 *       };
 */

@end
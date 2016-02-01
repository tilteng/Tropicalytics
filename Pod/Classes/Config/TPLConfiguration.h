//
//  TPLConfiguration.h
//  Pods
//
//  Created by KattMing on 1/20/16.
//
//

#import <Foundation/Foundation.h>

@class TPLHeader;
@class TPLAPIClient;

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
 *  Default Initializer that allows more flexibility and customization
 *
 *  @param basePath The URL to receive the event
 *  @param header   A TPLHeader to be sent.
 *
 *  @return An instance of TPLConfiguration
 */
- (id) initWithBasePath:(NSURL *)basePath header:(TPLHeader *)header;

/**
 *  Converts the underlying header into JSON
 *
 *  @return a dictionary representation of the underlying header to be sent.
 */
- (NSDictionary *) dictionaryRepresentation;

/**
 *  Number of events in the queue before a network request will be fired.
 */
@property (nonatomic, assign)   NSUInteger flushRate;

/**
 *  The underlying TPLAPIClient created from initWithBasePath:
 */
@property (nonatomic, readonly) TPLAPIClient *apiClient;

/**
 *  The header that is created and configured when the configuration is initialized
 */
@property (nonatomic, readonly) TPLHeader *header;

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
@property (nonatomic)           NSDictionary *requestStructure; // TK I think we might be able to get rid of this for something else.

@end
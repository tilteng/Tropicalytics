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
 *  Toggles the global debug state of the
 *  TPLConfiguration. This determines whether
 *  debug messages are logged.
 *
 *  @param debugFlag BOOL whether debug messages are logged
 */
+ (void) setDebug:(BOOL)debugFlag;

/**
 *  Returns the global debug state of the
 *  TPLConfiguration.
 *
 *  @return BOOL whether debug messages are logged
 */
+ (BOOL) debug;

/**
 *  Number of events in the queue before a network request will be fired.
 */
@property (nonatomic, assign)   NSUInteger flushRate;

/**
 *  The underlying TPLAPIClient created from initWithBasePath:
 */
@property (nonatomic, readonly) TPLAPIClient *apiClient;

@end

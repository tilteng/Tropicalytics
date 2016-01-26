//
//  TPLHeader.h
//  Pods
//
//  Created by Brett Bukowski on 1/22/16.
//
//

#import <Foundation/Foundation.h>
#import "TPLFieldGroup.h"

@interface TPLHeader : TPLFieldGroup
/**
 *  "app_id" field
 */
@property (nonatomic, copy) NSString * appId;

/**
 *  "source" field (app)
 */
@property (nonatomic, copy) NSString * source;

/**
 *  "session_id" field
 */
@property (nonatomic, copy) NSString * sessionId;

/**
 *  "app_version" field
 */
@property (nonatomic, copy) NSString * appVersion;

/**
 *  Prepares an instance with properties set to default values.
 *  Use the default `init` initializer to create an instance
 *  without any of the property values set.
 *
 *  @param appId value to use for the header's "app_id" field
 *  @param source value to use for the header's "source" field
 *
 *  @return an initialized instance with defaults already prepared
 */
- (instancetype)initDefaultHeaderWithAppId:(NSString *)appId source:(NSString *)source;

/**
 *  Prepares an instance with properties (sessionId, appVersion) set to default values.
 *  Use the default `init` initializer to create an instance
 *  without any of the property values set.
 *
 *  @return an initialized instance with defaults already prepared
 */
- (instancetype)initDefaultHeader;

@end

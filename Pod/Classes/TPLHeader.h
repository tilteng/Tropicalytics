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
 *  "env" field (prod/staging)
 */
@property (nonatomic, copy) NSString * env;

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
 *
 *  @param appId value to use for the header's "app_id" field
 *
 *  @return an initialized instance with defaults already prepared
 */
- (instancetype)initDefaultHeaderWithAppId:(NSString *)appId;

@end

//
//  TPLHeader.m
//  Pods
//
//  Created by Brett Bukowski on 1/22/16.
//
//

#import "TPLHeader.h"
#import "TPLAppUtilities.h"
#import "TPLUtilities.h"

@implementation TPLHeader

/*!
 *  Prepares an instance with properties set to default values.
 *
 *  @param appId value to use for the header's "app_id" field
 *
 *  @return an initialized instance with defaults already prepared
 */
- (instancetype)initDefaultHeaderWithAppId:(NSString *)appId {
    self = [self init];
    
    if (self) {
        _appId = appId;
        _source = @"app";
        _env = [TPLAppUtilities getEnvironment];
        _sessionId = [TPLUtilities getSessionUUID];
        _appVersion = [TPLAppUtilities getAppVersion];        
    }
    
    return self;
}

@end

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

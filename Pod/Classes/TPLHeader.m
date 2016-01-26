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

- (instancetype)initDefaultHeader {
    self = [self init];
    
    if (self) {
        _sessionId = [TPLUtilities getSessionUUID];
        _appVersion = [TPLAppUtilities getAppVersion];
    }
    
    return self;
}

- (instancetype)initDefaultHeaderWithAppId:(NSString *)appId source:(NSString *)source {
    self = [self initDefaultHeader];
    
    if (self) {
        _appId = appId;
        _source = source;
    }
    
    return self;
}

@end

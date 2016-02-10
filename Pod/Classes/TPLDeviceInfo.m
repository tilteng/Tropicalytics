//
//  TPLDeviceInfo.m
//  Pods
//
//  Created by Brett Bukowski on 1/27/16.
//
//

#import "TPLDeviceInfo.h"
#import "TPLDeviceUtilities.h"

@implementation TPLDeviceInfo

- (instancetype)initWithDefaults {
    self = [self init];
    
    if (self) {
        _platform = @"ios";
        _device = [TPLDeviceUtilities getName];
        _model = [TPLDeviceUtilities getModel];
        _osVersion = [TPLDeviceUtilities getOSVersion];
        _networkType = [TPLDeviceUtilities getNetwork];
        _timezone = [TPLDeviceUtilities getTimezone];
        _deviceUUID = [TPLDeviceUtilities getUUID];
    }
    
    return self;
}

@end

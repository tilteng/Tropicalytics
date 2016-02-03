//
//  TPLRequestStructure.m
//  Pods
//
//  Created by KattMing on 2/1/16.
//
//

#import "TPLRequestStructure.h"
#import "TPLBatchDetails.h"
#import "TPLDeviceInfo.h"
#import "TPLHeader.h"

@implementation TPLRequestStructure

- (instancetype) initWithDefaultsForAppId:(NSString *)appId {
    self = [self init];
    
    if (self) {
        _batchDetails = [[TPLBatchDetails alloc] initWithKey:@"batch_info"];
        
        _deviceInfo = [[TPLDeviceInfo alloc] initWithDefaults];
        [_deviceInfo setDictionaryRepresentationKey:@"device_info"];
        
        _header = [[TPLHeader alloc] initDefaultHeaderWithAppId:appId source:@"app"];
    }
    
    return self;
}

- (void) setEvents:(NSArray<TPLEvent *> *)eventsArray {
    [super setValue:eventsArray forKey:@"events"];
}

@end
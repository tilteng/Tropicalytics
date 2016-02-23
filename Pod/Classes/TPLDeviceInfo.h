//
//  TPLDeviceInfo.h
//  Pods
//
//  Created by Brett Bukowski on 1/27/16.
//
//

#import <Tropicalytics/Tropicalytics.h>
#import "TPLFieldGroup.h"

@interface TPLDeviceInfo : TPLFieldGroup

@property (nonatomic) NSString * platform;
@property (nonatomic) NSString * device;
@property (nonatomic) NSString * model;
@property (nonatomic) NSString * osVersion;
@property (nonatomic) NSString * networkType;
@property (nonatomic) NSString * timezone;
@property (nonatomic) NSString * deviceUUID;

- (instancetype)initWithDefaults;

@end

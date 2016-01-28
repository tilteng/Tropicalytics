//
//  TPLDeviceUtilities.m
//  Pods
//
//  Created by Brett Bukowski on 1/27/16.
//
//

#import "TPLDeviceUtilities.h"
#import "TPLUniqueIdentifier.h"
#import <sys/utsname.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "AFNetworkReachabilityManager.h"

@implementation TPLDeviceUtilities

+ (NSString *)getTimezone {
    return [[NSTimeZone systemTimeZone] name];
}

+ (NSString *)getLanguage {
    return [[NSLocale preferredLanguages] firstObject];
}

+ (NSString *)getCarrierName {
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [networkInfo subscriberCellularProvider];
    return  [carrier carrierName];
}

+ (NSString *)getNetwork {
    switch ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus) {
        case AFNetworkReachabilityStatusReachableViaWiFi:
            return @"WiFi";
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            return @"Cellular";
        case AFNetworkReachabilityStatusNotReachable:
            return @"Not Reachable";
            break;
        default:
            return @"Unknown";
            break;
    }
}

+ (NSString *)getName {
    return [UIDevice currentDevice].model;
}

+ (NSString *)getOSVersion {
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString *)getModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+ (NSString *)getUUID {
    return [TPLUniqueIdentifier deviceBasedUUID];
}

@end

//
//  TPLUtilities.m
//  Pods
//
//  Created by KattMing on 1/21/16.
//
//

#import "TPLUtilities.h"
#import "TPLUniqueIdentifier.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "AFNetworkReachabilityManager.h"


@implementation TPLUtilities

#pragma mark - Device Utilities

+ (NSString *)getDeviceTimezone {
    return [[NSTimeZone systemTimeZone] name];
}

+ (NSString *)getDeviceLanguage {
    return [[NSLocale preferredLanguages] firstObject];
}

+ (NSString *)getDeviceCarrierName {
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [networkInfo subscriberCellularProvider];
    return  [carrier carrierName];
}

+ (NSString *)getDeviceNetwork {
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

+ (NSString *)getDeviceOSVersion {
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString *)getDeviceUUID {
    return [TPLUniqueIdentifier deviceBasedUUID];
}

#pragma mark - Event Utilities

+ (NSString *)getEventID {
    return [TPLUniqueIdentifier createUUID];
}

+ (NSString *)getEventTimeStamp {
    return [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
}

+ (NSDictionary *)removeNullValuesFromDictionary:(NSDictionary *)inputDictionary {
    NSMutableDictionary *nonnullDictionary = [inputDictionary mutableCopy];
    NSArray *keysForNullValues = [nonnullDictionary allKeysForObject:[NSNull null]];
    [nonnullDictionary removeObjectsForKeys:keysForNullValues];

    return nonnullDictionary;
}

#pragma mark - Session Based Utilities

+ (NSString *)getSessionUUID {
    return [TPLUniqueIdentifier sessionBasedUUID];
}


@end

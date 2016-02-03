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
#import "Reachability.h"

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
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    switch (netStatus) {
        case NotReachable:        {
            return @"Access Not Available";
            break;
        }
            
        case ReachableViaWWAN:        {
            return @"Reachable WWAN";
            break;
        }
        case ReachableViaWiFi:        {
            return @"Reachable WiFi";
            break;
        }
    }
    
    return @"Unknown";
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

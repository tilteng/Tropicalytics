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
#import "TPLReachability.h"

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
    TPLReachability *reachability = [TPLReachability reachabilityForInternetConnection];
    TPLNetworkStatus netStatus = [reachability currentReachabilityStatus];
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
    return [TPLDeviceUtilities deviceNameForSystemInfoCode:[NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding]];
}

+ (NSString *)getUUID {
    return [TPLUniqueIdentifier deviceBasedUUID];
}

#pragma mark - Device Model Helper
/** http://stackoverflow.com/questions/11197509/ios-how-to-get-device-make-and-model
 * This will take care of the appropriate mapping since our function will return iPhone7,2 which is actually an iPhone 6.
*/

+ (NSString *) deviceNameForSystemInfoCode:(NSString *)systemInfoCode {
    static NSDictionary* deviceNamesByCode = nil;
    
    if (!deviceNamesByCode) {
        
        deviceNamesByCode = @{@"i386"      :@"Simulator",
                              @"x86_64"    :@"Simulator",
                              @"iPod1,1"   :@"iPod Touch",      // (Original)
                              @"iPod2,1"   :@"iPod Touch",      // (Second Generation)
                              @"iPod3,1"   :@"iPod Touch",      // (Third Generation)
                              @"iPod4,1"   :@"iPod Touch",      // (Fourth Generation)
                              @"iPod7,1"   :@"iPod Touch",      // (6th Generation)
                              @"iPhone1,1" :@"iPhone",          // (Original)
                              @"iPhone1,2" :@"iPhone",          // (3G)
                              @"iPhone2,1" :@"iPhone",          // (3GS)
                              @"iPad1,1"   :@"iPad",            // (Original)
                              @"iPad2,1"   :@"iPad 2",          //
                              @"iPad3,1"   :@"iPad",            // (3rd Generation)
                              @"iPhone3,1" :@"iPhone 4",        // (GSM)
                              @"iPhone3,3" :@"iPhone 4",        // (CDMA/Verizon/Sprint)
                              @"iPhone4,1" :@"iPhone 4S",       //
                              @"iPhone5,1" :@"iPhone 5",        // (model A1428, AT&T/Canada)
                              @"iPhone5,2" :@"iPhone 5",        // (model A1429, everything else)
                              @"iPad3,4"   :@"iPad",            // (4th Generation)
                              @"iPad2,5"   :@"iPad Mini",       // (Original)
                              @"iPhone5,3" :@"iPhone 5c",       // (model A1456, A1532 | GSM)
                              @"iPhone5,4" :@"iPhone 5c",       // (model A1507, A1516, A1526 (China), A1529 | Global)
                              @"iPhone6,1" :@"iPhone 5s",       // (model A1433, A1533 | GSM)
                              @"iPhone6,2" :@"iPhone 5s",       // (model A1457, A1518, A1528 (China), A1530 | Global)
                              @"iPhone7,1" :@"iPhone 6 Plus",   //
                              @"iPhone7,2" :@"iPhone 6",        //
                              @"iPhone8,1" :@"iPhone 6S",       //
                              @"iPhone8,2" :@"iPhone 6S Plus",  //
                              @"iPad4,1"   :@"iPad Air",        // 5th Generation iPad (iPad Air) - Wifi
                              @"iPad4,2"   :@"iPad Air",        // 5th Generation iPad (iPad Air) - Cellular
                              @"iPad4,4"   :@"iPad Mini",       // (2nd Generation iPad Mini - Wifi)
                              @"iPad4,5"   :@"iPad Mini",       // (2nd Generation iPad Mini - Cellular)
                              @"iPad4,7"   :@"iPad Mini"        // (3rd Generation iPad Mini - Wifi (model A1599))
                              };
    }
    
    NSString *deviceName = deviceNamesByCode[systemInfoCode];
    
    if (!deviceName) {
        return systemInfoCode;
    }
    
    return deviceName;
}

@end

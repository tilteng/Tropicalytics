//
//  TPLDeviceUtilities.h
//  Pods
//
//  Created by Brett Bukowski on 1/27/16.
//
//

#import <Foundation/Foundation.h>

@interface TPLDeviceUtilities : NSObject
/**
 *  A string representing the timezone region
 *
 *  @return A NSString object of the timezone.
 */
+ (NSString *)getTimezone;

/**
 *  A string representing the device's current language
 *
 *  @return A NSString object of the device's language
 */
+ (NSString *)getLanguage;

/**
 *  Gets the carrer from the SIM card
 *
 *  @return A NSString object containing the name of the carrier.
 */
+ (NSString *)getCarrierName;

/**
 *  Gets the network type that the device is connectred to - (eg. WiFi, Cellular)
 *
 *  @return A NSString object of the network type
 */
+ (NSString *)getNetwork;

/**
 *  Returns the device model name (e.g. "iPhone" "iPad")
 *
 *  @return A NSString object of the device model
 */
+ (NSString *)getName;

/**
 *  Gets the devices OS version
 *
 *  @return A NSString object of the device OS version
 */
+ (NSString *)getOSVersion;

/**
 *  Gets the device model name
 *
 *  @return A NSString object of the device model
 */
+ (NSString *)getModel;

/**
 *  Gets the devices UUID
 *
 *  @return A NSString of the devices UUID
 */
+ (NSString *)getUUID;
@end

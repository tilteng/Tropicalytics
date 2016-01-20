//
//  TPLUtilities.h
//  Pods
//
//  Created by KattMing on 1/21/16.
//
//

#import <Foundation/Foundation.h>

/**
 *  A utility class used for obtaining specific information by abstracting out some of the low level calls into this
 *  utility class.
 */
@interface TPLUtilities : NSObject

#pragma mark - Device Utilities

/**
 *  A string representing the timezone region
 *
 *  @return A NSString object of the timezone.
 */
+ (NSString *)getDeviceTimezone;

/**
 *  A string representing the device's current language
 *
 *  @return A NSString object of the device's language
 */
+ (NSString *)getDeviceLanguage;

/**
 *  Gets the carrer from the SIM card
 *
 *  @return A NSString object containing the name of the carrier.
 */
+ (NSString *)getDeviceCarrierName;

/**
 *  Gets the network type that the device is connectred to - (eg. WiFi, Cellular)
 *
 *  @return A NSString object of the network type
 */
+ (NSString *)getDeviceNetwork;

/**
 *  Gets the devices OS version
 *
 *  @return A NSString object of the device OS version
 */
+ (NSString *)getDeviceOSVersion;

/**
 *  Gets the devices UUID
 *
 *  @return A NSString of the devices UUID
 */
+ (NSString *)getDeviceUUID;


#pragma mark - Event Utilities

/**
 *  Generates a UUID to populate from the client the event ID
 *
 *  @return A NSString object formatted as a UUID without dashes
 */
+ (NSString *)getEventID;

/**
 *  Generates a timestamp if one is not supplied for an event
 *
 *  @return A NSString object of the timestamp
 */
+ (NSString *)getEventTimeStamp;

/**
 *  Removes all null values from the input dictionary. It is important that the dictionary returned is scrubbed of nil values before
 *  sending events.
 *
 *  @param inputDictionary The dictionary to remove null values from
 *
 *  @return A NSDictionary object containing non-nil values from the inputDictionary.
 */
+ (NSDictionary *)removeNullValuesFromDictionary:(NSDictionary *)inputDictionary;


#pragma mark - Session Based Utilities

/**
 *  Gets the session UUID. If there a session UUID has not been set this will set a new session.
 *
 *  @return A NSString of a UUID representing the active session.
 */
+ (NSString *)getSessionUUID;

@end

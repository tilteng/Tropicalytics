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

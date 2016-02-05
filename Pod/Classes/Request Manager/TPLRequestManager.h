//
//  TPLRequestManager.h
//  Pods
//
//  Created by KattMing on 1/22/16.
//
//

#import <Foundation/Foundation.h>

@class TPLConfiguration;
@class TPLFieldGroup;
@class TPLRequestStructure;

@interface TPLRequestManager : NSObject

/**
 *  The Maximum batch size to be sent. If no size is specified will default to 50.
 */
@property (nonatomic, assign) NSUInteger maxBatchSize;

/**
 *  The number of requests required to initiate a request. The default is 20.
 */
@property (nonatomic, assign) NSUInteger flushRate;

/**
 *  Default initializer that will set the appropriate API client with the request.
 *
 *  @param configuration an instance of TPLConfiguration
 *
 *  @return instance of TPLRequestManager
 */
- (instancetype) initWithConfiguration:(TPLConfiguration *)configuration;

/**
 *  Replaces the current request structure with a new request structure
 *
 *  @param requestStructure a TPLRequestStructure passed into the Tropicalytics instance.
 */
- (void) replaceRequestStructure:(TPLRequestStructure *)requestStructure;

/**
 *  Sample way to record an event. This will change as we build out the structure of this.
 *
 *  @param eventData NSDictionary containing the event data.
 */
- (void) recordEventWithFieldGroup:(TPLFieldGroup *)fieldGroup;

/**
 *  Records an event for a given dictionary
 *
 *  @param eventDictionary dictionary representation of the event to track
 */
- (void) recordEvent:(NSDictionary *) eventDictionary;

/**
 *  Adds the entry to the request for the key
 *
 *  @param entry NSDictionary representation of the entry to be added
 *  @param key   NSString for the key to be added.
 */
- (void) addEntry:(NSDictionary *)entry forKey:(NSString *)key;

/**
 *  Removes the entry for a specific key
 *
 *  @param key The key used to remove the entry
 */
- (void) removeEntryForKey:(NSString *)key;

/**
 *  Adds an entry as a field group
 *
 *  @param fieldGroup The field group to be added to the request
 */
- (void) addEntryForFieldGroup:(TPLFieldGroup *)fieldGroup;

/**
 *  Removes an entry for a given field group
 *
 *  @param fieldGroup The field group to be removed
 */
- (void) removeEntryForFieldGroup:(TPLFieldGroup *)fieldGroup;

/**
 *  Send events in queue to server
 */
- (void) flushQueue;

/**
 *  Remove all events from local storage to start fresh for this instance of the request manager. If more than one instance has been created, they will remain.
 */
- (void) resetDatabase;

@end
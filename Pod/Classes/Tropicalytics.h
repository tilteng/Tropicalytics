//
//  Tropicalytics.h
//  Pods
//
//  Created by KattMing on 1/19/16.
//
//

#import <UIKit/UIKit.h>

@class TPLConfiguration;
@class TPLFieldGroup;
@class TPLRequestStructure;

NS_ASSUME_NONNULL_BEGIN

@interface Tropicalytics : NSObject

/**
 *  Designated initializer when creating a singleton
 *
 *  @param configuration A TPLConfiguration object to be passed in to the singleton
 *
 */
+ (void) sharedInstanceWithConfiguration:(TPLConfiguration *)configuration;

/**
 *  Initializer when creating a singleton that specifies the default request structure,
 *  setting the specified app id in its header.
 *
 *  @param configuration TPLConfiguration object to be passed in to the singleton
 *  @param appId         NSString app id to set in the header
 */
+ (void) sharedInstanceWithDefaultRequestStructureWithConfiguration:(TPLConfiguration *)configuration appId:(NSString *)appId;

/**
 *  A singleton used from the sharedInstanceWithConfiguration. You must create the singleton using sharedInstanceWithConfiguration:
 *  before you can directly access this singleton.
 *
 *  @return A Tropicalytics singleton
 */
+ (instancetype) sharedInstance;

/**
 *  Designated initializer to create another instance of Tropicalytics that is NOT a singleton
 *
 *  @param configuration A TPLConfiguration object to be passed in to the singleton
 *
 *  @return An instance of Tropicalytics based on the provided configuration.
 */
- (instancetype) initWithConfiguration:(TPLConfiguration *)configuration NS_DESIGNATED_INITIALIZER;

/**
 *  Initializer that creates a default request structure, setting the specified app id in the header.
 *
 *  @param configuration A TPLConfiguration object to be passed in to the singleton
 *  @param appId         NSString app id to set in the header
 *
 *  @return An instance of Tropicalytics based on the provided configuration with a default request structure
 */
- (instancetype) initWithDefaultRequestStructureWithConfiguration:(TPLConfiguration *)configuration appId:(NSString *)appId;

#pragma mark - Set the request structure

/**
 *  Sets the current request structure used by the TPLRequestManager. If no structure is created
 *  a default one containing only events sent to the tropicalytics instance will be used.
 *  Using any of the methods inside "Modify the request structure" will allow customization over
 *  the default request structure or if a custom request structure was added the modifications will be performed
 *  on the added request structure.
 *
 *  @param requestStructure A TPLRequestStructure
 *
 *  Sample Use Case:
 *
 *  Optional: configure how requests are structured.
 *   Uses the default structure:
 *   All requests have "header", "device_info", "user_info" field groupings
 *   in addition to the "event" structure:
 *       {
 *           "header": {...},
 *           "device_info": {...},
 *           "user_info": {...},
 *           "event": {...}
 *       }
 *   The request can also be configured however you desire if you do not 
 *   wish to use or amend the default values.
 *
 */
- (void) setRequestStructure:(TPLRequestStructure *)requestStructure;

#pragma mark - Modify the request structure

/**
 *  Sets the desired properties for the outbound request.
 *
 *  @param userProperties A dictionary containing user information.
 */
- (void) setEntry:(NSDictionary *)entryDictionary forKey:(nullable NSString *)key;

/**
 *  Removes the entry from the dictionary representation for the desired key
 *
 *  @param key the key to be used to remove from the dictionary
 */
- (void) removeEntryForKey:(NSString *)key;

/**
 *  Adds an entry to the request structure
 *
 *  @param fieldGroup The field group to be added to the request structure
 */
- (void) addEntryForFieldGroup:(TPLFieldGroup *)fieldGroup;

/**
 *  Removes the entry from the request structure for a specific field group
 *
 *  @param fieldGroup
 */
- (void) removeEntryForFieldGroup:(TPLFieldGroup *)fieldGroup;

#pragma mark - Record Event

/**
 *  Records an event wit the given event.
 *
 *  @param event TPLFieldGroup event data
 */
- (void) recordEvent:(TPLFieldGroup *)event;

/**
 *  Records an event with the given label and category.
 *
 *  @param label    NSString event label
 *  @param category NSString event category
 */
- (void) recordEventWithLabel:(nullable NSString *)label category:(nullable NSString *)category;

/**
 *  Records an event with the given label, category, and context.
 *
 *  @param label    NSString event label
 *  @param category NSString category
 *  @param context  NSDictionary context data
 */
- (void) recordEventWithLabel:(nullable NSString *)label category:(nullable NSString *)category context:(nullable NSDictionary *)context;

#pragma mark - Database Helper

/**
 *  Reset the current request manager.
 */
- (void) resetDatabase;

@end

NS_ASSUME_NONNULL_END
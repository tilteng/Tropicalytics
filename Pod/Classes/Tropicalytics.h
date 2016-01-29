//
//  Tropicalytics.h
//  Pods
//
//  Created by KattMing on 1/19/16.
//
//

#import <UIKit/UIKit.h>

@class TPLConfiguration;
@class TPLEvent;

@interface Tropicalytics : NSObject

/**
 *  Designated initializer when creating a singleton
 *
 *  @param configuration A TPLConfiguration object to be passed in to the singleton
 *
 */
+ (void) sharedInstanceWithConfiguration:(TPLConfiguration *)configuration;

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
- (id) initWithConfiguration:(TPLConfiguration *)configuration NS_DESIGNATED_INITIALIZER;

/**
 *  Simple way to send a prestructured event to the API. This will change as we start to support real events. Just a placeholder.
 *
 *  @param count A NSNumber representing the event number. Which is used for easy debugging.
 */
- (void) recordEventWithCount:(NSNumber *)count;

/**
 *  Records an event wit the given event.
 *
 *  @param event TPLEvent event
 */
- (void) recordEvent:(TPLEvent *)event;

/**
 *  Records an event with the given label and category.
 *
 *  @param label    NSString event label
 *  @param category NSString event category
 */
- (void) recordEventWithLabel:(NSString *)label category:(NSString *)category;

/**
 *  Reset the current request manager.
 */
- (void) resetDatabase;

/**
 *  Records an event with the given label, category, and context.
 *
 *  @param label    NSString event label
 *  @param category NSString category
 *  @param context  NSDictionary context data
 */
- (void) recordEventWithLabel:(NSString *)label category:(NSString *)category context:(NSDictionary *)context;

// Place holder to ensure core data is working.
- (void) printCoreData;

@end

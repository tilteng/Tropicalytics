//
//  TPLEvent.h
//  Pods
//
//  Created by Brett Bukowski on 1/27/16.
//
//

#import <Tropicalytics/Tropicalytics.h>
#import "TPLFieldGroup.h"
#import <CoreData/CoreData.h>

@interface TPLEvent : TPLFieldGroup

@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSDictionary *context;
@property (nonatomic, copy) NSNumber *timestamp;

/**
 *  Convert a NSManagedObject into a TPLEvent
 *
 *  @param managedObject The managed object to be converted into a TPLEvent.
 *
 *  @return a TPLEvent
 */
+ (TPLEvent *) objectWithManagedObject:(NSManagedObject *)managedObject;


/**
 *  Initializes with the given time interval timestamp.
 *
 *  @param timestamp NSTimeInterval timestamp
 *
 *  @return instance
 */
-(instancetype) initWithTimeInterval:(NSTimeInterval)timestamp;

/**
 *  Initializes with the given label and category and sets timestamp.
 *
 *  @param label    NSString event label
 *  @param category NSString event category
 *
 *  @return instance
 */
-(instancetype) initWithLabel:(NSString *)label category:(NSString *)category;

/**
 *  Initializes with the given label, category, and context and sets timestamp.
 *
 *  @param label    NSString event label
 *  @param category NSString event category
 *  @param context  NSDictionary event context data
 *
 *  @return instance
 */
-(instancetype) initWithLabel:(NSString *)label category:(NSString *)category context:(NSDictionary *)context;

@end

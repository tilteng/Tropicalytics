//
//  TPLRequestStructure.h
//  Pods
//
//  Created by KattMing on 2/1/16.
//
//

#import <Tropicalytics/Tropicalytics.h>
#import "TPLFieldGroup.h"

@class TPLBatchDetails;
@class TPLEvent;

@interface TPLRequestStructure : TPLFieldGroup


/**
 *  Necessary batch information to be sent.
 */
@property (nonatomic, strong) TPLBatchDetails *batchDetails;

/**
 *  Creates an instance, setting batchDetails by default to a new TPLBatchDetails 
 *  instance with a key of "batch_info".
 *
 *  @return TPLRequestStructure instance with batchDetails set
 */
- (instancetype) initWithDefaultBatchInfo;

/**
 *  Creates an instance, setting batchDetails to a new TPLBatchDetails instance with the
 *  specified dictionary key.
 *
 *  @param key NSString batchDetail's dictionaryKey
 *
 *  @return TPLRequestStructure instance with batchDetails set with the specified dictionary key
 */
- (instancetype) initWithDefaultBatchInfoForKey:(NSString *)key;

/**
 *  Sets the events array that is populated by calling `recordEvent`
 *  When subclassing a TPLRequestStructure you can override this function to change the default
 *  behavior of how an event is added to the structure. Normally this will be something like:
 *
 *  events =  (
 *              {
 *                 A TPLEvent subclass as a dictionary representation
 *              },
 *              ...
 *           )
 *
 *
 *
 *  @param eventsArray An array of TPLEvents to be tracked.
 */
- (void) setEvents:(NSArray<TPLEvent *> *)eventsArray;

@end
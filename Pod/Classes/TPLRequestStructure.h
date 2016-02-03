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
@class TPLDeviceInfo;
@class TPLEvent;
@class TPLHeader;

@interface TPLRequestStructure : TPLFieldGroup


/**
 *  Necessary batch information to be sent.
 */
@property (nonatomic, strong) TPLBatchDetails *batchDetails;

/**
 *  "device_info" values.
 */
@property (nonatomic, strong) TPLDeviceInfo *deviceInfo;

/**
 *  "header" values.
 */
@property (nonatomic, strong) TPLHeader *header;

/**
 *  Returns an instance with all properties set to their defaults with
 *  the header's app_id field set to the specified value.
 *
 *  @return TPLRequestStructure instance with all properties set to
 *  their initialized instance values.
 */
- (instancetype) initWithDefaultsForAppId:(NSString *)appId;

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
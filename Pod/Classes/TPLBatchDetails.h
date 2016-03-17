//
//  TPLBatchDetails.h
//  Pods
//
//  Created by KattMing on 1/27/16.
//
//

#import <Tropicalytics/Tropicalytics.h>
#import "TPLFieldGroup.h"


@interface TPLBatchDetails : TPLFieldGroup

/**
 *  A unique identifier to reference the batch. This is set everytime an instance of TPLBatchDetails is created.
 */
@property (nonatomic, readonly) NSString   *batchId;

/**
 *  The total number of events contained in the outgoing batch.
 */
@property (nonatomic)           NSUInteger totalEvents;

@end
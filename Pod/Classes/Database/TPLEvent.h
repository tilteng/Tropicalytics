//
//  TPLEvent.h
//  Pods
//
//  Created by KattMing on 1/27/16.
//
//

#import "TPLFieldGroup.h"
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface TPLEvent : TPLFieldGroup

/**
 *  Convert a NSManagedObject into a TPLEvent
 *
 *  @param managedObject The managed object to be converted into a TPLEvent.
 *
 *  @return a TPLEvent
 */
+ (TPLEvent *) objectWithManagedObject:(NSManagedObject *)managedObject;

@end

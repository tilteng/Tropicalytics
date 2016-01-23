//
//  TPLEvent.m
//  Pods
//
//  Created by KattMing on 1/27/16.
//
//

#import "TPLEvent.h"
#import "TPLDatabase.h"

@implementation TPLEvent

+ (TPLEvent *) objectWithManagedObject:(NSManagedObject *)managedObject {
    TPLEvent *event = [managedObject valueForKey:ManagedObjectEventKey];

    return event;
}

@end
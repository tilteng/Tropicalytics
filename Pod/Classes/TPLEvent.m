//
//  TPLEvent.m
//  Pods
//
//  Created by Brett Bukowski on 1/27/16.
//
//

#import "TPLEvent.h"
#import "TPLDatabase.h"

@implementation TPLEvent

+ (TPLEvent *) objectWithManagedObject:(NSManagedObject *)managedObject {
    TPLEvent *event = [managedObject valueForKey:ManagedObjectEventKey];
    
    return event;
}

-(instancetype) initWithTimeInterval:(NSTimeInterval)timestamp {
    self = [self init];
    
    if (self) {
        _timestamp = @((long)timestamp);
    }
    
    return self;
}

-(instancetype) initWithLabel:(NSString *)label category:(NSString *)category {
    self = [self initWithTimeInterval:[[NSDate date] timeIntervalSince1970]];
    
    if (self) {
        _label = label;
        _category = category;
    }
    
    return self;
}

-(instancetype) initWithLabel:(NSString *)label category:(NSString *)category context:(NSDictionary *)context {
    self = [self initWithLabel:label category:category];
    
    if (self) {
        _context = context;
    }
    
    return self;
}

@end

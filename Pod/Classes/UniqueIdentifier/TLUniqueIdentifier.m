//
//  TLUniqueIdentifier.m
//  Pods
//
//  Created by KattMing on 1/19/16.
//
//

#import "TLUniqueIdentifier.h"

static NSString *const InstallationUUIDKey = @"InstallationUUIDKey";

@interface TLUniqueIdentifier ()

@property (nonatomic, copy) NSString *sessionUUID;

@end

@implementation TLUniqueIdentifier

+ (instancetype)sharedInstance {
    static TLUniqueIdentifier *sharedInstance = nil;
    static dispatch_once_t predicate = 0;
    
    dispatch_once(&predicate, ^() {
        sharedInstance = [[TLUniqueIdentifier alloc] init];
    });
    
    return sharedInstance;
}

- (NSString *)sessionBasedUUID {
    if(!self.sessionUUID) {
        self.sessionUUID = [self createUUID];
    }
    
    return self.sessionUUID;
}

- (NSString *)deviceBasedUUID {
    if(![[NSUserDefaults standardUserDefaults] stringForKey:InstallationUUIDKey]) {
        [[NSUserDefaults standardUserDefaults] setObject:[self createUUID] forKey:InstallationUUIDKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return [[NSUserDefaults standardUserDefaults] stringForKey:InstallationUUIDKey];
}

/**
 *  An internal method used to create a UUID. Since all UUIDs
 *  are unique this will only be used to create a UUID. All assignment should be done
 *  inside of the appropriate method.
 *  @return a UUID of type NSString
 */
- (NSString *)createUUID {
    //Return a lowercase UUID without dashes. #YOLO
    return [[[[NSUUID UUID] UUIDString] lowercaseString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end

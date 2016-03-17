//
//  TLUniqueIdentifier.m
//  Pods
//
//  Created by KattMing on 1/19/16.
//
//

#import "TPLUniqueIdentifier.h"

static NSString *const InstallationUUIDKey = @"InstallationUUIDKey";

@implementation TPLUniqueIdentifier

+ (NSString *)sessionBasedUUID {
    return [self createUUID];
}

+ (NSString *)deviceBasedUUID {
    if(![[NSUserDefaults standardUserDefaults] stringForKey:InstallationUUIDKey]) {
        [[NSUserDefaults standardUserDefaults] setObject:[self createUUID] forKey:InstallationUUIDKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return [[NSUserDefaults standardUserDefaults] stringForKey:InstallationUUIDKey];
}

+ (NSString *)createUUID {
    return [[[[NSUUID UUID] UUIDString] lowercaseString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end

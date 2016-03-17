//
//  TPLUtilities.m
//  Pods
//
//  Created by KattMing on 1/21/16.
//
//

#import "TPLUtilities.h"
#import "TPLUniqueIdentifier.h"

@implementation TPLUtilities

#pragma mark - Device Utilities


#pragma mark - Event Utilities

+ (NSString *)getEventID {
    return [TPLUniqueIdentifier createUUID];
}

+ (NSString *)getEventTimeStamp {
    return [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
}

+ (NSDictionary *)removeNullValuesFromDictionary:(NSDictionary *)inputDictionary {
    NSMutableDictionary *nonnullDictionary = [inputDictionary mutableCopy];
    NSArray *keysForNullValues = [nonnullDictionary allKeysForObject:[NSNull null]];
    [nonnullDictionary removeObjectsForKeys:keysForNullValues];

    return nonnullDictionary;
}

#pragma mark - Session Based Utilities

+ (NSString *)getSessionUUID {
    return [TPLUniqueIdentifier sessionBasedUUID];
}

@end

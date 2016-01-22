//
//  TPLAppUtilities.m
//  Pods
//
//  Created by Brett Bukowski on 1/22/16.
//
//

#import "TPLAppUtilities.h"

@implementation TPLAppUtilities

/**
 *  Returns "staging" or "prod" depending on
 *  whether the DEBUG or ADHOC flags are present.
 *
 *  @return staging / prod
 */
+ (NSString *)getEnvironment {
#ifdef DEBUG
    return @"staging";
#endif
#ifdef ADHOC
    return @"staging";
#endif
    return @"prod";
}

/**
 *  Returns a string representing the app's version number.
 *
 *  @return version (e.g. "1.0")
 */
+ (NSString *)getAppVersion {
    return [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
}

@end

//
//  TPLAppUtilities.m
//  Pods
//
//  Created by Brett Bukowski on 1/22/16.
//
//

#import "TPLAppUtilities.h"

@implementation TPLAppUtilities

+ (NSString *)getEnvironment {
#ifdef DEBUG
    return @"staging";
#endif
#ifdef ADHOC
    return @"staging";
#endif
    return @"prod";
}

+ (NSString *)getAppVersion {
    return [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
}

@end

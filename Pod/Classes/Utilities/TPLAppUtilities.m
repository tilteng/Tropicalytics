//
//  TPLAppUtilities.m
//  Pods
//
//  Created by Brett Bukowski on 1/22/16.
//
//

#import "TPLAppUtilities.h"

#ifdef DEBUG
    #define ENVIRONMENT_VALUE @"debug";
#elif ADHOC
    #define ENVIRONMENT_VALUE @"adhoc";
#else
    #define ENVIRONMENT_VALUE @"prod";
#endif

@implementation TPLAppUtilities

+ (NSString *)getEnvironment {
    return ENVIRONMENT_VALUE;
}

+ (NSString *)getAppVersion {
    return [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
}

@end

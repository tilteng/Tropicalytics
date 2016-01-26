//
//  TPLAppUtilities.m
//  Pods
//
//  Created by Brett Bukowski on 1/22/16.
//
//

#import "TPLAppUtilities.h"

@implementation TPLAppUtilities

+ (NSString *)getAppVersion {
    return [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
}

@end

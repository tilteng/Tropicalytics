//
//  TPLAppUtilities.h
//  Pods
//
//  Created by Brett Bukowski on 1/22/16.
//
//

#import <Foundation/Foundation.h>

@interface TPLAppUtilities : NSObject

/**
 *  Returns "staging" or "prod" depending on
 *  whether the DEBUG or ADHOC flags are present.
 *
 *  @return staging / prod
 */
+ (NSString *)getEnvironment;

/**
 *  Returns a string representing the app's version number.
 *
 *  @return version (e.g. "1.0")
 */
+ (NSString *)getAppVersion;

@end

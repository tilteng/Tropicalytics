//
//  TPLLogger.h
//  Pods
//
//  Created by Brett Bukowski on 1/28/16.
//
//

#import <Foundation/Foundation.h>

@interface TPLLogger : NSObject

/**
 *  Returns whether logging is enabled.
 *
 *  @return BOOL whether logging is enabled
 */
+ (BOOL) enabled;

/**
 *  Sets whether logging is enabled.
 *
 *  @param enabledFlag BOOL whether logging is enabled or disabled
 */
+ (void) setEnabled:(BOOL)enabledFlag;

/**
 *  Logs the formatted message if logging is enabled.
 *
 *  @param format String format and any number of sprintf-substitution arguments
 */
+ (void) log:(NSString *)format, ...;

@end

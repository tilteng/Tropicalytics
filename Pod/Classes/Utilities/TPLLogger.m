//
//  TPLLogger.m
//  Pods
//
//  Created by Brett Bukowski on 1/28/16.
//
//

#import "TPLLogger.h"

static BOOL _enabled = YES;

@implementation TPLLogger

NSString *const prefix = @"TPL: ";

+ (BOOL) enabled {
    return _enabled;
}

+ (void) setEnabled:(BOOL)enabledFlag {
    _enabled = enabledFlag;
}

+ (void) log:(NSString *)format, ... {
    if (!_enabled) {
        return;
    }
    
    va_list args;
    va_start(args, format);
    NSString *fullFormat = [prefix stringByAppendingString:format];
    NSLogv(fullFormat, args);
    va_end(args);
}

@end

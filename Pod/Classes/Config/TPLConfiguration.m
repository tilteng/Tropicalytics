//
//  TPLConfiguration.m
//  Pods
//
//  Created by KattMing on 1/20/16.
//
//

#import "TPLConfiguration.h"
#import "TPLRequestStructure.h"
#import "TPLAPIClient.h"

static NSUInteger const DefaultFlushRate = 20;
static BOOL _debugMode = false;

@implementation TPLConfiguration

+ (void) setDebug:(BOOL)debugFlag {
    _debugMode = debugFlag;
}

+ (BOOL) debug {
    return _debugMode;
}

- (instancetype) initWithBasePath:(NSURL *)basePath {
    NSParameterAssert(basePath);
    self = [self init];
    if (self) {
        _apiClient = [[TPLAPIClient alloc] initWithBaseURL:basePath];
    }

    return self;
}

- (NSUInteger) flushRate {
    if (!_flushRate) {
        _flushRate = DefaultFlushRate;
    }

    return _flushRate;
}

@end

//
//  TPLConfiguration.m
//  Pods
//
//  Created by KattMing on 1/20/16.
//
//

#import "TPLConfiguration.h"
#import "TPLHeader.h"

static NSUInteger const DefaultFlushRate = 20;

@interface TPLConfiguration ()

@property (nonatomic, readwrite) NSURL *urlBasePath;
@property (nonatomic, readwrite) TPLHeader *header;

@end

@implementation TPLConfiguration

- (id)initWithBasePath:(NSURL *)basePath {
    self = [self init];
    if(self) {
        _urlBasePath = basePath;
    }
    
    return self;
}

- (id)initWithBasePath:(NSURL *)basePath header:(TPLHeader *)header {
    self = [self initWithBasePath:basePath];
    if (self) {
        _header = header;
    }
    
    return self;
}

- (NSUInteger)flushRate {
    if(!_flushRate) {
        _flushRate = DefaultFlushRate;
    }
    
    return _flushRate;
}

@end

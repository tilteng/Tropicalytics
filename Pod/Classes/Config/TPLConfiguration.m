//
//  TPLConfiguration.m
//  Pods
//
//  Created by KattMing on 1/20/16.
//
//

#import "TPLConfiguration.h"

@interface TPLConfiguration ()

@property (nonatomic, readwrite) NSURL *urlBasePath;

@end

@implementation TPLConfiguration

- (id)initWithBasePath:(NSURL *)basePath {
    self = [self init];
    if(self) {
        _urlBasePath = basePath;
    }
    
    return self;
}

@end

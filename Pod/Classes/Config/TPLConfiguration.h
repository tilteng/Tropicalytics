//
//  TPLConfiguration.h
//  Pods
//
//  Created by KattMing on 1/20/16.
//
//

#import <Foundation/Foundation.h>

@interface TPLConfiguration : NSObject

- (id)initWithBasePath:(NSURL *)basePath;

@property (nonatomic, readonly) NSURL *urlBasePath;

@end
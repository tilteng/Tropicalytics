//
//  TPLConfiguration.h
//  Pods
//
//  Created by KattMing on 1/20/16.
//
//

#import <Foundation/Foundation.h>

@class TPLHeader;

@interface TPLConfiguration : NSObject

- (id)initWithBasePath:(NSURL *)basePath;
- (id)initWithBasePath:(NSURL *)basePath header:(TPLHeader *)header;

@property (nonatomic, assign)   NSUInteger flushRate;
@property (nonatomic, readonly) NSURL      *urlBasePath;
@property (nonatomic, readonly) TPLHeader  *header;

@end
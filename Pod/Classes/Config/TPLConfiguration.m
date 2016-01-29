//
//  TPLConfiguration.m
//  Pods
//
//  Created by KattMing on 1/20/16.
//
//

#import "TPLConfiguration.h"
#import "TPLHeader.h"

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

- (NSDictionary *)dictionaryRepresentation {
    TPLFieldGroup *requestData = [[TPLFieldGroup alloc] init];
    
    if (_header != nil) {
        [requestData setValue:_header forKey:@"header"];
    }
    
    //    TK Add the rest of the request data....
    
    return [requestData dictionaryRepresentationWithUnderscoreKeys];
}

@end

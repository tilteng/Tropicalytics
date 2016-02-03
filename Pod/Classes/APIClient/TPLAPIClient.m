//
//  TLAPIClient.m
//  Pods
//
//  Created by KattMing on 1/19/16.
//
//

#import "TPLAPIClient.h"
#import "TPLConfiguration.h"
#import "TPLUniqueIdentifier.h"
#import "YYHRequest.h"
#import "YYHJSONRequest.h"

@interface TPLAPIClient ()

@property (nonatomic, readwrite) NSString *uniqueAPIClientIdentifier;
@property (nonatomic, copy) NSURL *basePath;

@end

@implementation TPLAPIClient

- (instancetype) initWithBaseURL:(NSURL *)basePath {
    self = [super init];
    if (self) {
        // We need a persistance layer for when the application resumes so we need to write the correct data
        // to the correct file path. If we save all data from multiple instances into one file we run the risk
        // of sending incorrect batch sizes and also sending data to the wrong end point. Tested this with > 50,000 randomly generated
        // requests to multiple end points and this works fine.
        if (![[NSUserDefaults standardUserDefaults] stringForKey:basePath.absoluteString]) {
            [[NSUserDefaults standardUserDefaults] setValue:[TPLUniqueIdentifier createUUID] forKey:basePath.absoluteString];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }

        _basePath = basePath;
        _uniqueIdentifier = [[NSUserDefaults standardUserDefaults] stringForKey:basePath.absoluteString];

    }

    return self;
}

// It may be worth considering using an NSOperationQueue for some of this stuff, however when I was working with operation queues + core data concurrency and the possibility of failed requests it raised a lot of issues and potential crashes. Open to suggestions and ideas on how
// to improve this. Right now I've seen no issues when handling thousands of requests to be sent out in less than a humanly possibly time.
- (void)postWithParameters:(NSDictionary *)dictionary completion:(TPLAPIClientCompletionBlock)completion {
    YYHJSONRequest *request = [YYHJSONRequest requestWithURL:self.basePath];
    request.method = @"POST";
    request.parameters = [dictionary mutableCopy];
    
    [request loadRequestWithSuccess:^(NSData *data) {
        if(completion) {
            completion(data, nil);
        }
    } failure:^(NSError *error) {
        if(completion) {
            completion(nil, error);
        }
    }];
}

@end
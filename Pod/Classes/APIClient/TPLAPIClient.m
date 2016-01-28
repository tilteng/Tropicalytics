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

@interface TPLAPIClient ()

@property (nonatomic, readwrite) NSString *uniqueAPIClientIdentifier;

@end

@implementation TPLAPIClient

- (instancetype) initWithBaseURL:(NSURL *)basePath {
    self = [super initWithBaseURL:basePath];
    if (self) {
        self.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [self setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [self setRequestSerializer:[AFJSONRequestSerializer serializer]];

        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];

        // We need a persistance layer for when the application resumes so we need to write the correct data
        // to the correct file path. If we save all data from multiple instances into one file we run the risk
        // of sending incorrect batch sizes and also sending data to the wrong end point. Tested this with > 50,000 randomly generated
        // requests to multiple end points and this works fine.
        if (![[NSUserDefaults standardUserDefaults] stringForKey:basePath.absoluteString]) {
            [[NSUserDefaults standardUserDefaults] setValue:[TPLUniqueIdentifier createUUID] forKey:basePath.absoluteString];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }

        _uniqueIdentifier = [[NSUserDefaults standardUserDefaults] stringForKey:basePath.absoluteString];

    }

    return self;
}

// It may be worth considering using an NSOperationQueue for some of this stuff, however when I was working with operation queues + core data concurrency and the possibility of failed requests it raised a lot of issues and potential crashes. Open to suggestions and ideas on how
// to improve this. Right now I've seen no issues when handling thousands of requests to be sent out in less than a humanly possibly time.
- (NSURLSessionDataTask *) postWithParameters:(id)params completion:(TPLAPIClientCompletionBlock)completion {
    return [self POST:@"/" parameters:params progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        [self parseResponse:responseObject fromDataTask:task completion:completion];
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        [self handleError:error dataTask:task completion:completion];
    }];
}

- (void) parseResponse:(id)response fromDataTask:(NSURLSessionDataTask *)task completion:(TPLAPIClientCompletionBlock)completion {
    if (completion) {
        completion(response, nil);
    }
}

- (void) handleError:(NSError *)error dataTask:(NSURLSessionDataTask *)task completion:(TPLAPIClientCompletionBlock)completion {
    if (completion) {
        completion(nil, error);
    }
}

@end
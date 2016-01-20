//
//  TLAPIClient.m
//  Pods
//
//  Created by KattMing on 1/19/16.
//
//

#import "TPLAPIClient.h"
#import "TPLConfiguration.h"

@implementation TPLAPIClient

- (instancetype)initWithBaseURL:(NSURL *)basePath {
    self = [super initWithBaseURL:basePath];
    if(self) {
        self.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [self setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        [self setRequestSerializer:[AFHTTPRequestSerializer serializer]];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    }
    
    return self;
}

- (NSURLSessionDataTask *)postWithParameters:(NSDictionary *)params completion:(TPLAPIClientCompletionBlock)completion {
    return [self POST:@"/" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self parseResponse:responseObject fromDataTask:task completion:completion];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleError:error dataTask:task completion:completion];
    }];
}

- (void)parseResponse:(id)response fromDataTask:(NSURLSessionDataTask *)task completion:(TPLAPIClientCompletionBlock)completion {
    if(completion) {
        completion(response, nil);
    }
}

- (void)handleError:(NSError *)error dataTask:(NSURLSessionDataTask *)task completion:(TPLAPIClientCompletionBlock)completion {
    if (completion) {
        completion(nil, error);
    }
}

@end
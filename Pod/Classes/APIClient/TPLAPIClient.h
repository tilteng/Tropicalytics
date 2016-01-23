//
//  TPLAPIClient.h
//  Pods
//
//  Created by KattMing on 1/19/16.
//
//

#import <Foundation/Foundation.h>

@class TPLAPIClient;

@import AFNetworking;

/**
 *  A completion block used to handle API requests.
 *
 *  @param response An instance of NSDictionary representing the response object.
 *  @param error    An instance of NSError returned from the API.
 */
typedef void (^TPLAPIClientCompletionBlock)(NSDictionary *response, NSError *error);

@interface TPLAPIClient : AFHTTPSessionManager

/**
 *  This property is used to tell our persistence layer which API Client the event was intended for so we can ensure events are sent to the correct API.
 */
@property (nonatomic, readonly) NSString *uniqueIdentifier;

/**
 *  Performs a POST request to the supplised relative path with the supplied parameters.
 *
 *  @param params     A dictionary that contains any JSON data that you want to include in the request. This method simple calls a similar operation on the underlying HTTPClient
 *  @param completion Upon success or failure, the supplied block will be executed.
 *
 *  @return the NSURLSessionDataTask object
 */
- (NSURLSessionDataTask *) postWithParameters:(NSDictionary *)params completion:(TPLAPIClientCompletionBlock)completion;

@end
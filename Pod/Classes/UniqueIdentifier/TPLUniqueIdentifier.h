//
//  TPLUniqueIdentifier.h
//  Pods
//
//  Created by KattMing on 1/19/16.
//
//

#import <Foundation/Foundation.h>

@interface TPLUniqueIdentifier : NSObject

/**
 *  A UUID based on the current users session
 *
 *  @return NSString representing the UUID of the current user for this session
 */
+ (NSString *)sessionBasedUUID;

/**
 *  A UUID based on the users device. This will not persist after the user deletes the application.
 *  We could consider adding keychain support in order to store the UUID for installs but for now let's skip it. - Matt King 1/19/2016
 *  @return NSString representing the device UUID
 */
+ (NSString *)deviceBasedUUID;

/**
 *  Helper function to create a UUID without dashes.
 *
 *  @return NSString representing a UUID.
 */
+ (NSString *)createUUID;

@end

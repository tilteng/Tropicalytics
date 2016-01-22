//
//  TPLFieldGroupSubclass.h
//  Tropicalytics
//
//  Created by Brett Bukowski on 1/25/16.
//  Copyright © 2016 Matt King. All rights reserved.
//

#import "TPLFieldGroup.h"

@interface TPLFieldGroupSubclass : TPLFieldGroup

@property (nonatomic, copy) NSString * someString;
@property (nonatomic) NSUInteger someNumber;
@property (nonatomic, copy) NSDictionary *someDict;

@end

//
//  TPLFieldGroupSubclass.h
//  Tropicalytics
//
//  Created by Brett Bukowski on 1/25/16.
//  Copyright (c) 2016 Tilt.com Inc. All rights reserved.
//

#import "TPLFieldGroup.h"

@interface TPLFieldGroupSubclass : TPLFieldGroup

@property (nonatomic, copy) NSString     * someString;
@property (nonatomic, copy) NSNumber     *someNumber;
@property (nonatomic, copy) NSDictionary *someDict;

@end

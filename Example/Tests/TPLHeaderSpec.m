//
//  TPLHeader.m
//  Tropicalytics
//
//  Created by Brett Bukowski on 1/22/16.
//  Copyright (c) 2016 Tilt.com Inc. All rights reserved.
//

#import <Specta/Specta.h>
#import <Foundation/Foundation.h>
#import "TPLHeader.h"

SpecBegin(TPLHeader)

describe(@"TPLHeader", ^{
    describe(@"initDefaultHeader", ^{
        it(@"sets ivars to default values", ^{
            TPLHeader *header = [[TPLHeader alloc] initDefaultHeader];
            
            expect(header.appId).to.beNil();
            expect(header.source).to.beNil();
            expect(header.sessionId).to.beKindOf([NSString class]);
            expect(header.appVersion).to.beKindOf([NSString class]);
        });
    });

    describe(@"initDefaultHeaderWithAppIdSource", ^{
        it(@"sets the app id and source", ^{
            TPLHeader *header = [[TPLHeader alloc] initDefaultHeaderWithAppId:@"tilt_ios" source:@"app"];
            
            expect(header.appId).to.equal(@"tilt_ios");
            expect(header.source).to.equal(@"app");
        });
    });

});

SpecEnd

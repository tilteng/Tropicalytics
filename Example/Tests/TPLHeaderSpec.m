//
//  TPLHeader.m
//  Tropicalytics
//
//  Created by Brett Bukowski on 1/22/16.
//  Copyright © 2016 Matt King. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPLHeader.h"

SpecBegin(TPLHeader)

describe(@"TPLHeader", ^{
    describe(@"initDefaultHeaderWithAppId", ^{
        it(@"sets the app id", ^{
            TPLHeader *header = [[TPLHeader alloc] initDefaultHeaderWithAppId:@"tilt_ios"];
            
            expect(header.appId).to.equal(@"tilt_ios");
        });
        
        it(@"sets ivars to default values", ^{
            TPLHeader *header = [[TPLHeader alloc] initDefaultHeaderWithAppId:@"foo"];
            
            expect(header.appId).to.equal(@"foo");
            expect(header.source).to.equal(@"app");
            expect(header.env).to.equal(@"staging");
            expect(header.sessionId).to.beKindOf([NSString class]);
        });
    });
});

SpecEnd

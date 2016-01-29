//
//  TPLConfigurationSpec.m
//  Tropicalytics
//
//  Created by Brett Bukowski on 1/27/16.
//  Copyright (c) 2016 Tilt.com Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPLHeader.h"
#import "TPLConfiguration.h"

SpecBegin(TPLConfiguration)

describe(@"TPLConfiguration", ^{
    describe(@"initWithBasePath", ^{
        it(@"sets the base prop", ^{
            TPLConfiguration *config = [[TPLConfiguration alloc] initWithBasePath:[NSURL URLWithString:@"localhost:4000"]];
            
            expect(config.urlBasePath.absoluteString).to.equal(@"localhost:4000");
            expect(config.header).to.beNil();
        });
    });
    
    describe(@"initWithBasePath:header", ^{
        it(@"sets the base prop and header", ^{
            TPLHeader *header = [[TPLHeader alloc] init];
            TPLConfiguration *config = [[TPLConfiguration alloc] initWithBasePath:[NSURL URLWithString:@"localhost:4000"] header:header];
            
            expect(config.urlBasePath.absoluteString).to.equal(@"localhost:4000");
            expect(config.header).to.beKindOf([TPLHeader class]);
        });
    });
    
    describe(@"dictionaryRepresentation", ^{
        it(@"doesn't add a header key if header isn't set", ^{
            TPLConfiguration *config = [[TPLConfiguration alloc] initWithBasePath:[NSURL URLWithString:@"localhost:4000"]];
            NSDictionary *dict = [config dictionaryRepresentation];
            
            expect(dict).to.haveCountOf(0);
        });
        
        it(@"adds the header if header is set", ^{
            TPLHeader *header = [[TPLHeader alloc] init];
            TPLConfiguration *config = [[TPLConfiguration alloc] initWithBasePath:[NSURL URLWithString:@"localhost:4000"] header:header];
            NSDictionary *dict = [config dictionaryRepresentation];
            
            expect(dict).to.haveCountOf(1);
            expect(dict.allKeys).to.equal(@[@"header"]);
        });
    });
});

SpecEnd

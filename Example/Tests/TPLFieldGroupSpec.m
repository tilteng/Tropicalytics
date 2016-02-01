//
//  TPLFieldGroupSpec.m
//  Tropicalytics
//
//  Created by Brett Bukowski on 1/25/16.
//  Copyright (c) 2016 Tilt.com Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Tropicalytics/TPLFieldGroup.h>
#import "TPLFieldGroupSubclass.h"
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>

SpecBegin(TPLFieldGroup)

describe(@"TPLFieldGroup", ^{
    describe(@"initWithEntries", ^{
        it(@"sets the specified dictionary", ^{
            TPLFieldGroup *bag = [[TPLFieldGroup alloc] initWithEntries:@{
                @"foo": @"bar",
                @"ga": @"bi",
            }];

            NSDictionary *values = [bag dictionaryRepresentation];
            
            expect(values).to.haveCountOf(2);
            expect([values objectForKey:@"foo"]).to.equal(@"bar");
            expect([values objectForKey:@"ga"]).to.equal(@"bi");
        });
    });
    
    describe(@"setValue", ^{
        it(@"sets the specified value", ^{
            TPLFieldGroup *bag = [[TPLFieldGroup alloc] init];
            
            [bag setValue:@1 forKey:@"void"];
            
            NSDictionary *values = [bag dictionaryRepresentation];
            
            expect(values).to.haveCountOf(1);
            expect([values objectForKey:@"void"]).to.equal(1);
        });
    });
    
    describe(@"addValues", ^{
        it(@"sets the specified values", ^{
            TPLFieldGroup *bag = [[TPLFieldGroup alloc] initWithEntries:@{
                @"foo": @"bar",
                @"koo": @"koo",
            }];
            
            [bag addValues:@{
                @"foo": @"love",
                @"bar": @"song",
                @"koo": @"home",
            }];
            
            NSDictionary *values = [bag dictionaryRepresentation];
            
            expect(values).to.haveCountOf(3);
            expect([values objectForKey:@"foo"]).to.equal(@"love");
            expect([values objectForKey:@"bar"]).to.equal(@"song");
            expect([values objectForKey:@"koo"]).to.equal(@"home");
        });
    });
    
    describe(@"dictionaryRepresentation", ^{
        it(@"provides the dictionary representation for other instances", ^{
            TPLFieldGroup *outer = [[TPLFieldGroup alloc] init];
            TPLFieldGroup *inner = [[TPLFieldGroup alloc] initWithEntries:@{
                @"foo": @1,
                @"bar": @[@"a", @"b", @"c"],
            }];
            [outer setValue:inner forKey:@"inner"];
            
            NSDictionary *values = [outer dictionaryRepresentation];
            
            expect(values).to.haveCountOf(1);
            
            NSDictionary *innerValues = [values objectForKey:@"inner"];
            expect(innerValues).to.haveCountOf(2);
            expect([innerValues objectForKey:@"foo"]).to.equal(1);
            expect([innerValues objectForKey:@"bar"]).to.equal(@[@"a", @"b", @"c"]);
        });
        
        it(@"merges ivars and data dictionary", ^{
            TPLFieldGroupSubclass *bag = [[TPLFieldGroupSubclass alloc] initWithEntries:@{
                                                                                    @"foo": @"bar",
                                                                                    }];
            bag.someString = @"void";
            bag.someNumber = @1;
            bag.someDict = @{
                             @"right": @"thing",
                             };
            
            [bag setValue:@2 forKey:@"someNumber"];
            [bag setValue:@2 forKey:@"some_number"];
            
            NSDictionary *values = [bag dictionaryRepresentation];
            
            expect(values).to.haveCountOf(5);
            expect([values objectForKey:@"foo"]).to.equal(@"bar");
            expect([values objectForKey:@"someString"]).to.equal(@"void");
            expect([values objectForKey:@"some_number"]).to.equal(2);
            expect([values objectForKey:@"someNumber"]).to.equal(2);
            expect([values objectForKey:@"someDict"]).to.equal(@{@"right": @"thing"});
        });
        
        it(@"converts ivar names to underscored", ^{
            TPLFieldGroupSubclass *bag = [[TPLFieldGroupSubclass alloc] initWithEntries:@{
                                                                                    @"foo": @"bar",
                                                                                    }];
            bag.someString = @"void";
            bag.someNumber = @1;
            bag.someDict = @{
                             @"right": @"thing",
                             };
            
            [bag setValue:@2 forKey:@"someNumber"];
            [bag setValue:@2 forKey:@"some_number"];
            
            NSDictionary *values = [bag dictionaryRepresentationWithUnderscoreKeys];
            
            expect(values).to.haveCountOf(4);
            expect([values objectForKey:@"foo"]).to.equal(@"bar");
            expect([values objectForKey:@"some_string"]).to.equal(@"void");
            expect([values objectForKey:@"some_number"]).to.equal(2);
            expect([values objectForKey:@"some_dict"]).to.equal(@{@"right": @"thing"});
        });
        
        it(@"handles underscored name corner cases", ^{
            NSDictionary *testCases = @{
                                        @"fooBar": @"foo_bar",
                                        @"fooYOLObar": @"foo_yolobar",
                                        @"two words": @"twowords",
                                        @"@3more": @"3more",
                                        @"2": @"2",
                                        @"abc_@#21": @"abc_21",
                                        @"YOLOnumbers": @"yolonumbers",
                                        @"Ab": @"ab",
                                        };
            TPLFieldGroup *bag = [[TPLFieldGroup alloc] initWithEntries:testCases];
            
            NSDictionary *values = [bag dictionaryRepresentationWithUnderscoreKeys];
            
            expect(values).to.haveCountOf([testCases count]);
            
            for (id origKey in testCases) {
                NSString *expected = [testCases objectForKey:origKey];
                expect([values objectForKey:expected]).to.equal(expected);
            }
        });
    });
});

SpecEnd

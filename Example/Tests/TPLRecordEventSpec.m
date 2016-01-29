//
//  TPLRecordEventTest.m
//  Tropicalytics
//
//  Created by KattMing on 1/28/16.
//  Copyright © 2016 Tilt.com Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPLEvent.h"
#import "TPLConfiguration.h"
#import <Specta/Specta.h>
#import "TPLHeader.h"
#import "Tropicalytics.h"
#import "TPLAPIClient.h"

static NSString *const HerokuTestURL     = @"http://tropicalyticsresponseserver.herokuapp.com";

SpecBegin(TPLRecordEvent)

describe(@"RecordEvent", ^{
    
    describe(@"Successful API Request", ^{
        it(@"Fails to send a TPLEvent to the API", ^{
            waitUntil(^(DoneCallback done) {
                TPLAPIClient *apiClient = [[TPLAPIClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://localhost"]];
                //Sample JSON
                NSDictionary *testEvent = @{@"type": @"Contribution",
                                            @"client_tstamp": @1452291633,
                                            @"ctx": @{
                                                    @"campaign_info": @{
                                                            @"guid": @"xxyyxxyxyxyxyxx",
                                                            @"title": @"Chainsmokers All Day",
                                                            @"creation_date": @"2016-01-01 00:00:00",
                                                            @"expiration_date": @"2016-03-01 00:00:00",
                                                            @"tilt_timestamp": @"2016-01-01 00:00:00",
                                                            @"currency": @"USD",
                                                            @"to_date_amt": @10,
                                                            @"num_contributors": @1,
                                                            @"target_amt": @10000,
                                                            @"people_invited": @10,
                                                            @"total_comments": @2,
                                                            @"total_likes": @3,
                                                            @"campaign_type": @"collect",
                                                            @"campaign_security": @"private",
                                                            @"target_timestamp": @"2016-03-01 00:00:00",
                                                            @"created_platform": @"ios"
                                                            }
                                                    }
                                            };
                [apiClient postWithParameters:testEvent completion:^(NSDictionary *response, NSError *error) {
                    XCTAssertNotNil(error, @"Error should be nil");
                    done();
                }];
            });
        });
    });
    
    describe(@"Fail to send Record Event", ^{
        it(@"Sends a TPLEvent to the API", ^{
            waitUntil(^(DoneCallback done) {
                TPLAPIClient *apiClient = [[TPLAPIClient alloc] initWithBaseURL:[NSURL URLWithString:HerokuTestURL]];
                //Sample JSON
                NSDictionary *testEvent = @{@"type": @"Contribution",
                                            @"client_tstamp": @1452291633,
                                            @"ctx": @{
                                                    @"campaign_info": @{
                                                            @"guid": @"xxyyxxyxyxyxyxx",
                                                            @"title": @"Chainsmokers All Day",
                                                            @"creation_date": @"2016-01-01 00:00:00",
                                                            @"expiration_date": @"2016-03-01 00:00:00",
                                                            @"tilt_timestamp": @"2016-01-01 00:00:00",
                                                            @"currency": @"USD",
                                                            @"to_date_amt": @10,
                                                            @"num_contributors": @1,
                                                            @"target_amt": @10000,
                                                            @"people_invited": @10,
                                                            @"total_comments": @2,
                                                            @"total_likes": @3,
                                                            @"campaign_type": @"collect",
                                                            @"campaign_security": @"private",
                                                            @"target_timestamp": @"2016-03-01 00:00:00",
                                                            @"created_platform": @"ios"
                                                            }
                                                    }
                                            };
                [apiClient postWithParameters:testEvent completion:^(NSDictionary *response, NSError *error) {
                    XCTAssertNil(error, @"Error should not be nil");
                    done();
                }];
            });
            
        });
    });
});

SpecEnd

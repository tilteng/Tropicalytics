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
#import "TPLRequestManager.h"
#import <Expecta/Expecta.h>

static NSString *const HerokuTestURL      = @"http://tropicalyticsresponseserver.herokuapp.com";
static NSUInteger const FlushRateConstant = 2;

SpecBegin(TPLRecordEventSpec)

describe(@"TPLRecordEventSpec", ^{
    __block TPLAPIClient *apiClient;
    __block TPLRequestManager *requestManager;
    it(@"can create an instance of TPLAPIClient for a Base URL", ^{
        apiClient = [[TPLAPIClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://localhost"]];
        requestManager = [[TPLRequestManager alloc] initWithAPIClient:apiClient];
        expect(apiClient).toNot.beNil;
    });
        
    it([NSString stringWithFormat:@"should have a flush rate of %lu",(unsigned long)FlushRateConstant] , ^{
        requestManager.flushRate = 2;
        expect(requestManager.flushRate).to.equal(FlushRateConstant);
    });
    
    
        
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
});

SpecEnd

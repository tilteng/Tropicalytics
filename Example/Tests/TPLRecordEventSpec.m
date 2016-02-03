//
//  TPLRecordEventSpec.m
//  Tropicalytics
//
//  Created by KattMing on 1/29/16.
//  Copyright © 2016 Tilt.com Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <Tropicalytics/TPLAPIClient.h>
#import <Tropicalytics/TPLEvent.h>
#import <Tropicalytics/TPLDatabase.h>
#import <Tropicalytics/TPLConfiguration.h>
#import <Tropicalytics/TPLRequestManager.h>

static NSString *const DummyBaseURL     = @"localhost";
static NSUInteger const RequestFlushRate = 2;

/**
 *  This test confirms that interacting with the Request Manager and the Database is correct.
 *  This test will mock the API response necessary to trigger the removal of the Managed Object from Core Data.
 */
SpecBegin(TPLRecordEvent)

describe(@"Record Event Life Cycle", ^{
    NSLog(@"STARTING");
    // Setup
    __block TPLEvent *event;
    __block TPLDatabase *database;
    __block TPLConfiguration *configuration;
    __block TPLRequestManager *requestManager;

    __block NSDictionary *testEvent = @{ @"type": @"Contribution",
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
                                         } };

    it(@"can create a TPLConfiguration", ^{
        configuration = [[TPLConfiguration alloc] initWithBasePath:[NSURL URLWithString:DummyBaseURL]];
        configuration.flushRate = 2;
        expect(configuration).toNot.beNil;
    });

    it(@"can create a TPLRequestManager", ^{
        requestManager = [[TPLRequestManager alloc] initWithConfiguration:configuration];
        expect(requestManager).toNot.beNil;

        requestManager.flushRate = RequestFlushRate;
        expect(requestManager.flushRate).to.equal(RequestFlushRate);
    });

    it(@"can create a TPLDatabase", ^{
        database = [[TPLDatabase alloc] initWithAPIClientUniqueIdentifier:configuration.apiClient.uniqueIdentifier];
        expect(database).toNot.beNil;
        [database resetDatabase];
        expect([database getEventsArrayCount]).to.equal(0);
    });

    it(@"can create a TPLEvent from a dictionary", ^{
        event = [[TPLEvent alloc] initWithEntries:testEvent];
        expect(event).toNot.beNil;
    });

    it(@"should have the same number of keys as an event and as a dictionary", ^{
        NSUInteger testDictionaryCount = [testEvent count];
        NSUInteger eventCount = [[event dictionaryRepresentation] count];
        expect(testDictionaryCount).to.equal(eventCount);
    });

    it(@"should record an event to the database", ^{
        [database addEventToQueue:[event dictionaryRepresentation]];
        expect([database getEventsArrayCount]).to.equal(1);
    });


//    it(@"should send the events to the API", ^{
//        waitUntil(^(DoneCallback done) {
//            expect([database getEventsArrayCount]).to.equal(1);
//            NSArray *outboundBatchArray = [database getEventsArray];
//            NSDictionary *outboundBatchDictionary = @{
//                @"event" : [database getEventsAsJSONFromArray:outboundBatchArray]
//            };
//
//            [configuration.apiClient postWithParameters:outboundBatchDictionary completion:^(NSDictionary *response, NSError *error) {
//                [database removeEventsFromQueue:outboundBatchArray];
//                expect([database getEventsArrayCount]).to.equal(0);
//                done();
//            }];
//        });
//    });
    
    afterAll(^{
        [database resetDatabase];
    });
});

SpecEnd

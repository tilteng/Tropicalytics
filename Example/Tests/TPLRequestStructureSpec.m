//
//  TPLRequestStructureSpec.m
//  Tropicalytics
//
//  Created by KattMing on 2/2/16.
//  Copyright © 2016 Tilt.com Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <Tropicalytics/TPLHeader.h>
#import <Tropicalytics/TPLRequestStructure.h>
#import <Tropicalytics/TPLBatchDetails.h>
#import <Tropicalytics/TPLFieldGroup.h>

SpecBegin(TPLRequestStructure)

/**
 *  The purpose of this test is to create a TPLRequest Structure and then check the returned dictionary 
 *  is equal to a reference dictionary.
 */
describe(@"TPLRequest Structure", ^{
    __block NSDictionary *headerReferenceDictionary;
    __block TPLFieldGroup *fieldGroup;
    __block TPLRequestStructure *structure;
    __block TPLBatchDetails *batchDetails;
    
    //Init the structure
    it(@"can create a TPLRequestStructure", ^{
        structure = [[TPLRequestStructure alloc] init];
        expect(structure).toNot.beNil;
    });

    
    //Create the header
    it(@"can create a TPLFieldGroup with entries and a key", ^{
        fieldGroup = [[TPLFieldGroup alloc] initWithEntries:@{@"appId" : @"tilt_ios", @"appVersion" : @"1.0"} forKey:@"header"];
        expect(fieldGroup).toNot.beNil;
        expect(fieldGroup.dictionaryRepresentationKey).to.equal(@"header");
        
        headerReferenceDictionary = @{@"header" : @{@"appId" : @"tilt_ios", @"appVersion" : @"1.0"}};
        expect(headerReferenceDictionary).to.equal([fieldGroup dictionaryRepresentation]);
    });
    
    it(@"can change the dictionary representation key", ^{
        fieldGroup.dictionaryRepresentationKey = @"new_header";
        expect(fieldGroup.dictionaryRepresentationKey).to.equal(@"new_header");
        NSDictionary *modifiedFieldGroupDictionary = @{@"new_header" : @{@"appId" : @"tilt_ios", @"appVersion" : @"1.0"}};
        expect([fieldGroup dictionaryRepresentation]).to.equal(modifiedFieldGroupDictionary);
        
    });
    
    it(@"can add values from a dictionary", ^{
        fieldGroup.dictionaryRepresentationKey = @"header";
        [structure addValues:[fieldGroup dictionaryRepresentation]];
        expect([structure dictionaryRepresentation]).to.equal(headerReferenceDictionary);
    });
    
    
    it(@"can create TPLBatchDetails", ^{
        batchDetails = [[TPLBatchDetails alloc] init];
        batchDetails.totalEvents = 5;
        expect(batchDetails).toNot.beNil;
        NSLog(@"batch details: %@", [batchDetails dictionaryRepresentation]);
        expect(batchDetails.dictionaryRepresentation.allKeys).to.equal(@[@"batchId", @"totalEvents"]);
        [batchDetails setDictionaryRepresentationKey:@"batch_details"];
        expect([batchDetails dictionaryRepresentation].allKeys).to.equal(@[@"batch_details"]);
        
    });
    
    it(@"can set the batch details on the structure", ^{
        expect(structure.batchDetails).to.beNil;
        [structure setBatchDetails:batchDetails];
        expect(structure.batchDetails).toNot.beNil;
    });
    
    it(@"can create the request structure dictionary", ^{
        NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:[batchDetails dictionaryRepresentation]];
        [mutableDictionary addEntriesFromDictionary:[fieldGroup dictionaryRepresentation]];
        
        expect([structure dictionaryRepresentation]).to.equal(mutableDictionary);

    });
});


SpecEnd
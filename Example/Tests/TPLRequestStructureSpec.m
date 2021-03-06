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
#import <Tropicalytics/TPLDeviceInfo.h>
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
    __block TPLFieldGroup *addRemoveFieldGroup;
    
    //Init the structure
    it(@"can create a TPLRequestStructure", ^{
        structure = [[TPLRequestStructure alloc] init];
        expect(structure).toNot.beNil;
    });
    
    it(@"can add a field group to the structure", ^ {
        addRemoveFieldGroup = [[TPLFieldGroup alloc] initWithEntries:@{@"top_level" : @{@"sub_level" : @"2", @"another_key" : @"3"}}];
        [structure addFieldGroup:addRemoveFieldGroup];
        expect([structure dictionaryRepresentation]).to.equal([addRemoveFieldGroup dictionaryRepresentation]);
    });
    
    it(@"can remove a field group from the structure", ^ {
        [structure removeEntryForFieldGroup:addRemoveFieldGroup];
        expect([structure dictionaryRepresentation]).to.equal(@{});
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
        [structure addEntries:[fieldGroup dictionaryRepresentation]];
        expect([structure dictionaryRepresentation]).to.equal(headerReferenceDictionary);
        [structure addEntries:@{@"test" : @{@"sub" : @"level"}}];
        expect([[structure dictionaryRepresentation] allKeys]).to.equal(@[@"test", @"header"]);
    });
    
    it(@"can remove an entry for a key", ^ {
        [structure removeEntryForKey:@"test"];
        expect([[structure dictionaryRepresentation] allKeys]).toNot.contain(@"test");
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
    
    it(@"initializes header, batchDetails, deviceInfo by default", ^{
        structure = [[TPLRequestStructure alloc] initWithDefaultsForAppId:@"foo"];
        
        expect(structure.batchDetails).to.beKindOf([TPLBatchDetails class]);
        expect(structure.deviceInfo).to.beKindOf([TPLDeviceInfo class]);
        expect(structure.header).to.beKindOf([TPLHeader class]);
        expect(structure.header.appId).to.equal(@"foo");
    });
});


SpecEnd
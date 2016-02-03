//
//  TPLDeviceUtilitiesSpec.m
//  Tropicalytics
//
//  Created by Brett Bukowski on 1/27/16.
//  Copyright © 2016 Tilt.com Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPLDeviceUtilities.h"
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>

SpecBegin(TPLDeviceUtilities)

describe(@"TPLDeviceUtilities", ^{
    describe(@"getTimezone", ^{
        it(@"returns the current timezone", ^{
            NSString *result = [TPLDeviceUtilities getTimezone];
            expect(result).to.match(@"^([a-zA-Z_/])*$");
        });
    });

    describe(@"getLanguage", ^{
        it(@"returns the current language", ^{
            NSString *result = [TPLDeviceUtilities getLanguage];
            // en or en-US depending on the setup.
            expect(result).to.match(@"^([a-z]){2}(-([A-Z]){2})?$");
        });
    });
    
    describe(@"getCarrierName", ^{
        it(@"returns nil when the device is not configured for a carrier", ^{
            NSString *result = [TPLDeviceUtilities getCarrierName];
            expect(result).to.beNil();
        });
    });
    
    describe(@"getNetwork", ^{
        it(@"returns WiFi for the network", ^{
            NSString *result = [TPLDeviceUtilities getNetwork];
            expect(result).to.equal(@"Reachable WiFi");
        });
    });
    
    describe(@"getOSVersion", ^{
        it(@"returns OS version", ^{
            NSString *result = [TPLDeviceUtilities getOSVersion];
            expect(result).to.match(@"^([0-9]){1,2}\.([0-9])$");

        });
    });

    describe(@"getName", ^{
        it(@"returns device model name", ^{
            NSString *result = [TPLDeviceUtilities getName];
            // "iPhone"
            expect(result).to.match(@"[a-zA-Z]");
        });
    });
    
    describe(@"getModel", ^{
        it(@"returns device model name", ^{
            NSString *result = [TPLDeviceUtilities getModel];
            // "x86_64" on 64-bit Simulator
            expect(result).to.match(@"[a-zA-Z]");
        });
    });
    
    describe(@"getUUID", ^{
        it(@"returns InstallationUUIDKey", ^{
            NSString *result = [TPLDeviceUtilities getUUID];
            expect(result).to.match(@"^([a-z0-9]*)$");
        });
    });
});

SpecEnd

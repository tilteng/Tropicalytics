//
//  TLViewController.m
//  Tropicalytics
//
//  Created by Matt King on 01/19/2016.
//  Copyright (c) 2016 Tilt.com Inc. All rights reserved.
//

#import "TPLViewController.h"
#import "Tropicalytics.h"
#import "TPLConfiguration.h"
#import "TPLHeader.h"

static NSString *const urlBasePath = @"http://localhost:4567";

@interface TPLViewController ()

@property (nonatomic, strong) Tropicalytics *tropicalyticsInstance;

@end

@implementation TPLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Initialize the header payload that is sent as part of all outgoing tracking requests.
    
    // Use the defaults (includes things like app version, environment, etc)...
    TPLHeader *header = [[TPLHeader alloc] initDefaultHeaderWithAppId:@"tilt_ios"];
  
    // ...Or skip the defaults and just do your own thing.
    // TPLHeader *header = [[TPLHeader alloc] init];

    // Adds any arbitrary key-values to the header payload.
    [header addValues:@{
        @"foo": @"bar",
    }];
    
    // Initialize the config. Passing in the header payload is optional.
    TPLConfiguration *config = [[TPLConfiguration alloc] initWithBasePath:[NSURL URLWithString:urlBasePath] header:header];

    // Instance example:
    self.tropicalyticsInstance = [[Tropicalytics alloc] initWithConfiguration:config];
    [self.tropicalyticsInstance sendInitialPost];
    
    // Singleton example:
    //    [Tropicalytics sharedInstanceWithConfiguration:config];
    //    [[Tropicalytics sharedInstance] sendInitialPost];
}

@end

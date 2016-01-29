//
//  TLViewController.m
//  Tropicalytics
//
//  Created by Matt King on 01/19/2016.
//  Copyright (c) 2016 Tilt.com Inc. All rights reserved.
//

#import "TPLViewController.h"
#import "Tropicalytics.h"
#import <Tropicalytics/TPLConfiguration.h>
#import <Tropicalytics/TPLHeader.h>
#import <Tropicalytics/TPLEvent.h>

//Leaving this for now because it will help us test things. We will update the ReadMe to explain how to use the Basic Server checked into this project and this
//will be removed once we are nearly finished with this project.
static NSString *const urlBasePath = @"http://tropicalyticsresponseserver.herokuapp.com";

static NSString *const otherBasePath = @"http://localhost:4567";

@interface TPLViewController ()

@property (nonatomic, strong) Tropicalytics *tropicalyticsInstance;

@property (nonatomic, strong) UIButton *sendEventSingletonButton;
@property (nonatomic, strong) UIButton *sendEventInstanceButton;

@end

@implementation TPLViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // Initialize the header payload that is sent as part of all outgoing tracking requests.

    // Use the defaults (includes things like app version, environment, etc)...
    TPLHeader *header = [[TPLHeader alloc] initDefaultHeaderWithAppId:@"tilt_ios" source:@"app"];

    // ...Or skip the defaults and just do your own thing.
    // TPLHeader *header = [[TPLHeader alloc] init];

    // Adds any arbitrary key-values to the header payload.
    [header addValues:@{
         @"foo": @"bar",
     }];

    // Initialize the config. Passing in the header payload is optional.
    TPLConfiguration *config = [[TPLConfiguration alloc] initWithBasePath:[NSURL URLWithString:urlBasePath] header:header];
    config.flushRate = 2;
    // Optional: configure how requests are structured.
    // Uses the default structure:
    // All requests have "header", "device_info", "user_info" field groupings
    // in addition to the "event" structure:
    // {
    //    "header": {...},
    //    "device_info": {...},
    //    "user_info": {...},
    //    "event": {...}
    // }
    config.requestStructure = [config dictionaryRepresentation];

    // The request can also be configured however you desire:
    // config.requeststructure = @{
    //    // All requests will then consist of:
    //    // {
    //    //    "environment": {},
    //    //    "event": {...}
    //    // }
    //   @"environment": @{},
    // };

    // Instance example:
    self.tropicalyticsInstance = [[Tropicalytics alloc] initWithConfiguration:config];

    TPLConfiguration *otherConfig = [[TPLConfiguration alloc] initWithBasePath:[NSURL URLWithString:urlBasePath]];
    otherConfig.flushRate = 2;
    [Tropicalytics sharedInstanceWithConfiguration:otherConfig];

    self.sendEventInstanceButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    [self.sendEventInstanceButton setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.sendEventInstanceButton];
    [self.sendEventInstanceButton setTitle:@"INSTANCE EVENT" forState:UIControlStateNormal];
    [self.sendEventInstanceButton addTarget:self action:@selector(instanceButtonTapped) forControlEvents:UIControlEventTouchUpInside];

    self.sendEventSingletonButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 120, 100, 100)];
    [self.sendEventSingletonButton setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.sendEventSingletonButton];
    [self.sendEventSingletonButton setTitle:@"EVENT SINGLETON" forState:UIControlStateNormal];
    [self.sendEventSingletonButton addTarget:self action:@selector(sharedInstanceButtonTapped) forControlEvents:UIControlEventTouchUpInside];

    UIButton *resetButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 240, 100, 100)];
    [resetButton setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:resetButton];

    [resetButton setTitle:@"RESET" forState:UIControlStateNormal];
    [resetButton addTarget:self action:@selector(resetEverything) forControlEvents:UIControlEventTouchUpInside];
}

- (void) instanceButtonTapped {
    [self.tropicalyticsInstance recordEvent:[[TPLEvent alloc] initWithLabel:@"app" category:@"view" context:@{
                                                 @"foo": @"bar",
                                             }]];
}

- (void) sharedInstanceButtonTapped {
    [[Tropicalytics sharedInstance] recordEvent:[[TPLEvent alloc] initWithEntries:@{
                                                     @"foo": @"bar",
                                                 }]];
}

- (void) resetEverything {
    [[Tropicalytics sharedInstance] resetDatabase];
    [self.tropicalyticsInstance resetDatabase];
}

@end

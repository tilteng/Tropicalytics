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
#import <Tropicalytics/TPLRequestStructure.h>

#ifdef DEBUG
#define DEBUG_MODE YES
#else
#define DEBUG_MODE NO
#endif

// Leaving this for now because it will help us test things. We will update the ReadMe to explain how to use the Basic Server checked into this project and this
// will be removed once we are nearly finished with this project.
static NSString *const otherBasePath = @"http://tropicalyticsresponseserver.herokuapp.com";

static NSString *const urlBasePath = @"http://localhost:4567";

@interface TPLViewController ()

@property (nonatomic, strong) Tropicalytics *tropicalyticsInstance;

@property (nonatomic, strong) UIButton *sendEventSingletonButton;
@property (nonatomic, strong) UIButton *sendEventInstanceButton;

@property (nonatomic, strong) UIButton *identifyUserForInstanceButton;

@end

@implementation TPLViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    [self initializeTropicalytics];
    [self initializeView];
}

- (void) initializeTropicalytics {
    // 1) Build up the request structure in order to specify how the JSON payload will look.

    // Create the required structure that will be used to generate the JSON payload.
    // 2) The batchDetails are required. By default, this is a structure that Tropicalytics uses to
    // provide event-batching content to the API server when multiple events are sent in the same HTTP request.
    // e.g.
    // {
    //    "batch_info": {
    //       "batch_id": "guid",
    //       "total_events": 20
    //    }
    // }
    
    TPLRequestStructure *structure = [[TPLRequestStructure alloc] initWithDefaultsForAppId:@"example app"];

    // Optional:
    // Add unstrucuted values to the request structure. This means you don't actually have to subclass TPLRequestStructure to add
    // additional fields to the structure...
    [structure addEntries:@{ @"Something" : @"Else", @"YAY" : @{ @"More nested" : @"YAY" } }];

    // Optional:
    // ...Or add a Field group to the request structure
    TPLFieldGroup *fieldGroup = [[TPLFieldGroup alloc] initWithKey:@"field_group"];
    [fieldGroup addEntries:@{ @"key" : @"value" }];
    [structure addFieldGroup:fieldGroup];

    // 3) Initialize the config for the Tropicalytics instance or singleton.
    // Specify whether to log debug messages.
    [TPLConfiguration setDebug:DEBUG_MODE];
    // Specify the API endpoint URL.
    TPLConfiguration *config = [[TPLConfiguration alloc] initWithBasePath:[NSURL URLWithString:urlBasePath]];
    // Specify the number of events that are batched in an HTTP request.
    config.flushRate = 2;

    // 4) Initialize the Tropicalytics instance / singleton.

    // Instance example.
    self.tropicalyticsInstance = [[Tropicalytics alloc] initWithConfiguration:config];
    [self.tropicalyticsInstance setRequestStructure:structure];

    // Singleton example.
    TPLConfiguration *otherConfig = [[TPLConfiguration alloc] initWithBasePath:[NSURL URLWithString:urlBasePath]];
    otherConfig.flushRate = 2;
    [Tropicalytics sharedInstanceWithConfiguration:otherConfig];

    // The resulting JSON for requests looks like:
    // {
    //    "events": [
    //       { event 1... },
    //       { event 2... },
    //    ],
    //    "batch_info": {
    //       "batch_id": "fd23slkjd...",
    //       "totalEvents": 2,
    //    },
    //    "header": {
    //       "appId": "example_ios_app",
    //       "source": "app",
    //       ...
    //    },
    //    "Something": "Else",
    //    "YAY": {
    //      "More nested": "YAY"
    //    },
    //    "field_group": {
    //      "key": "value"
    //    }
    // }
}

- (void) initializeView {
    self.view.backgroundColor = [UIColor whiteColor];

    self.sendEventInstanceButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, self.view.frame.size.width - 20, 100)];
    [self.sendEventInstanceButton setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.sendEventInstanceButton];
    [self.sendEventInstanceButton setTitle:@"INSTANCE EVENT" forState:UIControlStateNormal];
    [self.sendEventInstanceButton addTarget:self action:@selector(instanceButtonTapped) forControlEvents:UIControlEventTouchUpInside];

    self.sendEventSingletonButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 140, self.view.frame.size.width - 20, 100)];
    [self.sendEventSingletonButton setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.sendEventSingletonButton];
    [self.sendEventSingletonButton setTitle:@"SINGLETON EVENT" forState:UIControlStateNormal];
    [self.sendEventSingletonButton addTarget:self action:@selector(sharedInstanceButtonTapped) forControlEvents:UIControlEventTouchUpInside];

    self.identifyUserForInstanceButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 260, self.view.frame.size.width - 20, 100)];
    [self.identifyUserForInstanceButton setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:self.identifyUserForInstanceButton];
    [self.identifyUserForInstanceButton setTitle:@"IDENTIFY USER" forState:UIControlStateNormal];
    [self.identifyUserForInstanceButton addTarget:self action:@selector(identifyUserButtonTapped) forControlEvents:UIControlEventTouchUpInside];

    UIButton *removeFromRequestStructure = [[UIButton alloc] initWithFrame:CGRectMake(10, 380, self.view.frame.size.width - 20, 100)];
    [removeFromRequestStructure setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:removeFromRequestStructure];

    [removeFromRequestStructure setTitle:@"REMOVE FROM STRUCTURE" forState:UIControlStateNormal];
    [removeFromRequestStructure addTarget:self action:@selector(removeFromStructure) forControlEvents:UIControlEventTouchUpInside];


    UIButton *resetButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 500, self.view.frame.size.width - 20, 100)];
    [resetButton setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:resetButton];

    [resetButton setTitle:@"RESET" forState:UIControlStateNormal];
    [resetButton addTarget:self action:@selector(resetEverything) forControlEvents:UIControlEventTouchUpInside];
}

- (void) instanceButtonTapped {
    [self.tropicalyticsInstance recordEvent:@{@"label" : @"app", @"category" : @"view", @"ctx" : @{
                                                 @"new_context": @"context_stuffs",
                                                 }}];
    
    [self.tropicalyticsInstance recordEventWithFieldGroup:[[TPLFieldGroup alloc] initWithEntries:@{
                                                                                                       @"foo": @"bar",
                                                                                                       }]];
}

- (void) sharedInstanceButtonTapped {
    [[Tropicalytics sharedInstance] recordEventWithFieldGroup:[[TPLFieldGroup alloc] initWithEntries:@{
                                                     @"foo": @"bar",
                                                 }]];
}

- (void) resetEverything {
    [[Tropicalytics sharedInstance] resetDatabase];
    [self.tropicalyticsInstance resetDatabase];
}

- (void) identifyUserButtonTapped {
    [self.tropicalyticsInstance setEntry:@{ @"first_name" : @"Matt", @"last_name" : @"King", @"GUID" : @"USR1234567890" } forKey:@"user_info"];
}

- (void) removeFromStructure {
    [self.tropicalyticsInstance removeEntryForKey:@"user_info"];
}

@end

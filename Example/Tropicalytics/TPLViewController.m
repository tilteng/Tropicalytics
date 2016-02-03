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
#import <Tropicalytics/TPLRequestStructure.h>
#import <Tropicalytics/TPLBatchDetails.h>

#ifdef DEBUG
#define DEBUG_MODE YES
#else
#define DEBUG_MODE NO
#endif

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

    //Create the required structure that will be used to generate the payload dictionary.
    TPLRequestStructure *structure = [[TPLRequestStructure alloc] init];
    
    // Initialize the header payload that is sent as part of all outgoing tracking requests.
    // Use the defaults (includes things like app version, environment, etc)...
    TPLHeader *header = [[TPLHeader alloc] initDefaultHeaderWithAppId:@"tilt_ios" source:@"app"];
    [header setDictionaryRepresentationKey:@"header"];
    
    TPLBatchDetails *batchDetails = [[TPLBatchDetails alloc] initWithKey:@"batch_info"];
    
    [structure setBatchDetails:batchDetails];
    
    //Add unstrucuted values to the request structure. This means you don't actually have to subclass TPLRequestStructure to add
    //additional fields to the structure.
    [structure addValues:[header dictionaryRepresentation]];
    [structure addValues:@{@"Something" : @"Else", @"YAY" : @{@"More nested" : @"YAY"}}];
    
    //Add a Field group to the request structure
    TPLFieldGroup *fieldGroup = [[TPLFieldGroup alloc] initWithKey:@"field_group"];
    [fieldGroup addValues:@{@"key" : @"value"}];
    
    [structure addFieldGroup:fieldGroup];
    
    // Initialize the config. This will take care of creating the underlying TPLAPIClient
    [TPLConfiguration setDebug:DEBUG_MODE];
    TPLConfiguration *config = [[TPLConfiguration alloc] initWithBasePath:[NSURL URLWithString:urlBasePath]];
    config.flushRate = 2;
    config.requestStructure = structure;
    
    self.tropicalyticsInstance = [[Tropicalytics alloc] initWithConfiguration:config];
    
    //Singleton example.
    TPLConfiguration *otherConfig = [[TPLConfiguration alloc] initWithBasePath:[NSURL URLWithString:urlBasePath]];
    otherConfig.flushRate = 2;
    otherConfig.requestStructure = structure;
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
                                                                                                                  @"new_context": @"context_stuffs",
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

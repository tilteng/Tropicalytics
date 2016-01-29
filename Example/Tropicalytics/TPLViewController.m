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

static NSString *const urlBasePath = @"http://tropicalyticsresponseserver.herokuapp.com";
static NSString *const otherBasePath = @"http://localhost:4555";

@interface TPLViewController ()

@property (nonatomic, strong) Tropicalytics *tropicalyticsInstance;

@property (nonatomic, strong) UIButton *sendEventSingletonButton;
@property (nonatomic, strong) UIButton *sendEventInstanceButton;

@end

@implementation TPLViewController

- (void)viewDidLoad {
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
    config.flushRate = 5;

    // Instance example:
    self.tropicalyticsInstance = [[Tropicalytics alloc] initWithConfiguration:config];
    
    TPLConfiguration *otherConfig = [[TPLConfiguration alloc] initWithBasePath:[NSURL URLWithString:otherBasePath]];
    otherConfig.flushRate = 5;
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
    
    UIButton *printOutCoreDataObjects = [[UIButton alloc] initWithFrame:CGRectMake(120, 240, 100, 100)];
    [printOutCoreDataObjects setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:printOutCoreDataObjects];
    
    [printOutCoreDataObjects setTitle:@"PRINT OBJECTS" forState:UIControlStateNormal];
    [printOutCoreDataObjects addTarget:self action:@selector(printCoreData) forControlEvents:UIControlEventTouchUpInside];
}

//Essential a unit test for now... Will make these actual tests after Brett's TPLEvent stuff is in. This instance and the shared can run at the same time without issues.
- (void)instanceButtonTapped {
    for(int i = 0; i < 6; i++) {
         [self.tropicalyticsInstance recordEvent:@(i)];
    }
}

//Essential a unit test for now... Will make these actual tests after Brett's TPLEvent stuff is in. This instance and the shared can run at the same time without issues.
- (void)sharedInstanceButtonTapped {
    for(int i = 0; i < 1000; i++) {
        [[Tropicalytics sharedInstance] recordEvent:@(i)];
    }
}

- (void)resetEverything {
    [[Tropicalytics sharedInstance] resetDatabase];
    [self.tropicalyticsInstance resetDatabase];
}

- (void)printCoreData {
    [[Tropicalytics sharedInstance] printCoreData];
    [self.tropicalyticsInstance printCoreData];
}

@end

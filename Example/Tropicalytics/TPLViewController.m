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

static NSString *const urlBasePath = @"http://localhost:4567";

@interface TPLViewController ()

@property (nonatomic, strong) Tropicalytics *tropicalyticsInstance;

@end

@implementation TPLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    TPLConfiguration *config = [[TPLConfiguration alloc] initWithBasePath:[NSURL URLWithString:urlBasePath]];

    self.tropicalyticsInstance = [[Tropicalytics alloc] initWithConfiguration:config];

    [self.tropicalyticsInstance sendInitialPost];
    
    [Tropicalytics sharedInstanceWithConfiguration:config];
    [[Tropicalytics sharedInstance] sendInitialPost];
}

@end
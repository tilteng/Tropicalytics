//
//  TLViewController.m
//  Tropicalytics
//
//  Created by Matt King on 01/19/2016.
//  Copyright (c) 2016 Matt King. All rights reserved.
//

#import "TLViewController.h"
#import "TLUniqueIdentifier.h"

@interface TLViewController ()

@property (nonatomic, strong) UILabel *deviceUUID;
@property (nonatomic, strong) UILabel *sessionUUID;

@end

@implementation TLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *deviceUUIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 20)];
    [self.view addSubview:deviceUUIDLabel];
    deviceUUIDLabel.text = [[TLUniqueIdentifier sharedInstance] deviceBasedUUID];
    
    UILabel *sessionUUIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 100, 20)];
    [self.view addSubview:sessionUUIDLabel];
    sessionUUIDLabel.text = [[TLUniqueIdentifier sharedInstance] sessionBasedUUID];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

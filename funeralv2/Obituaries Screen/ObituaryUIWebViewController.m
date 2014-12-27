//
//  ObituaryUIWebViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 29/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "ObituaryUIWebViewController.h"

@interface ObituaryUIWebViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *sideMenuButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ObituaryUIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [HelperClass dashboardSetup:_config.statusBarColour red:[_config.colourRed floatValue] green:[_config.colourGreen floatValue] blue:[_config.colourBlue floatValue] backgroundImageView:_backgroundImageView sideMenuButton:_sideMenuButton closeButton:nil backButton:nil addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:nil saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_config.resourceUrl2]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

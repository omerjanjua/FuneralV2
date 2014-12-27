//
//  ProductsUIWebViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 28/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "ProductsUIWebViewController.h"
#import "EnquiryFormViewController.h"

@interface ProductsUIWebViewController () <UIGestureRecognizerDelegate> {
    NSURL *url;
}

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *enquiryButton;

@end

@implementation ProductsUIWebViewController

-(instancetype)initWithURL:(NSURL *)aURL{
    self = [self initWithNibName:NSStringFromClass([self class]) bundle:nil];
    url = aURL;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [HelperClass dashboardSetup:_config.statusBarColour red:[_config.colourRed floatValue] green:[_config.colourGreen floatValue] blue:[_config.colourBlue floatValue] backgroundImageView:_backgroundImageView sideMenuButton:nil closeButton:nil backButton:_backButton addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:_enquiryButton saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
    
    _enquiryButton = [HelperClass CMSResponseSetEnquiryButtonText:_enquiryButton CMSSettings:_config.countrySettings];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    [_webView loadRequest:[NSURLRequest requestWithURL:url] ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Interactions
- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)enquireButtonPressed:(id)sender
{
    EnquiryFormViewController *controller = [EnquiryFormViewController new];
    [controller setConfig:_config];
    [self.navigationController presentViewController:controller animated:YES completion:nil];
}

@end

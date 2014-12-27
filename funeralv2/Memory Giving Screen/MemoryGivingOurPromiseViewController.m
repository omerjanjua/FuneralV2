//
//  MemoryGivingOurPromiseViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 29/10/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "MemoryGivingOurPromiseViewController.h"

@interface MemoryGivingOurPromiseViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@end

@implementation MemoryGivingOurPromiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [HelperClass dashboardSetup:_config.statusBarColour red:21 green:175 blue:225 backgroundImageView:_backgroundImageView sideMenuButton:nil closeButton:nil backButton:_backButton addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:nil saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    NSString *formattedString = [NSString stringWithFormat:@"<body style='color: rgb(137,137,137); font-family:Helvetica Neue;font-size:13px;'><h1 style='color:rgb(21,175,225); font-size:18px; font-family:'Helvetica Neue';'>Our Promise to Donors</h1>We promise to make Memory Giving simple, respectful and efficient whilst creating simple messages accompany your gift. We will deliver your donation directly to the charity&#039;s bank and enhance the gift where possible by recovering the Gift Aid. We will not pass on any donor details to the charity or any third party for marketing purposes. <br><br> <b>Our Promise to Charities</b><br>We make no charge for charities to register or use the site. We promise to forward donations weekly or on page closure, as agreed. We promise to promote Gift Aid and we will act as your agent through the authority you give during registration with the site (* only registered charities benefit from Gift Aid). We will inform each charity of the contact details of the next of kin and the funeral director for each fund page to allow you to keep the family informed of the work the gift has enabled you to carry out.<br><br><b>Our Promise to Funeral Director Hosts</b><br>We make no charge for funeral directors to register or use the site. We promise to serve your clients with the spirit of the very best standards of care on your behalf. In parallel with your service, we promise to ensure that sensitivity, accuracy and efficiency is maintained at all times and assistance given to achieve a seamless service throughout."];
    
    _descriptionTextView.attributedText = [[NSAttributedString alloc] initWithData:[formattedString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

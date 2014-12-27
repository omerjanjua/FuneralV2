//
//  MemoryGivingAboutUsViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 23/10/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "MemoryGivingAboutUsViewController.h"

@interface MemoryGivingAboutUsViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@end

@implementation MemoryGivingAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [HelperClass dashboardSetup:_config.statusBarColour red:218 green:130 blue:38 backgroundImageView:_backgroundImageView sideMenuButton:nil closeButton:nil backButton:_backButton addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:nil saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;

    NSString *formattedString = [NSString stringWithFormat:@"<body style='color: rgb(137,137,137); font-family:Helvetica Neue;font-size:13px;'><h1 style='color:rgb(218,130,38); font-size:18px; font-family:'Helvetica Neue';'>Make A Donation</h1>We make it easy and secure for on-line giving in memory of a loved one. We work in partnership with leading UK funeral companies to create personalized fund pages as an extension of the client service.<br><br><b>Our Story&nbsp;</b><br>Memory Giving was created in 2010 by two brothers, eager to enhance the experience and effectiveness of in memoriam giving. They have a longstanding knowledge in giving, collecting, and accounting for charitable donations in memory of the deceased. They consider the existing web based services to be great for sponsorships but not always appropriate for giving in tribute to a loved one.<br>Over &pound;80m is given in memory each year by family and friends in the UK. As most donations are personal gifts, most of this would qualify for Gift Aid. However as the donations are nearly all made by cheque, only a tiny fraction is ever claimed.<br><br>We have set about to create a solution that works for the donor, the bereaved family, the funeral director and charities.<br><br>The process started in early 2010 and we are indebted to the help of many along the way.<br><br><b>Our Focus</b><br>We focus only on donations made around the time of the death in memory of a person, as requested in some instances by the family instead of floral tributes.<br><br>Memory Giving focuses on simplifying the transfer of funds through to charities, enables the gift to be increased through Gift Aid and creates an appropriate forum for donors to offer messages of sympathy to the family and friends.<br><br><b>Simplicity</b><br>We want to make it simple so that making a donation becomes a positive memory and reading the fund page messages a comforting experience.<br><br><b>Why do it?</b><br>About half a million families suffer a bereavement each year in the UK. Serving them are about 4,200 professional funeral companies who would traditionally collect and forward donations to one of the tens of thousands of charities specified. This site offers a single point that will collect donations for all charities. Cheque and cash funds are typically collected for 3-4 weeks after the death and cheques or cash passed on to the charities at the end of this time &ndash; our donations are sent on within a week or on page closure.<br><br><b>Our Controls</b><br>Our system enables us to fully track each single donor payment and subsequent Gift Aid claim. Our tracking and tax recovery process works to the standards required by the HMRC and we will undertake periodic process auditing by HMRC to maintain transparency and as an assurance to our users."];
    
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

//
//  AdviceDetailViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 29/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "AdviceDetailViewController.h"
#import "EnquiryFormViewController.h"

@interface AdviceDetailViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *enquiryButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@end

@implementation AdviceDetailViewController

@synthesize description;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [HelperClass dashboardSetup:_config.statusBarColour red:[_config.colourRed floatValue] green:[_config.colourGreen floatValue] blue:[_config.colourBlue floatValue] backgroundImageView:_backgroundImageView sideMenuButton:nil closeButton:nil backButton:_backButton addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:_enquiryButton saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
    [self setupView];
    
    _titleLabel.text = _titleText;
    
    _enquiryButton = [HelperClass CMSResponseSetEnquiryButtonText:_enquiryButton CMSSettings:_config.countrySettings];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup View
-(void)setupView
{
    
    NSString *formattedString = [NSString stringWithFormat:@"<body style='color: rgb(137,137,137); font-family:Helvetica Neue;font-size:13px;'>%@</body>", self.descriptionText];
    
    _descriptionTextView.attributedText = [[NSAttributedString alloc] initWithData:[formattedString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
}

#pragma mark - Button Interactions
- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)enquiryButtonPressed:(id)sender
{
    EnquiryFormViewController *controller = [EnquiryFormViewController new];
    [controller setConfig:_config];
    [self.navigationController presentViewController:controller animated:YES completion:nil];
}

@end

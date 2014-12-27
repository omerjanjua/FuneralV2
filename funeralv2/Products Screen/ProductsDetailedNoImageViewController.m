//
//  ProductsDetailedNoImageViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 10/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "ProductsDetailedNoImageViewController.h"
#import "EnquiryFormViewController.h"

@interface ProductsDetailedNoImageViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIButton *enquiryButton;


@end

@implementation ProductsDetailedNoImageViewController

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
   
    [HelperClass dashboardSetup:_config.statusBarColour red:[_config.colourRed floatValue] green:[_config.colourGreen floatValue] blue:[_config.colourBlue floatValue] backgroundImageView:_backgroundImageView sideMenuButton:nil closeButton:nil backButton:_backButton addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:_enquiryButton saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
    
    _productName.text = _name;
    _productPrice.text = [NSString stringWithFormat:@"%@ %@", [HelperClass CMSResponseSetCurrencySign:_config.countrySettings price:_price], _price];
    
    _enquiryButton = [HelperClass CMSResponseSetEnquiryButtonText:_enquiryButton CMSSettings:_config.countrySettings];

    self.navigationController.interactivePopGestureRecognizer.delegate = self;

    NSString *formattedString = [NSString stringWithFormat:@"<body style='color: rgb(137,137,137); font-family:Helvetica Neue;font-size:13px;'>%@</body>", self.description];
    _descriptionTextView.attributedText = [[NSAttributedString alloc] initWithData:[formattedString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

//
//  FeedbackFormViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 16/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "FeedbackFormViewController.h"
#import "JVFloatLabeledTextField.h"
#import "JVFloatLabeledTextView.h"
#import "KeyboardManager.h"
#import "JSON.h"

@interface FeedbackFormViewController () <UIAlertViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *sideMenuButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendFeedbackButton;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *nameTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *telephoneNumberTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *emailTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextView *yourMessageTextView;

@end

@implementation FeedbackFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup View
-(void)setupView
{
    [HelperClass dashboardSetup:_config.statusBarColour red:[_config.colourRed floatValue] green:[_config.colourGreen floatValue] blue:[_config.colourBlue floatValue] backgroundImageView:_backgroundImageView sideMenuButton:_sideMenuButton closeButton:nil backButton:nil addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:_sendFeedbackButton saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
    
    [_nameTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}]];
    [_telephoneNumberTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Telephone Number" attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}]];
    [_emailTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Email Address" attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}]];
    [_yourMessageTextView setPlaceholder:@"Your Message" floatingTitle:@"Your Message"];
    [_yourMessageTextView setPlaceholderTextColor:[UIColor darkGrayColor]];
}

#pragma mark - Button Interactions
- (IBAction)sendFeedbackButtonPressed:(id)sender
{
    if (![HelperClass validateNotEmpty:_nameTextField.text] || ![HelperClass validateNotEmpty:_telephoneNumberTextField.text] || ![HelperClass validateEmail:_emailTextField.text] || ![HelperClass validateNotEmpty:_yourMessageTextView.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incomplete" message:@"Please fill out all information & a valid email before sending." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
        [alert show];
    }
    else
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:_nameTextField.text, @"name", _telephoneNumberTextField.text, @"phone", _emailTextField.text, @"email", _yourMessageTextView.text, @"message", nil];
        
        NSMutableDictionary *dataDictionary = [NSMutableDictionary new];
        
        [dataDictionary setValue:dictionary.JSONFragment forKey:@"data"];
        
        [manager POST:[NSString stringWithFormat:@"%@%@%@", Base_URL, _config.appId, Send_Feedback] parameters:dataDictionary success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSLog(@"SUCCESS%@", responseObject);
             [self cmsResponse:responseObject];
         }
              failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
             [alert show];
             
             NSLog(@"%@", [error localizedDescription]);
         }];
    }
}

-(void)cmsResponse: (NSDictionary *)data
{
    if ([@"OK" isEqualToString:[data objectForKey:@"status"]])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:@"Your feedback has now been sent." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
    }
    else if ([@"Failed" isEqualToString:[data objectForKey:@"status"]])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:[NSString stringWithFormat:@"%@", [data objectForKey:@"message"]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_nameTextField isFirstResponder])
    {
        [_telephoneNumberTextField becomeFirstResponder];
    }
    else if ([_emailTextField isFirstResponder])
    {
        [_yourMessageTextView becomeFirstResponder];
    }
    return YES;
}

@end

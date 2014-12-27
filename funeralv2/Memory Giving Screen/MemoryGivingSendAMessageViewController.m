//
//  MemoryGivingSendAMessageViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 10/11/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "MemoryGivingSendAMessageViewController.h"
#import "JSON.h"

@interface MemoryGivingSendAMessageViewController () <UITextFieldDelegate, UITextViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *yourNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *yourTelephoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *yourEmailTextField;
@property (weak, nonatomic) IBOutlet UITextView *yourMessageTextView;

@end

@implementation MemoryGivingSendAMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [HelperClass dashboardSetup:_config.statusBarColour red:118 green:140 blue:194 backgroundImageView:_backgroundImageView sideMenuButton:nil closeButton:nil backButton:_backButton addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:nil saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
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

- (IBAction)sendMessagekButtonPressed:(id)sender
{
    if (![HelperClass validateNotEmpty:_yourNameTextField.text] || ![HelperClass validateNotEmpty:_yourTelephoneTextField.text] || ![HelperClass validateEmail:_yourEmailTextField.text] || ![HelperClass validateNotEmpty:_yourMessageTextView.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incomplete" message:@"Please fill out all information & a valid email before sending." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
        [alert show];
    }
    else
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:_yourNameTextField.text, @"name", _yourTelephoneTextField.text, @"phone", _yourEmailTextField.text, @"email", _yourMessageTextView.text, @"message", nil];
        
        NSMutableDictionary *dataDictionary = [NSMutableDictionary new];
        
        [dataDictionary setValue:dictionary.JSONFragment forKey:@"data"];
        
        [manager POST:@"http://app.appitized.com/api/67/contact" parameters:dataDictionary success:^(AFHTTPRequestOperation *operation, id responseObject)
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:@"Your message has now been sent." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ([@"Failed" isEqualToString:[data objectForKey:@"status"]])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:[NSString stringWithFormat:@"%@", [data objectForKey:@"message"]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
    }
}

#pragma mark - UITextField Delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_yourNameTextField isFirstResponder])
    {
        [_yourTelephoneTextField becomeFirstResponder];
    }
    else if ([_yourTelephoneTextField isFirstResponder])
    {
        [_yourEmailTextField becomeFirstResponder];
    }
    else if ([_yourEmailTextField isFirstResponder])
    {
        [_yourEmailTextField resignFirstResponder];
        [_yourMessageTextView performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.0];
    }
    return YES;
}
@end

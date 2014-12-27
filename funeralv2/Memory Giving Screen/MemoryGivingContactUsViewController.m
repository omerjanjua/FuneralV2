//
//  MemoryGivingContactUsViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 23/10/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "MemoryGivingContactUsViewController.h"
#import "MemoryGivingSendAMessageViewController.h"
@import MessageUI;

@interface MemoryGivingContactUsViewController () <UIAlertViewDelegate, MFMailComposeViewControllerDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *addressTextView;

@end

@implementation MemoryGivingContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [HelperClass dashboardSetup:_config.statusBarColour red:118 green:140 blue:194 backgroundImageView:_backgroundImageView sideMenuButton:nil closeButton:nil backButton:_backButton addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:nil saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    _addressTextView.attributedText = [[NSAttributedString alloc] initWithData:[@"<body style='color: rgb(176, 176, 176); font-family:Helvetica Neue; line-height:1.5; font-size:13px;'>Memory Giving, <br>105 London Road, <br>Wokingham, <br>Berkshire, <br>RG40 1YB" dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    if ([[UIScreen mainScreen] bounds].size.height <= 480.0) {
        _sendAMessasageConstraint.constant = 5;
        _clickToCallConstraint.constant = 5;
        _bottomConstraint.constant = 5;
    }
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

- (IBAction)telephoneNumberButtonPressed:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Call us now on" message:[NSString stringWithFormat:@"0845 600 8660"] delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert show];
}

- (IBAction)emailButtonPressed:(id)sender
{
    MFMailComposeViewController *controller = [MFMailComposeViewController new];
    controller.mailComposeDelegate = self;
    [controller setToRecipients:[NSArray arrayWithObject:@"theteam@memorygiving.com"]];
    if (controller) [self presentViewController:controller animated:YES completion:Nil];
}

- (IBAction)sendAMessageButtonPressed:(id)sender
{
    MemoryGivingSendAMessageViewController *controller = [MemoryGivingSendAMessageViewController new];
    [controller setConfig:_config];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)clickToCallButtonPressed:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Call us now on" message:[NSString stringWithFormat:@"0845 600 8660"] delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert show];
}

#pragma mark - UIAlertView Delegates
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        if ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"] )
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://08456008660"]]];
        }
        else
        {
            UIAlertView *warning =[[UIAlertView alloc] initWithTitle:_config.appName message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warning show];
        }
    }
}

#pragma mark - MFMailComposerController Delegates
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if (result == MFMailComposeResultSent)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:@"Message Sent Successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
    }
    else if (result == MFMailComposeResultFailed)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
    }
    [self dismissViewControllerAnimated:YES completion:Nil];
}

@end

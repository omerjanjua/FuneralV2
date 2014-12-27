//
//  ContactPopUpViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 29/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "ContactPopUpViewController.h"
#import "ContactUsViewController.h"
#import "UIViewController+MJPopupViewController.h"

@interface ContactPopUpViewController ()

@end

@implementation ContactPopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_nameLabel setText:_name];
    [_addressLabel setText:_address];
    [_numberLabel setText:_telephone];
    [_emailButton setTitle:_email forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Interactions
- (IBAction)emailButtonPressed:(id)sender
{
    MFMailComposeViewController *controller = [MFMailComposeViewController new];
    controller.mailComposeDelegate = self;
    [controller setToRecipients:[NSArray arrayWithObject:_email]];
    if (controller) [_controller presentViewController:controller animated:YES completion:Nil];
}

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
    [_controller dismissViewControllerAnimated:YES completion:Nil];
}

- (IBAction)callNowButtonPressed:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Call Now" message:[NSString stringWithFormat:@"Are you sure you want to call? \n %@", _telephone] delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSString *newPhoneString = _telephone;
        
        newPhoneString = [newPhoneString stringByReplacingOccurrencesOfString:@"(" withString:@""];
        newPhoneString = [newPhoneString stringByReplacingOccurrencesOfString:@")" withString:@""];
        newPhoneString = [newPhoneString stringByReplacingOccurrencesOfString:@" " withString:@""];
        newPhoneString = [newPhoneString stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        if ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"] )
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", newPhoneString]]];
        }
        else
        {
            UIAlertView *warning =[[UIAlertView alloc] initWithTitle:_config.appName message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warning show];
        }
    }
}

- (IBAction)getDirectionsButtonPressed:(id)sender
{
    NSString *strGetdirection = @"";
    
    if([[UIDevice currentDevice].systemVersion floatValue] >=6){
        
        strGetdirection = [NSString stringWithFormat:@"http://maps.apple.com/maps?saddr=%f,%f&daddr=%@,%@",self.userCurrentLat,self.userCurrentLong,_contactDataLat,_contactDataLong];
    }
    else{
        strGetdirection = [NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%@,%@",self.userCurrentLat,self.userCurrentLong,_contactDataLat,_contactDataLong];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strGetdirection]];
}

- (IBAction)closeButtonPressed:(id)sender
{
    [_popupCaller dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    if ([_popupCaller isKindOfClass:[ContactUsViewController class]]) {
        [[(ContactUsViewController *)_popupCaller mapView] deselectAnnotation:nil animated:YES];
    }
}

@end

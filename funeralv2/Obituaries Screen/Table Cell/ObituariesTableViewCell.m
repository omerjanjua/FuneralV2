//
//  ObituariesTableViewCell.m
//  funeralv2
//
//  Created by Omer Janjua on 09/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "ObituariesTableViewCell.h"

@implementation ObituariesTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)shareButtonPressed:(id)sender
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Share This App" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Facebook", @"Twitter", @"Email", @"SMS", nil];
    [popup showInView:_controller.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            //facebook
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
            {
                SLComposeViewController *facebookSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                [facebookSheet setInitialText:[NSString stringWithFormat:@"%@ \n \n I am using the %@ app, download it free from the AppStore!", _titleLabel.text, _config.appName]];
                [facebookSheet addURL:[NSURL URLWithString:_config.appleAppUrl]];
                [facebookSheet addImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_config.iconImageUrl]]]];
                [_controller presentViewController:facebookSheet animated:YES completion:Nil];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:@"You can't post to Facebook right now, make sure your device has an internet connection and you have at least one account setup" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                [alert show];
            }
            break;
        case 1:
            //twitter
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
            {
                SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                [tweetSheet setInitialText:[NSString stringWithFormat:@"%@ \n \n I am using the %@ app, download it free from the AppStore!", _titleLabel.text, _config.appName]];
                [tweetSheet addURL:[NSURL URLWithString:_config.appleAppUrl]];
                [tweetSheet addImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_config.iconImageUrl]]]];
                [_controller presentViewController:tweetSheet animated:YES completion:Nil];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                [alert show];
            }
            break;
        case 2:{
            if ([MFMailComposeViewController canSendMail]) {
                [_controller performSelector:@selector(showEmailController:) withObject:_titleLabel.text afterDelay:0.0];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:@"Please register atleast one email account for this feature from your device settings" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                [alert show];
            }
        }
            break;
        case 3:
            //sms
            if ([MFMessageComposeViewController canSendText])
            {
                MFMessageComposeViewController *controller = [MFMessageComposeViewController new];
                controller.messageComposeDelegate = self;
                controller.body = [NSString stringWithFormat:@"%@ \n \n I am using the %@ app, download it free from the AppStore!  \n \n %@", _titleLabel.text, _config.appName, _config.iconImageUrl];
                [_controller presentViewController:controller animated:YES completion:nil];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:@"You can't send SMS messages from this device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                [alert show];
            }
            break;
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    if (result == MFMailComposeResultSent)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:@"Message Sent Successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
    }
    else if (result == MFMailComposeResultFailed)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:@"Messaged Failed To Send" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
    }
    [_controller dismissViewControllerAnimated:YES completion:Nil];
}

@end

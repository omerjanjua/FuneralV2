//
//  SideMenuViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 06/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

@import MessageUI;
@import Social;

#import "SideMenuViewController.h"
#import "SideMenuTableViewCell.h"
#import "DashboardViewController.h"
#import "AdviceViewController.h"
#import "ContactUsViewController.h"
#import "ObituariesViewController.h"
#import "ProductsViewController.h"
#import "TodoListViewController.h"
#import "MyDetailsViewController.h"
#import "MySavedDetailsViewController.h"
#import "MyWishListViewController.h"
#import "MyWishListSavedViewController.h"
#import "FeedbackFormViewController.h"
#import "ObituaryUIWebViewController.h"
#import "MemoryGivingMenuViewController.h"

@interface SideMenuViewController () <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView_35;
@property (weak, nonatomic) IBOutlet UIView *view_4;
@property (weak, nonatomic) IBOutlet UIView *view_35;
@property (strong, nonatomic) NSMutableArray *componentsArray;
@property (strong, nonatomic) NSMutableArray *titleArray;
@property (strong, nonatomic) NSMutableArray *imagesArray;
@property (strong, nonatomic) NSMutableArray *menuItemKeys;

@end

@implementation SideMenuViewController

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
    
    if([[UIScreen mainScreen] bounds].size.height <= 480.0) {
        self.view = _view_35;
    }
    else {
        self.view = _view_4;
    }
    
    [self arraySetup];

    UINib *nib = [UINib nibWithNibName:@"SideMenuTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [_tableView_35 registerNib:nib forCellReuseIdentifier:@"cell"];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"%@", _config);
}

-(void)arraySetup
{
    _componentsArray = [[NSMutableArray alloc] init];
    _titleArray = [[NSMutableArray alloc] init];
    _imagesArray = [[NSMutableArray alloc] init];
    _menuItemKeys = [[NSMutableArray alloc] init];
    
    _componentsArray = _config.componentList;
    
    [_titleArray addObject:@"Home"]; //item 1
    [_imagesArray addObject:@"side-menu-home-icon"];
    [_menuItemKeys addObject:@"home"];
    
    if ([_componentsArray containsObject:@"services"]) {
        [_titleArray addObject:@"Advice"];
        [_imagesArray addObject:@"side-menu-advice-icon"];
        [_menuItemKeys addObject:@"advice"];
    }
    
    if ([_componentsArray containsObject:@"locations"]) {
        [_titleArray addObject:@"Contact"];
        [_imagesArray addObject:@"side-menu-contact-icon"];
        [_menuItemKeys addObject:@"contact"];
    }
    
    if (![_config.resourceUrl1 isEqualToString:@""]) {
        [_titleArray addObject:@"Donation"];
        [_imagesArray addObject:@"side-menu-donation-icon"];
        [_menuItemKeys addObject:@"donation"];
    }
    
    if ([_componentsArray containsObject:@"feedback"]) {
        [_titleArray addObject:@"Feedback"];
        [_imagesArray addObject:@"side-menu-feedback-icon"];
        [_menuItemKeys addObject:@"feedback"];
    }
    
    [_titleArray addObject:@"Memory Giving"]; //only for one app
    [_imagesArray addObject:@"side-menu-memory-giving-icon"];
    [_menuItemKeys addObject:@"memoryGiving"];
    
    if ([_componentsArray containsObject:@"ibeacons"]) {
        [_titleArray addObject:@"My Details"];
        [_imagesArray addObject:@"side-menu-my-details-icon"];
        [_menuItemKeys addObject:@"myDetails"];
    }
    
    if ([_componentsArray containsObject:@"item-list"]) {
        [_titleArray addObject:@"Obituaries"];
        [_imagesArray addObject:@"side-menu-obituaries-icon"];
        [_menuItemKeys addObject:@"obituaries"];
    }
    
    if ([_componentsArray containsObject:@"products"]) {
        [_titleArray addObject:@"Products"];
        [_imagesArray addObject:@"side-menu-products-icon"];
        [_menuItemKeys addObject:@"products"];
    }
    
    if ([_componentsArray containsObject:@"todo-list"]) {
        [_titleArray addObject:@"To Do List"];
        [_imagesArray addObject:@"side-menu-todo-list-icon"];
        [_menuItemKeys addObject:@"todoList"];
    }
    
    [_titleArray addObject:@"My Wishes"];
    [_imagesArray addObject:@"side-menu-wishlist-icon"];
    [_menuItemKeys addObject:@"wishList"];
    
    [_titleArray addObject:@"App Suggestion"];
    [_imagesArray addObject:@"side-menu-app-suggestion-icon"];
    [_menuItemKeys addObject:@"appSuggestion"];
}

#pragma mark - Social Media Share Setup
- (IBAction)facebookButtonPressed:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_config.facebook]];
}

- (IBAction)twitterButtonPressed:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_config.twitter]];
}

- (IBAction)emailButtonPressed:(id)sender
{
    if ([_config.email isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:@"No email in directory" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
    }
    else
    {
        MFMailComposeViewController *controller = [MFMailComposeViewController new];
        controller.mailComposeDelegate = self;
        [controller setToRecipients:[NSArray arrayWithObject:_config.email]];
        if (controller) [self presentViewController:controller animated:YES completion:Nil];
    }
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
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (IBAction)sharingButtonPressed:(id)sender
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Share This App" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Facebook", @"Twitter", @"Email", @"SMS", nil];
    [popup showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex) {
		case 0:
            //facebook
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
            {
                SLComposeViewController *facebookSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                [facebookSheet setInitialText:[NSString stringWithFormat:@"I am using the %@ app, download it free from the AppStore!", _config.appName]];
                [facebookSheet addURL:[NSURL URLWithString:_config.appleAppUrl]];
                [facebookSheet addImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_config.iconImageUrl]]]];
                [self presentViewController:facebookSheet animated:YES completion:Nil];
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
                [tweetSheet setInitialText:[NSString stringWithFormat:@"I am using the %@ app, download it free from the AppStore!", _config.appName]];
                [tweetSheet addURL:[NSURL URLWithString:_config.appleAppUrl]];
                [tweetSheet addImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_config.iconImageUrl]]]];
                [self presentViewController:tweetSheet animated:YES completion:Nil];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                [alert show];
            }
			break;
		case 2:{
//            //email body text
            NSMutableString *emailBody = [[NSMutableString alloc] initWithString:@"<html><body>"];
            [emailBody appendString:[NSString stringWithFormat:@"<p>I am using the %@ app, download it free from the AppStore!</p> <p>%@</p>", _config.appName, _config.appleAppUrl]];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_config.iconImageUrl]]];
            NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
            
            //adding the base64 image data to the email body
            NSString *base64String = [imageData base64EncodedStringWithOptions:0];
            [emailBody appendString:[NSString stringWithFormat:@"<p><b><img src='data:image/png;base64,%@'></b></p>", base64String]];
            [emailBody appendString:@"</body></html>"];
            
            //initiating the mfmailviewcontroller modally
            MFMailComposeViewController *controller = [MFMailComposeViewController new];
            controller.mailComposeDelegate = self;
            [controller setSubject:[NSString stringWithFormat:@"%@", _config.appName]];
            [controller setMessageBody:emailBody isHTML:YES];
            if (controller) [self presentViewController:controller animated:YES completion:Nil];
        }
			break;
		case 3:
            //sms
            if ([MFMessageComposeViewController canSendText])
            {
                MFMessageComposeViewController *controller = [MFMessageComposeViewController new];
                controller.messageComposeDelegate = self;
                controller.body = [NSString stringWithFormat:@"I am using the %@ app, download it free from the AppStore!  \n \n %@", _config.appName, _config.iconImageUrl];
                [self presentViewController:controller animated:YES completion:nil];
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
    [self dismissViewControllerAnimated:YES completion:Nil];
}

#pragma mark - UITableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *key = _menuItemKeys[indexPath.row];
    
    if ([@"home" isEqualToString:key]) {
        DashboardViewController *dashboard = [DashboardViewController new];
        self.sideMenuViewController.contentViewController = [[UINavigationController alloc] initWithRootViewController:dashboard];
        [dashboard setConfig:_config];
        [self.sideMenuViewController hideMenuViewController];
    }
    if ([@"advice" isEqualToString:key]) {
        AdviceViewController *controller = [AdviceViewController new];
        self.sideMenuViewController.contentViewController = [[UINavigationController alloc] initWithRootViewController:controller];
        [controller setConfig:_config];
        [self.sideMenuViewController hideMenuViewController];
    }
    if ([@"contact" isEqualToString:key]) {
        ContactUsViewController *controller = [ContactUsViewController new];
        self.sideMenuViewController.contentViewController = [[UINavigationController alloc] initWithRootViewController:controller];
        [controller setConfig:_config];
        [self.sideMenuViewController hideMenuViewController];
    }
    if ([@"donation" isEqualToString:key]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_config.resourceUrl1]];
    }
    if ([@"feedback" isEqualToString:key]) {
        FeedbackFormViewController *controller = [FeedbackFormViewController new];
        self.sideMenuViewController.contentViewController = [[UINavigationController alloc] initWithRootViewController:controller];
        [controller setConfig:_config];
        [self.sideMenuViewController hideMenuViewController];
    }
    if ([@"memoryGiving" isEqualToString:key]) {
        MemoryGivingMenuViewController *controller = [MemoryGivingMenuViewController new];
        self.sideMenuViewController.contentViewController = [[UINavigationController alloc] initWithRootViewController:controller];
        [controller setConfig:_config];
        [self.sideMenuViewController hideMenuViewController];
    }
    if ([@"myDetails" isEqualToString:key]) {
        
        BOOL detailsSaved = [UserDefault boolForKey:@"detailsSaved"];
        if (!detailsSaved) {
            MyDetailsViewController *controller = [MyDetailsViewController new];
            self.sideMenuViewController.contentViewController = [[UINavigationController alloc] initWithRootViewController:controller];
            [controller setConfig:_config];
            [self.sideMenuViewController hideMenuViewController];
        }
        else
        {
            if([[UIScreen mainScreen] bounds].size.height <= 480.0)
            {
                MySavedDetailsViewController *controller = [[MySavedDetailsViewController alloc] initWithNibName:@"MySavedDetailsViewController_35" bundle:nil];
                self.sideMenuViewController.contentViewController = [[UINavigationController alloc] initWithRootViewController:controller];
                [controller setConfig:_config];
                [self.sideMenuViewController hideMenuViewController];
            }
            else
            {
                MySavedDetailsViewController *controller = [[MySavedDetailsViewController alloc] initWithNibName:@"MySavedDetailsViewController" bundle:nil];
                self.sideMenuViewController.contentViewController = [[UINavigationController alloc] initWithRootViewController:controller];
                [controller setConfig:_config];
                [self.sideMenuViewController hideMenuViewController];
            }
        }
    }
    if ([@"obituaries" isEqualToString:key]) {
        
        if (![_config.resourceUrl2 isEqualToString:@""]) {
            ObituaryUIWebViewController *controller = [ObituaryUIWebViewController new];
            [controller setConfig:_config];
            self.sideMenuViewController.contentViewController = [[UINavigationController alloc] initWithRootViewController:controller];
            [self.sideMenuViewController hideMenuViewController];
        }
        else
        {
            ObituariesViewController *controller = [ObituariesViewController new];
            self.sideMenuViewController.contentViewController = [[UINavigationController alloc] initWithRootViewController:controller];
            [controller setConfig:_config];
            [self.sideMenuViewController hideMenuViewController];
        }
    }
    if ([@"products" isEqualToString:key]) {
        ProductsViewController *controller = [ProductsViewController new];
        self.sideMenuViewController.contentViewController = [[UINavigationController alloc] initWithRootViewController:controller];
        [controller setConfig:_config];
        [self.sideMenuViewController hideMenuViewController];
    }
    if ([@"todoList" isEqualToString:key]) {
        TodoListViewController *controller = [TodoListViewController new];
        self.sideMenuViewController.contentViewController = [[UINavigationController alloc] initWithRootViewController:controller];
        [controller setConfig:_config];
        [self.sideMenuViewController hideMenuViewController];
    }
    if ([@"wishList" isEqualToString:key]) {
        
        BOOL wishListSaved = [UserDefault boolForKey:@"wishListSaved"];
        if (!wishListSaved) {
            
            MyWishListViewController *controller = [MyWishListViewController new];
            self.sideMenuViewController.contentViewController = [[UINavigationController alloc] initWithRootViewController:controller];
            [controller setConfig:_config];
            [self.sideMenuViewController hideMenuViewController];
        }
        else
        {
            if([[UIScreen mainScreen] bounds].size.height <= 480.0)
            {
                MyWishListSavedViewController *controller = [[MyWishListSavedViewController alloc] initWithNibName:@"MyWishListSavedViewController_35" bundle:nil];
                self.sideMenuViewController.contentViewController = [[UINavigationController alloc] initWithRootViewController:controller];
                [controller setConfig:_config];
                [self.sideMenuViewController hideMenuViewController];
            }
                else
            {
                MyWishListSavedViewController *controller = [[MyWishListSavedViewController alloc] initWithNibName:@"MyWishListSavedViewController" bundle:nil];
                self.sideMenuViewController.contentViewController = [[UINavigationController alloc] initWithRootViewController:controller];
                [controller setConfig:_config];
                [self.sideMenuViewController hideMenuViewController];
            }
        }
    }
    if ([@"appSuggestion" isEqualToString:key]) {
        MFMailComposeViewController *controller = [MFMailComposeViewController new];
        controller.mailComposeDelegate = self;
        [controller setToRecipients:[NSArray arrayWithObject:@"sbafeedback@appitized.com"]];
        if (controller) [self presentViewController:controller animated:YES completion:Nil];
    }
}

#pragma mark - UITableView Datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titleArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SideMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
 
    cell.titleLabel.text = _titleArray[indexPath.row];
    cell.image.image = [UIImage imageNamed:_imagesArray[indexPath.row]];

    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

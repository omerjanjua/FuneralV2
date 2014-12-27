//
//  MyWishListSavedViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 27/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "MyWishListSavedViewController.h"
#import "CreateMyWishListViewController.h"

@interface MyWishListSavedViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *sideMenuButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *musicTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeOfFlowersLabel;
@property (weak, nonatomic) IBOutlet UILabel *ceremonyPreferencesLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainsLabel;
@property (weak, nonatomic) IBOutlet UILabel *funeralPreferenceLabel;

@end

@implementation MyWishListSavedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [HelperClass dashboardSetup:_config.statusBarColour red:[_config.colourRed floatValue] green:[_config.colourGreen floatValue] blue:[_config.colourBlue floatValue] backgroundImageView:_backgroundImageView sideMenuButton:_sideMenuButton closeButton:nil backButton:nil addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:_editButton saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    _nameLabel.text = [UserDefault objectForKey:@"nameWishList"];
    _emailLabel.text = [UserDefault objectForKey:@"emailWishList"];
    _musicTypeLabel.text = [UserDefault objectForKey:@"musicWishList"];
    _typeOfFlowersLabel.text = [UserDefault objectForKey:@"typeOfFlowersWishList"];
    _ceremonyPreferencesLabel.text = [UserDefault objectForKey:@"ceremonyPreferencesWishList"];
    _remainsLabel.text = [UserDefault objectForKey:@"remainsWishList"];
    _funeralPreferenceLabel.text = [UserDefault objectForKey:@"funeralPreferencesWishList"];
}

#pragma mark - Button Interactions
- (IBAction)editButtonPressed:(id)sender
{
    if([[UIScreen mainScreen] bounds].size.height <= 480.0)
    {
        CreateMyWishListViewController *controller = [[CreateMyWishListViewController alloc] initWithNibName:@"CreateMyWishListViewController_35" bundle:nil];
        [controller setConfig:_config];
        [self.navigationController presentViewController:controller animated:YES completion:nil];
    }
        else
    {
        CreateMyWishListViewController *controller = [[CreateMyWishListViewController alloc] initWithNibName:@"CreateMyWishListViewController" bundle:nil];
        [controller setConfig:_config];
        [self.navigationController presentViewController:controller animated:YES completion:nil];
    }
}

@end

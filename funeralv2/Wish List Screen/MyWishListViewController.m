//
//  MyWishListViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 27/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "MyWishListViewController.h"
#import "CreateMyWishListViewController.h"
#import "MyWishListSavedViewController.h"

@interface MyWishListViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *sideMenuButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *createWishListButton;

@end

@implementation MyWishListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [HelperClass dashboardSetup:_config.statusBarColour red:[_config.colourRed floatValue] green:[_config.colourGreen floatValue] blue:[_config.colourBlue floatValue] backgroundImageView:_backgroundImageView sideMenuButton:_sideMenuButton closeButton:nil backButton:nil addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:_createWishListButton saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createMyWishList:(id)sender
{
    if([[UIScreen mainScreen] bounds].size.height <= 480.0)
    {
        CreateMyWishListViewController *controller = [[CreateMyWishListViewController alloc] initWithNibName:@"CreateMyWishListViewController_35" bundle:nil];
        [controller setConfig:_config];
        [controller setCaller:self];
        [self.navigationController presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        CreateMyWishListViewController *controller = [[CreateMyWishListViewController alloc] initWithNibName:@"CreateMyWishListViewController" bundle:nil];
        [controller setConfig:_config];
        [controller setCaller:self];
        [self.navigationController presentViewController:controller animated:YES completion:nil];
    }
}

-(void)displaySavedWishList{
    
    if([[UIScreen mainScreen] bounds].size.height <= 480.0)
    {
        BOOL wishListSaved = [UserDefault boolForKey:@"wishListSaved"];
        
        if (wishListSaved) {
            MyWishListSavedViewController *controller = [[MyWishListSavedViewController alloc] initWithNibName:@"MyWishListSavedViewController_35" bundle:nil];
            [controller setConfig:_config];
            self.sideMenuViewController.contentViewController = [[UINavigationController alloc] initWithRootViewController:controller];
            
        }
    }else{
        BOOL wishListSaved = [UserDefault boolForKey:@"wishListSaved"];
        
        if (wishListSaved) {
            MyWishListSavedViewController *controller = [[MyWishListSavedViewController alloc] initWithNibName:@"MyWishListSavedViewController" bundle:nil];
            [controller setConfig:_config];
            self.sideMenuViewController.contentViewController = [[UINavigationController alloc] initWithRootViewController:controller];

        }
    }
}

@end

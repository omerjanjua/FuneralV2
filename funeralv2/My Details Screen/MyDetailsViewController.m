//
//  MyDetailsViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 22/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "MyDetailsViewController.h"
#import "CreateMyDetailsViewController.h"
#import "MySavedDetailsViewController.h"

@interface MyDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *sideMenuButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *createMyDetailsButton;

@end

@implementation MyDetailsViewController

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

    [HelperClass dashboardSetup:_config.statusBarColour red:[_config.colourRed floatValue] green:[_config.colourGreen floatValue] blue:[_config.colourBlue floatValue] backgroundImageView:_backgroundImageView sideMenuButton:_sideMenuButton closeButton:nil backButton:nil addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:_createMyDetailsButton saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createMyDetails:(id)sender
{
    if([[UIScreen mainScreen] bounds].size.height <= 480.0)
    {
        CreateMyDetailsViewController *controller = [[CreateMyDetailsViewController alloc] initWithNibName:@"CreateMyDetailsViewController_35" bundle:nil];
        [controller setConfig:_config];
        [controller setCaller:self];
        [self.navigationController presentViewController:[[UINavigationController alloc] initWithRootViewController:controller] animated:YES completion:nil];
    }
        else
    {
        CreateMyDetailsViewController *controller = [[CreateMyDetailsViewController alloc] initWithNibName:@"CreateMyDetailsViewController" bundle:nil];
        [controller setConfig:_config];
        [controller setCaller:self];
        [self.navigationController presentViewController:[[UINavigationController alloc] initWithRootViewController:controller] animated:YES completion:nil];
    }
}

-(void)displaySavedDetails{
    
    if([[UIScreen mainScreen] bounds].size.height <= 480.0)
    {
        BOOL wishListSaved = [UserDefault boolForKey:@"detailsSaved"];
        
        if (wishListSaved) {
            MySavedDetailsViewController *controller = [[MySavedDetailsViewController alloc] initWithNibName:@"MySavedDetailsViewController_35" bundle:nil];
            [controller setConfig:_config];
            self.sideMenuViewController.contentViewController = [[UINavigationController alloc] initWithRootViewController:controller];
            
        }
    }else{
        BOOL wishListSaved = [UserDefault boolForKey:@"detailsSaved"];
        
        if (wishListSaved) {
            MySavedDetailsViewController *controller = [[MySavedDetailsViewController alloc] initWithNibName:@"MySavedDetailsViewController" bundle:nil];
            [controller setConfig:_config];
            self.sideMenuViewController.contentViewController = [[UINavigationController alloc] initWithRootViewController:controller];
            
        }
    }
}

@end

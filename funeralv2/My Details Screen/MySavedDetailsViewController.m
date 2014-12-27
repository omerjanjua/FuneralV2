//
//  MySavedDetailsViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 24/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "MySavedDetailsViewController.h"
#import "CreateMyDetailsViewController.h"
#import "JSON.h"

@interface MySavedDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *sideMenuButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *sendMyDetailsButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *streetNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityTowmLabel;
@property (weak, nonatomic) IBOutlet UILabel *countyLabel;
@property (weak, nonatomic) IBOutlet UILabel *postcodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *telephoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *condolenceMessageLabel;

@end

@implementation MySavedDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [HelperClass dashboardSetup:_config.statusBarColour red:[_config.colourRed floatValue] green:[_config.colourGreen floatValue] blue:[_config.colourBlue floatValue] backgroundImageView:_backgroundImageView sideMenuButton:_sideMenuButton closeButton:nil backButton:nil addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:_editButton saveButton:_sendMyDetailsButton todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)viewDidAppear:(BOOL)animated
{
    _nameLabel.text = [UserDefault objectForKey:@"nameTextField"];
    _streetNameLabel.text = [UserDefault objectForKey:@"streetNameTextField"];
    _cityTowmLabel.text = [UserDefault objectForKey:@"cityTowmTextField"];
    _countyLabel.text = [UserDefault objectForKey:@"countyTextField"];
    _postcodeLabel.text = [UserDefault objectForKey:@"postcodeTextField"];
    _telephoneNumberLabel.text = [UserDefault objectForKey:@"telephoneNumberTextField"];
    _emailLabel.text = [UserDefault objectForKey:@"emailTextField"];
    _condolenceMessageLabel.text = [UserDefault objectForKey:@"condolenceMessageTextField"];
}

#pragma mark - Button Interactions
- (IBAction)editButtonPressed:(id)sender
{
    if([[UIScreen mainScreen] bounds].size.height <= 480.0)
    {
        CreateMyDetailsViewController *controller = [[CreateMyDetailsViewController alloc] initWithNibName:@"CreateMyDetailsViewController_35" bundle:nil];
        [controller setConfig:_config];
        [self.navigationController presentViewController:[[UINavigationController alloc] initWithRootViewController:controller] animated:YES completion:nil];
    }
    else
    {
        CreateMyDetailsViewController *controller = [[CreateMyDetailsViewController alloc] initWithNibName:@"CreateMyDetailsViewController" bundle:nil];
        [controller setConfig:_config];
        [self.navigationController presentViewController:[[UINavigationController alloc] initWithRootViewController:controller] animated:YES completion:nil];
    }
}

- (IBAction)sendMyDetailsButtonPressed:(id)sender
{
    //setting the data dictionary for the post request
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //this code below will not post in simulator as the device token will be nil so CMS will throw an error
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:[UserDefault objectForKey:@"deviceToken"], @"token", _nameLabel.text, @"name", _streetNameLabel.text, @"street_name", _cityTowmLabel.text, @"city_town", _countyLabel.text, @"county_state", _postcodeLabel.text, @"postcode", _telephoneNumberLabel.text, @"telephone_number", _emailLabel.text, @"email", nil];
    
    NSMutableDictionary *dataDictionary = [NSMutableDictionary new];
    
    [dataDictionary setValue:dictionary.JSONFragment forKey:@"data"];
    
    [manager POST:[NSString stringWithFormat:@"%@%@%@", Base_URL, _config.appId, Send_MyDetails] parameters:dataDictionary success:^(AFHTTPRequestOperation *operation, id responseObject)
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

-(void)cmsResponse: (NSDictionary *)data
{
    if ([@"OK" isEqualToString:[data objectForKey:@"status"]])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:@"Your details have been sent." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
    }
    else if ([@"Failed" isEqualToString:[data objectForKey:@"status"]])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:[NSString stringWithFormat:@"%@", [data objectForKey:@"message"]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
    }
}

@end

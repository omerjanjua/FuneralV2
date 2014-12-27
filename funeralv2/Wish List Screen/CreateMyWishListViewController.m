//
//  CreateMyWishListViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 27/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "CreateMyWishListViewController.h"

@interface CreateMyWishListViewController () <UIAlertViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *createMyWishListButton;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *nameTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *emailTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *musicTypeTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *typeOfFlowersTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *ceremonyPreferencesTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *remainsTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *funeralPreferenceTextField;

@end

@implementation CreateMyWishListViewController

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
    [HelperClass dashboardSetup:_config.statusBarColour red:[_config.colourRed floatValue] green:[_config.colourGreen floatValue] blue:[_config.colourBlue floatValue] backgroundImageView:_backgroundImageView sideMenuButton:nil closeButton:_closeButton backButton:nil addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:_createMyWishListButton saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
    
    [_nameTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}]];
    [_emailTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Email Address" attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}]];
    [_musicTypeTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Music Type" attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}]];
    [_typeOfFlowersTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Type Of Flowers" attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}]];
    [_ceremonyPreferencesTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Ceremony Preferences" attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}]];
    [_remainsTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Remains" attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}]];
    [_funeralPreferenceTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Funeral Preference" attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}]];
    
    BOOL wishListSaved = [UserDefault boolForKey:@"wishListSaved"];
    if (!wishListSaved) {
        _titleLabel.text = @"My Wishes";
        [_createMyWishListButton setTitle:@"Create A Wish" forState:UIControlStateNormal];
    }
    else
    {
        _titleLabel.text = @"Edit My Wishes";
        [_createMyWishListButton setTitle:@"Save A Wish" forState:UIControlStateNormal];
        
        _nameTextField.text = [UserDefault objectForKey:@"nameWishList"];
        _emailTextField.text = [UserDefault objectForKey:@"emailWishList"];
        _musicTypeTextField.text = [UserDefault objectForKey:@"musicWishList"];
        _typeOfFlowersTextField.text = [UserDefault objectForKey:@"typeOfFlowersWishList"];
        _ceremonyPreferencesTextField.text = [UserDefault objectForKey:@"ceremonyPreferencesWishList"];
        _remainsTextField.text = [UserDefault objectForKey:@"remainsWishList"];
        _funeralPreferenceTextField.text = [UserDefault objectForKey:@"funeralPreferencesWishList"];
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_nameTextField isFirstResponder]) {
        [_emailTextField becomeFirstResponder];
    }
    else if ([_emailTextField isFirstResponder]) {
        [_musicTypeTextField becomeFirstResponder];
    }
    else if ([_musicTypeTextField isFirstResponder]) {
        [_typeOfFlowersTextField becomeFirstResponder];
    }
    else if ([_typeOfFlowersTextField isFirstResponder]) {
        [_ceremonyPreferencesTextField becomeFirstResponder];
    }
    else if ([_ceremonyPreferencesTextField isFirstResponder]) {
        [_remainsTextField becomeFirstResponder];
    }
    else if ([_remainsTextField isFirstResponder]) {
        [_funeralPreferenceTextField becomeFirstResponder];
    }
    else if ([_funeralPreferenceTextField isFirstResponder]) {
        [_funeralPreferenceTextField resignFirstResponder];
    }
    return YES;
}

#pragma mark - Button Interactions
- (IBAction)closeButtonPressed:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Exit" message:@"Are you sure you want to exit without saving? \nAll changes will be lost." delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert show];
}

- (IBAction)createMyWishList:(id)sender
{
    //do a check weather to see if all feilds have been filled in or not
    if (![HelperClass validateNotEmpty:_nameTextField.text] || ![HelperClass validateEmail:_emailTextField.text] || ![HelperClass validateNotEmpty:_musicTypeTextField.text] || ![HelperClass validateNotEmpty:_typeOfFlowersTextField.text] || ![HelperClass validateNotEmpty:_ceremonyPreferencesTextField.text] || ![HelperClass validateNotEmpty:_remainsTextField.text] || ![HelperClass validateNotEmpty:_funeralPreferenceTextField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incomplete" message:@"Please fill out all information & a valid email before saving." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
        [alert show];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:@"Your wish has been saved." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
        
        //setting the tag so later we can determine which view to load either from side menu or nsnotificationcenter
        [UserDefault setBool:YES forKey:@"wishListSaved"];
        
        //Saving object to user defaults to be used later on
        //TODO: refactor this approach to something nicer later on
        [UserDefault setObject:_nameTextField.text forKey:@"nameWishList"];
        [UserDefault setObject:_emailTextField.text forKey:@"emailWishList"];
        [UserDefault setObject:_musicTypeTextField.text forKey:@"musicWishList"];
        [UserDefault setObject:_typeOfFlowersTextField.text forKey:@"typeOfFlowersWishList"];
        [UserDefault setObject:_ceremonyPreferencesTextField.text forKey:@"ceremonyPreferencesWishList"];
        [UserDefault setObject:_remainsTextField.text forKey:@"remainsWishList"];
        [UserDefault setObject:_funeralPreferenceTextField.text forKey:@"funeralPreferencesWishList"];
        [UserDefault synchronize];
        
        //pop the view once post request is successful
        [self dismissViewControllerAnimated:YES completion:^{
            
            if([_caller respondsToSelector:@selector(displaySavedWishList)]){
                [_caller performSelector:@selector(displaySavedWishList) withObject:nil afterDelay:0];
            }
        }];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)displaySavedWishList {
    
}

@end

//
//  CreateMyDetailsViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 27/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "CreateMyDetailsViewController.h"
#import "CondolenceMessageViewController.h"
#import "JVFloatLabeledTextField.h"
#import "KeyboardManager.h"
#import "DashboardViewController.h"

@interface CreateMyDetailsViewController () <UIAlertViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *createMyDetailsButton;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *nameTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *streetNameTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *cityTowmTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *countyTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *postcodeTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *telephoneNumberTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *emailTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *condolenceMessageTextField;

@end

@implementation CreateMyDetailsViewController

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
    [self setupView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    if (!(_condolenceMessage == nil)) {
        _condolenceMessageTextField.text = _condolenceMessage;
    }
}

#pragma mark - Setup View
-(void)setupView
{
    [HelperClass dashboardSetup:_config.statusBarColour red:[_config.colourRed floatValue] green:[_config.colourGreen floatValue] blue:[_config.colourBlue floatValue] backgroundImageView:_backgroundImageView sideMenuButton:nil closeButton:_closeButton backButton:nil addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:_createMyDetailsButton saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    [_nameTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}]];
    [_streetNameTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Street Name" attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}]];
    [_cityTowmTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"City/Town" attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}]];
    [_countyTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"County/State" attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}]];
    [_postcodeTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Postcode/Zip" attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}]];
    [_telephoneNumberTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Telephone Number" attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}]];
    [_emailTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}]];
    [_condolenceMessageTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Condolence Message" attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}]];
    
    BOOL detailsSaved = [UserDefault boolForKey:@"detailsSaved"];
    if (!detailsSaved) {
        _titleLabel.text = @"Create My Details";
        [_createMyDetailsButton setTitle:@"Create My Details" forState:UIControlStateNormal];
        
    }
    else
    {
        _titleLabel.text = @"Edit My Details";
        [_createMyDetailsButton setTitle:@"Save My Details" forState:UIControlStateNormal];
        
        _nameTextField.text = [UserDefault objectForKey:@"nameTextField"];
        _streetNameTextField.text = [UserDefault objectForKey:@"streetNameTextField"];
        _cityTowmTextField.text = [UserDefault objectForKey:@"cityTowmTextField"];
        _countyTextField.text = [UserDefault objectForKey:@"countyTextField"];
        _postcodeTextField.text = [UserDefault objectForKey:@"postcodeTextField"];
        _telephoneNumberTextField.text = [UserDefault objectForKey:@"telephoneNumberTextField"];
        _emailTextField.text = [UserDefault objectForKey:@"emailTextField"];
        _condolenceMessageTextField.text = [UserDefault objectForKey:@"condolenceMessageTextField"];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_nameTextField isFirstResponder]) {
        [_streetNameTextField becomeFirstResponder];
    }
    else if ([_streetNameTextField isFirstResponder]) {
        [_cityTowmTextField becomeFirstResponder];
    }
    else if ([_cityTowmTextField isFirstResponder]) {
        [_countyTextField becomeFirstResponder];
    }
    else if ([_countyTextField isFirstResponder]) {
        [_postcodeTextField becomeFirstResponder];
    }
    else if ([_postcodeTextField isFirstResponder]) {
        [_telephoneNumberTextField becomeFirstResponder];
    }
    else if ([_emailTextField isFirstResponder]) {
        [_condolenceMessageTextField becomeFirstResponder];
    }
    else if ([_condolenceMessageTextField isFirstResponder]) {
        [_condolenceMessageTextField resignFirstResponder];
    }
    return YES;
}

#pragma mark - Button Interactions
- (IBAction)closeButtonPressed:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Exit" message:@"Are you sure you want to exit without saving? \nAll your details will be lost." delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert show];
}

- (IBAction)selectCondolenceMessage:(id)sender
{
    CondolenceMessageViewController *controller = [CondolenceMessageViewController new];
    [controller setConfig:_config];
    [controller setCaller:self];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)createMyDetails:(id)sender
{
    //do a check weather to see if all feilds have been filled in or not
    if (![HelperClass validateNotEmpty:_nameTextField.text] || ![HelperClass validateNotEmpty:_streetNameTextField.text] || ![HelperClass validateNotEmpty:_cityTowmTextField.text] || ![HelperClass validateNotEmpty:_countyTextField.text] || ![HelperClass validateNotEmpty:_postcodeTextField.text] || ![HelperClass validateNotEmpty:_telephoneNumberTextField.text] || ![HelperClass validateNotEmpty:_emailTextField.text] || ![HelperClass validateNotEmpty:_condolenceMessageTextField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incomplete" message:@"Please fill out all information before sending." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
        [alert show];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:@"Your details have been saved." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
        
        //setting the tag so later we can determine which view to load either from side menu or nsnotificationcenter
        [UserDefault setBool:YES forKey:@"detailsSaved"];
        
        //Saving object to user defaults to be used later on
        //TODO: refactor this approach to something nicer later on
        [UserDefault setObject:_nameTextField.text forKey:@"nameTextField"];
        [UserDefault setObject:_streetNameTextField.text forKey:@"streetNameTextField"];
        [UserDefault setObject:_cityTowmTextField.text forKey:@"cityTowmTextField"];
        [UserDefault setObject:_countyTextField.text forKey:@"countyTextField"];
        [UserDefault setObject:_postcodeTextField.text forKey:@"postcodeTextField"];
        [UserDefault setObject:_telephoneNumberTextField.text forKey:@"telephoneNumberTextField"];
        [UserDefault setObject:_emailTextField.text forKey:@"emailTextField"];
        [UserDefault setObject:_condolenceMessageTextField.text forKey:@"condolenceMessageTextField"];
        [UserDefault synchronize];
        
        //pop the view once post request is successful
        [self dismissViewControllerAnimated:YES completion:^{
        
        if([_caller respondsToSelector:@selector(displaySavedDetails)]){
            [_caller performSelector:@selector(displaySavedDetails) withObject:nil afterDelay:0];
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
-(void)condolencePicked:(NSString *)condolenceMessage{
    [self.navigationController popViewControllerAnimated:YES];
    [_condolenceMessageTextField setText:condolenceMessage];
}

-(void)displaySavedDetails {
    
}

@end

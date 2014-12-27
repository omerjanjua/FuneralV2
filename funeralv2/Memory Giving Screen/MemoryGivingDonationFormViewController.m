//
//  MemoryGivingDonationFormViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 23/10/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "MemoryGivingDonationFormViewController.h"
#import "MemoryGivingTermsAndConditionsViewController.h"
#import "XMLDictionary.h"
#import "NSData+MKBase64.h"

@interface MemoryGivingDonationFormViewController () <UITextFieldDelegate, UITextViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *claimGiftAidLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *donationTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressLine1TextField;
@property (weak, nonatomic) IBOutlet UITextField *addressLine2TextField;
@property (weak, nonatomic) IBOutlet UITextField *townTextField;
@property (weak, nonatomic) IBOutlet UITextField *postcodeTextField;
@property (weak, nonatomic) IBOutlet UITextView *tributeMessageTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *taxDeclarationUIView;
@property (weak, nonatomic) IBOutlet UIView *thisIsMoneyUIView;
@property (weak, nonatomic) IBOutlet UIView *noExchangeUIView;
@property (weak, nonatomic) IBOutlet UIView *detailsUIView;
@property (weak, nonatomic) IBOutlet UIView *beAnonymousUIView;
@property (weak, nonatomic) IBOutlet UIView *tributeMessageUIView;
@property (weak, nonatomic) IBOutlet UIView *paymentMethodUIView;

//IBOutlet set to collapse the view correctly if a button is clicked
@property (weak, nonatomic) IBOutlet UIButton *thisIsMyMoneyButton;
@property (weak, nonatomic) IBOutlet UIButton *taxDeclarationButton;
@property (weak, nonatomic) IBOutlet UIButton *noExchangeButton;

@property (weak, nonatomic) IBOutlet UIButton *masterCreditCardButton;
@property (weak, nonatomic) IBOutlet UIButton *masterDebitCardButton;
@property (weak, nonatomic) IBOutlet UIButton *visaCreditCardButton;
@property (weak, nonatomic) IBOutlet UIButton *visaElectronButton;
@property (weak, nonatomic) IBOutlet UIButton *maestroButton;
@property (weak, nonatomic) IBOutlet UIButton *visaDebitOrDeltaButton;

//tags for view positions and sending information to the website set a True/False
@property (assign, nonatomic) NSString *claimGiftAid;
@property (assign, nonatomic) NSString *taxDeclaration;
@property (assign, nonatomic) NSString *thisIsMoney;
@property (assign, nonatomic) NSString *noExchangeAndDetails;
@property (assign, nonatomic) NSString *beAnonymous;
@property (assign, nonatomic) NSString *termsAndConditionsRead;
@property (assign, nonatomic) NSString *paymentType;

@property (assign, nonatomic) float scrollViewHeight;

@end

@implementation MemoryGivingDonationFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [HelperClass dashboardSetup:_config.statusBarColour red:140 green:180 blue:58 backgroundImageView:_backgroundImageView sideMenuButton:nil closeButton:nil backButton:_backButton addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:nil saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    _titleLabel.text = _nameOfDeceased;
    
    [self viewSetUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewSetUp
{
    //scrollview setup for the entire form for 3.5" and 4" devices
    if ([[UIScreen mainScreen] bounds].size.height <= 480.0) {
        [_scrollView setFrame:CGRectMake(0, 64, 320, 416)];
    }
    else
    {
        [_scrollView setFrame:CGRectMake(0, 64, 320, 504)];
    }
    
    //initial launch view set up
    [_taxDeclarationUIView setHidden:YES];
    [_thisIsMoneyUIView setHidden:YES];
    [_noExchangeUIView setHidden:YES];
    [_detailsUIView setHidden:YES];
    [_beAnonymousUIView setHidden:NO];
    [_tributeMessageUIView setHidden:NO];
    [_paymentMethodUIView setHidden:NO];
    
    [_detailsUIView setUserInteractionEnabled:NO];
    [_detailsUIView setAlpha:0.5];
    
    //setting initial values for the global properties
    _claimGiftAid = @"False";
    _taxDeclaration = @"False";
    _thisIsMoney = @"False";
    _noExchangeAndDetails = @"False";
    _beAnonymous = @"False";
    _termsAndConditionsRead = @"False";
    _paymentType = @"";
    _scrollViewHeight = 1046;
    [_scrollView setContentSize:CGSizeMake(320, _scrollViewHeight)];
}

#pragma mark - Button Interactions
- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)claimGiftAidButtonPressed:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        //collapse the next view if the tag is set to True
        if ([_taxDeclaration isEqualToString:@"True"]) {
            [self taxDeclarationButtonPressed:_taxDeclarationButton];
        }
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [_beAnonymousUIView setFrame:CGRectMake(_beAnonymousUIView.frame.origin.x, _beAnonymousUIView.frame.origin.y+236, _beAnonymousUIView.frame.size.width, _beAnonymousUIView.frame.size.height)];
            [_tributeMessageUIView setFrame:CGRectMake(_tributeMessageUIView.frame.origin.x, _tributeMessageUIView.frame.origin.y+236, _tributeMessageUIView.frame.size.width, _tributeMessageUIView.frame.size.height)];
            [_paymentMethodUIView setFrame:CGRectMake(_paymentMethodUIView.frame.origin.x, _paymentMethodUIView.frame.origin.y+236, _paymentMethodUIView.frame.size.width, _paymentMethodUIView.frame.size.height)];
            
            
            _claimGiftAid = @"True";
            [_taxDeclarationUIView setHidden:NO];
            _scrollViewHeight = _scrollViewHeight+236;
            [_scrollView setContentSize:CGSizeMake(320, _scrollViewHeight)];
        } completion:^(BOOL finished) {
            
        }];
        
    }
    else{
        
        //collapse the next view if the tag is set to True
        if ([_taxDeclaration isEqualToString:@"True"]) {
            [self taxDeclarationButtonPressed:_taxDeclarationButton];
        }
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [_beAnonymousUIView setFrame:CGRectMake(_beAnonymousUIView.frame.origin.x, _beAnonymousUIView.frame.origin.y-236, _beAnonymousUIView.frame.size.width, _beAnonymousUIView.frame.size.height)];
            [_tributeMessageUIView setFrame:CGRectMake(_tributeMessageUIView.frame.origin.x, _tributeMessageUIView.frame.origin.y-236, _tributeMessageUIView.frame.size.width, _tributeMessageUIView.frame.size.height)];
            [_paymentMethodUIView setFrame:CGRectMake(_paymentMethodUIView.frame.origin.x, _paymentMethodUIView.frame.origin.y-236, _paymentMethodUIView.frame.size.width, _paymentMethodUIView.frame.size.height)];

            _claimGiftAid = @"False";
            _scrollViewHeight = _scrollViewHeight-236;
            [_scrollView setContentSize:CGSizeMake(320, _scrollViewHeight)];
        } completion:^(BOOL finished) {
            [_taxDeclarationUIView setHidden:YES];
        }];
        
    }
}

- (IBAction)taxDeclarationButtonPressed:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        //collapse the next view if the tag is set to True
        if ([_thisIsMoney isEqualToString:@"True"]) {
            [self thisIsMyMoneyButtonPressed:_thisIsMyMoneyButton];
        }
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [_beAnonymousUIView setFrame:CGRectMake(_beAnonymousUIView.frame.origin.x, _beAnonymousUIView.frame.origin.y+68, _beAnonymousUIView.frame.size.width, _beAnonymousUIView.frame.size.height)];
            [_tributeMessageUIView setFrame:CGRectMake(_tributeMessageUIView.frame.origin.x, _tributeMessageUIView.frame.origin.y+68, _tributeMessageUIView.frame.size.width, _tributeMessageUIView.frame.size.height)];
            [_paymentMethodUIView setFrame:CGRectMake(_paymentMethodUIView.frame.origin.x, _paymentMethodUIView.frame.origin.y+68, _paymentMethodUIView.frame.size.width, _paymentMethodUIView.frame.size.height)];
            
            _taxDeclaration = @"True";
            [_taxDeclarationUIView setHidden:NO];
            [_thisIsMoneyUIView setHidden:NO];
            _scrollViewHeight = _scrollViewHeight+68;
            [_scrollView setContentSize:CGSizeMake(320, _scrollViewHeight)];
        } completion:^(BOOL finished) {
            
        }];
        
    }
    else{
        
        //collapse the next view if the tag is set to True
        if ([_thisIsMoney isEqualToString:@"True"]) {
            [self thisIsMyMoneyButtonPressed:_thisIsMyMoneyButton];
        }
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [_beAnonymousUIView setFrame:CGRectMake(_beAnonymousUIView.frame.origin.x, _beAnonymousUIView.frame.origin.y-68, _beAnonymousUIView.frame.size.width, _beAnonymousUIView.frame.size.height)];
            [_tributeMessageUIView setFrame:CGRectMake(_tributeMessageUIView.frame.origin.x, _tributeMessageUIView.frame.origin.y-68, _tributeMessageUIView.frame.size.width, _tributeMessageUIView.frame.size.height)];
            [_paymentMethodUIView setFrame:CGRectMake(_paymentMethodUIView.frame.origin.x, _paymentMethodUIView.frame.origin.y-68, _paymentMethodUIView.frame.size.width, _paymentMethodUIView.frame.size.height)];
            
            _taxDeclaration = @"False";
            _scrollViewHeight = _scrollViewHeight-68;
            [_scrollView setContentSize:CGSizeMake(320, _scrollViewHeight)];
        } completion:^(BOOL finished) {
            [_thisIsMoneyUIView setHidden:YES];
        }];
        
    }
}

- (IBAction)thisIsMyMoneyButtonPressed:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        //collapse the next view if the tag is set to True
        if ([_noExchangeAndDetails isEqualToString:@"True"]) {
            [self noExchangeButtonPressed:_noExchangeButton];
        }
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [_beAnonymousUIView setFrame:CGRectMake(_beAnonymousUIView.frame.origin.x, _beAnonymousUIView.frame.origin.y+453, _beAnonymousUIView.frame.size.width, _beAnonymousUIView.frame.size.height)];
            [_tributeMessageUIView setFrame:CGRectMake(_tributeMessageUIView.frame.origin.x, _tributeMessageUIView.frame.origin.y+453, _tributeMessageUIView.frame.size.width, _tributeMessageUIView.frame.size.height)];
            [_paymentMethodUIView setFrame:CGRectMake(_paymentMethodUIView.frame.origin.x, _paymentMethodUIView.frame.origin.y+453, _paymentMethodUIView.frame.size.width, _paymentMethodUIView.frame.size.height)];
            
            _thisIsMoney = @"True";
            [_taxDeclarationUIView setHidden:NO];
            [_thisIsMoneyUIView setHidden:NO];
            [_noExchangeUIView setHidden:NO];
            [_detailsUIView setHidden:NO];
            _scrollViewHeight = _scrollViewHeight+453;
            [_scrollView setContentSize:CGSizeMake(320, _scrollViewHeight)];
        } completion:^(BOOL finished) {
            
        }];
        
    }
    else{
        
        //collapse the next view if the tag is set to True
        if ([_noExchangeAndDetails isEqualToString:@"True"]) {
            [self noExchangeButtonPressed:_noExchangeButton];
        }
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [_beAnonymousUIView setFrame:CGRectMake(_beAnonymousUIView.frame.origin.x, _beAnonymousUIView.frame.origin.y-453, _beAnonymousUIView.frame.size.width, _beAnonymousUIView.frame.size.height)];
            [_tributeMessageUIView setFrame:CGRectMake(_tributeMessageUIView.frame.origin.x, _tributeMessageUIView.frame.origin.y-453, _tributeMessageUIView.frame.size.width, _tributeMessageUIView.frame.size.height)];
            [_paymentMethodUIView setFrame:CGRectMake(_paymentMethodUIView.frame.origin.x, _paymentMethodUIView.frame.origin.y-453, _paymentMethodUIView.frame.size.width, _paymentMethodUIView.frame.size.height)];
            
            _thisIsMoney = @"False";
            _scrollViewHeight = _scrollViewHeight-453;
            [_scrollView setContentSize:CGSizeMake(320, _scrollViewHeight)];
        } completion:^(BOOL finished) {
            [_noExchangeUIView setHidden:YES];
            [_detailsUIView setHidden:YES];
        }];
        
    }
}

- (IBAction)noExchangeButtonPressed:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        [_detailsUIView setUserInteractionEnabled:YES];
        [_detailsUIView setAlpha:1];
        _noExchangeAndDetails = @"True";
    }
    else{
        
        [_detailsUIView setUserInteractionEnabled:NO];
        [_detailsUIView setAlpha:0.5];
        _noExchangeAndDetails = @"False";
    }
}

- (IBAction)beAnonymousButtonPressed:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [_paymentMethodUIView setFrame:CGRectMake(_paymentMethodUIView.frame.origin.x, _paymentMethodUIView.frame.origin.y-156, _paymentMethodUIView.frame.size.width, _paymentMethodUIView.frame.size.height)];
            
            _beAnonymous = @"True";
            _scrollViewHeight = _scrollViewHeight-156;
            [_scrollView setContentSize:CGSizeMake(320, _scrollViewHeight)];
        } completion:^(BOOL finished) {
            [_tributeMessageUIView setHidden:YES];
        }];
        
    }
    else{
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [_paymentMethodUIView setFrame:CGRectMake(_paymentMethodUIView.frame.origin.x, _paymentMethodUIView.frame.origin.y+156, _paymentMethodUIView.frame.size.width, _paymentMethodUIView.frame.size.height)];
            
            _beAnonymous = @"False";
            [_tributeMessageUIView setHidden:NO];
            _scrollViewHeight = _scrollViewHeight+156;
            [_scrollView setContentSize:CGSizeMake(320, _scrollViewHeight)];
        } completion:^(BOOL finished) {
        }];
        
    }
}

- (IBAction)masterCreditCardButtonPressed:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        _paymentType = @"ECMC";
        
        _masterDebitCardButton.selected = NO;
        _visaCreditCardButton.selected = NO;
        _visaElectronButton.selected = NO;
        _maestroButton.selected = NO;
        _visaDebitOrDeltaButton.selected = NO;
    }
    else{
        _paymentType = @"";
    }
}

- (IBAction)masterDebitCardButtonPressed:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        _paymentType = @"MSCD";
        
        _masterCreditCardButton.selected = NO;
        _visaCreditCardButton.selected = NO;
        _visaElectronButton.selected = NO;
        _maestroButton.selected = NO;
        _visaDebitOrDeltaButton.selected = NO;
    }
    else{
        _paymentType = @"";
    }
}

- (IBAction)visaCreditCardButtonPressed:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        _paymentType = @"VISA";
        
        _masterCreditCardButton.selected = NO;
        _masterDebitCardButton.selected = NO;
        _visaElectronButton.selected = NO;
        _maestroButton.selected = NO;
        _visaDebitOrDeltaButton.selected = NO;
    }
    else{
        _paymentType = @"";
    }
}

- (IBAction)visaElectronButtonPressed:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        _paymentType = @"VIED";
        
        _masterCreditCardButton.selected = NO;
        _masterDebitCardButton.selected = NO;
        _visaCreditCardButton.selected = NO;
        _maestroButton.selected = NO;
        _visaDebitOrDeltaButton.selected = NO;
    }
    else{
        _paymentType = @"";
    }
}

- (IBAction)maestroButtonPressed:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        _paymentType = @"MAES";
        
        _masterCreditCardButton.selected = NO;
        _masterDebitCardButton.selected = NO;
        _visaCreditCardButton.selected = NO;
        _visaElectronButton.selected = NO;
        _visaDebitOrDeltaButton.selected = NO;
    }
    else{
        _paymentType = @"";
    }
}

- (IBAction)visaDebitOrDeltaButtonPressed:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        _paymentType = @"VISD";
        
        _masterCreditCardButton.selected = NO;
        _masterDebitCardButton.selected = NO;
        _visaCreditCardButton.selected = NO;
        _visaElectronButton.selected = NO;
        _maestroButton.selected = NO;
    }
    else{
        _paymentType = @"";
    }
}

- (IBAction)termsAndConditionsButtonPressed:(id)sender
{
    //stop the view from being pushed onto the stack twice if button is clicked really quickly
    if (self.navigationController.topViewController != self)
        return;
    
    MemoryGivingTermsAndConditionsViewController *controller = [MemoryGivingTermsAndConditionsViewController new];
    [controller setConfig:_config];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)termsAndConditionsReadButtonPressed:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        _termsAndConditionsRead = @"True";
    }
    else{
        _termsAndConditionsRead = @"False";
    }
}

- (IBAction)donateButtonPressed:(id)sender
{
    //validation for first 3 fields
    if (![HelperClass validateNotEmpty:_nameTextField.text] || ![HelperClass validateEmail:_emailTextField.text] || ![HelperClass validateNotEmpty:_donationTextField.text])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incomplete" message:@"Please fill out name, valid email and donation amount" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
        [alert show];
    }
    //validation for the second hidden form only accessible if the tag is set to True
   else if (([_noExchangeAndDetails isEqualToString:@"True"]) && (![HelperClass validateNotEmpty:_firstNameTextField.text] || ![HelperClass validateNotEmpty:_lastNameTextField.text] || ![HelperClass validateNotEmpty:_addressLine1TextField.text] || ![HelperClass validateNotEmpty:_addressLine2TextField.text] || ![HelperClass validateNotEmpty:_townTextField.text] || ![HelperClass validateNotEmpty:_postcodeTextField.text])) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incomplete" message:@"Please fill out all information or unselect no exchange" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
            [alert show];
        }
    //validation for the anonymous block
    else if (([_beAnonymous isEqualToString:@"False"]) && ![HelperClass validateNotEmpty:_tributeMessageTextView.text])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incomplete" message:@"Please fill out a tribute message if you don't want to be anonymous" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
        [alert show];
    }
    //validation for the payment if selected
    else if ([_paymentType isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incomplete" message:@"Please select a payment type" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
        [alert show];
    }
    //validation for the T&C tick
    else if ([_termsAndConditionsRead isEqualToString:@"False"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incomplete" message:@"Please make sure you have the Terms & Conditions Selected" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
        [alert show];
    }
    //if everything passes make the API call
    else
    {
        [self apiCall];
    }
}

-(void)apiCall
{
    //encodes the xml string and open it in safari
    NSString *xmlString =[NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?><donation>"
                        "<display_name>%@</display_name>"
                        "<email>%@</email>"
                        "<donation_amount>%@</donation_amount>"
                        "<gift_aid>%@</gift_aid>"
                        "<uk_tax>%@</uk_tax>"
                        "<my_money>%@</my_money>"
                        "<no_tps_exchange>%@</no_tps_exchange>"
                        "<first_name>%@</first_name>"
                        "<last_name>%@</last_name>"
                        "<address1>%@</address1>"
                        "<address2>%@</address2>"
                        "<town>%@</town>"
                        "<post_code>%@</post_code>"
                        "<anonymous>%@</anonymous>"
                        "<message>%@</message>"
                        "<payment_type>%@</payment_type>"
                        "<accept_t_c>%@</accept_t_c></donation>", _nameTextField.text, _emailTextField.text, _donationTextField.text, _claimGiftAid, _taxDeclaration, _thisIsMoney, _noExchangeAndDetails, _firstNameTextField.text, _lastNameTextField.text, _addressLine1TextField.text, _addressLine2TextField.text, _townTextField.text, _postcodeTextField.text, _beAnonymous, _tributeMessageTextView.text, _paymentType, _termsAndConditionsRead];
    
    NSData *data = [xmlString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *encode = [data base64EncodedString];
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (CFStringRef)encode,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8 ));
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://memorygiving.com/%@?appData=%@",_pageName, encodedString]]];
}

#pragma mark - Text Field Return Key code
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_nameTextField isFirstResponder])
    {
        [_emailTextField becomeFirstResponder];
    }
    else if ([_emailTextField isFirstResponder])
    {
        [_donationTextField becomeFirstResponder];
    }
    
    if ([_firstNameTextField isFirstResponder])
    {
        [_lastNameTextField becomeFirstResponder];
    }
    else if ([_lastNameTextField isFirstResponder])
    {
        [_addressLine1TextField becomeFirstResponder];
    }
    else if ([_addressLine1TextField isFirstResponder])
    {
        [_addressLine2TextField becomeFirstResponder];
    }
    else if ([_addressLine2TextField isFirstResponder])
    {
        [_townTextField becomeFirstResponder];
    }
    else if ([_townTextField isFirstResponder])
    {
        [_postcodeTextField becomeFirstResponder];
    }
    else if ([_postcodeTextField isFirstResponder])
    {
        [_postcodeTextField resignFirstResponder];
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //if donation label is not empty put a £ sign before the textfield value
    //for the claim gift label set the value as 24p per £1 donation from the donation text field
    if ([_donationTextField.text length] != 0) {
        [_donationTextField setText:[NSString stringWithFormat:@"£%@", [_donationTextField.text substringFromIndex:1]]];
        [_claimGiftAidLabel setText:[NSString stringWithFormat:@"+ £%.2f gift aid",[[_donationTextField.text substringFromIndex:1] floatValue]*0.24]];
    }
    
    //if donation label has no price, empty the string so placeholder text is displayed
    if ([_donationTextField.text isEqualToString:@"£"]) {
        [_donationTextField setText:@""];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //when editing if no value enter the £ sign to start with
    if ([_donationTextField.text length] == 0) {
        [_donationTextField setText:@"£"];
    }
}

@end

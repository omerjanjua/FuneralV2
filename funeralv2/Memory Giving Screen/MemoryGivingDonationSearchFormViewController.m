//
//  MemoryGivingDonationSearchFormViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 23/10/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "MemoryGivingDonationSearchFormViewController.h"
#import "MemoryGivingDonationListViewController.h"
#import "XMLDictionary.h"

@interface MemoryGivingDonationSearchFormViewController () <UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *funeralDirectorTextField;
@property (weak, nonatomic) IBOutlet UITextField *charityTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation MemoryGivingDonationSearchFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [HelperClass dashboardSetup:_config.statusBarColour red:140 green:180 blue:58 backgroundImageView:_backgroundImageView sideMenuButton:nil closeButton:nil backButton:_backButton addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:nil saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [_activityIndicator setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Interactions
- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)searchButtonPressed:(id)sender
{
    
    if (![HelperClass validateNotEmpty:_nameTextField.text] && ![HelperClass validateNotEmpty:_funeralDirectorTextField.text] && ![HelperClass validateNotEmpty:_charityTextField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incomplete" message:@"Please fill out all information before searching." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
        [alert show];
    }
    else
    {
        [_activityIndicator setHidden:NO];
        
        NSString *xmlString = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                           "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                           "<soap:Body>"
                           "<search xmlns=\"http://memorygiving.com/admin/api/WebService.asmx\">"
                           "<api_key>915C917E-A299-42AA-8102-F092529FF02B</api_key>"
                           "<deceased_name>%@</deceased_name>"
                           "<funeral_director>%@</funeral_director>"
                           "<charity>%@</charity>"
                           "<show_open>true</show_open>"
                           "<show_closed>true</show_closed>"
                           "</search>"
                           "</soap:Body>"
                           "</soap:Envelope>", _nameTextField.text, _funeralDirectorTextField.text, _charityTextField.text];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://memorygiving.com/admin/api/WebService.asmx?op=search"]];
        
        [request setHTTPBody:[xmlString dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPMethod:@"POST"];
        [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            NSDictionary *dic = [NSDictionary dictionaryWithXMLData:responseObject];
            
            NSMutableArray *arrayData = [[[[[[dic objectForKey:@"soap:Body"] objectForKey:@"searchResponse"] objectForKey:@"searchResult"] objectForKey:@"Data"] objectForKey:@"searchItems"] objectForKey:@"anyType"];
            
            if (arrayData.count != 0)
            {
                MemoryGivingDonationListViewController *controller = [MemoryGivingDonationListViewController new];
                [controller setConfig:_config];
                [controller setArrayData:arrayData];
                [self.navigationController pushViewController:controller animated:YES];
            }
                else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Search Again" message:@"There are no search results.\n Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
                [_activityIndicator setHidden:YES];
            }
            
        }
            failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
            [alert show];
            
            NSLog(@"%@", [error localizedDescription]);
        }];
        
        [operation start];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_nameTextField isFirstResponder])
    {
        [_funeralDirectorTextField becomeFirstResponder];
    }
    else if ([_funeralDirectorTextField isFirstResponder])
    {
        [_charityTextField becomeFirstResponder];
    }
    else if ([_charityTextField isFirstResponder])
    {
        [_charityTextField resignFirstResponder];
    }
    return YES;
}

@end

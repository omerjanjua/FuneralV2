//
//  DashboardCallScreenPopUpViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 30/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "DashboardCallScreenPopUpViewController.h"
#import "ContactData.h"
#import "UIViewController+MJPopupViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DashboardCallScreenPopUpViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *data;

@end

@implementation DashboardCallScreenPopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
    
    [self apiCall];
    
    [HelperClass dashboardSetup:_config.statusBarColour red:[_config.colourRed floatValue] green:[_config.colourGreen floatValue] blue:[_config.colourBlue floatValue] backgroundImageView:_backgroundImageView sideMenuButton:nil closeButton:_closeButton backButton:nil addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:nil saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark View SetUp
-(void)apiCall
{
    //files from the bash scripts are saved into te nsbundle
    //files from the bundle are copied into the documents directory in the app delegate
    //locate the file saved in documents directory
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@%@%@", Base_URL, _config.appId, Get_Location] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //if internet get the data from the live end point and copy that over the model
         _data = [MTLJSONAdapter modelsOfClass:[ContactData class] fromJSONArray:[responseObject objectForKey:@"matches"] error:nil];
         [_tableView reloadData];
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //if not internet, copy the data from the documents directory to the data model
         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
         NSString *documentsDirectoryPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"location.json"];
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:documentsDirectoryPath] options:NSJSONReadingMutableContainers error:nil];
         _data = [MTLJSONAdapter modelsOfClass:[ContactData class] fromJSONArray:[dic objectForKey:@"matches"] error:nil];
         [_tableView reloadData];
     }];
}

- (IBAction)closeButtonPressed:(id)sender
{
    [_caller dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

#pragma mark UITableView Datasource and Delegates
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16]];
        [cell.textLabel setTextColor:[UIColor darkTextColor]];
        cell.textLabel.numberOfLines = 0;
        if (indexPath.row % 2) {
            cell.contentView.backgroundColor = [[UIColor alloc]initWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];
        } else {
            cell.contentView.backgroundColor = [[UIColor alloc]initWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
        }
    }
    
    //display information in labels
    cell.textLabel.text = [[_data objectAtIndex:indexPath.row] name];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSString *newPhoneString = [[_data objectAtIndex:indexPath.row] telephone];
    
    newPhoneString = [newPhoneString stringByReplacingOccurrencesOfString:@"(" withString:@""];
    newPhoneString = [newPhoneString stringByReplacingOccurrencesOfString:@")" withString:@""];
    newPhoneString = [newPhoneString stringByReplacingOccurrencesOfString:@" " withString:@""];
    newPhoneString = [newPhoneString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    if ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"] )
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", newPhoneString]]];
    }
    else
    {
        UIAlertView *warning =[[UIAlertView alloc] initWithTitle:_config.appName message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warning show];
    }
}

@end

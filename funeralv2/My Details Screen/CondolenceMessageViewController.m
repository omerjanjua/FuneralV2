//
//  CondolenceMessageViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 28/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "CondolenceMessageViewController.h"
#import "CreateMyDetailsViewController.h"

@interface CondolenceMessageViewController () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSArray *data;

@end

@implementation CondolenceMessageViewController

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

#pragma mark - Setup View
-(void)setupView
{
    [HelperClass dashboardSetup:_config.statusBarColour red:[_config.colourRed floatValue] green:[_config.colourGreen floatValue] blue:[_config.colourBlue floatValue] backgroundImageView:_backgroundImageView sideMenuButton:nil closeButton:nil backButton:_backButton addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:nil saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
    
    [self apiCall];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

#pragma mark - Button Interactions
- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)apiCall
{
    //files from the bash scripts are saved into te nsbundle
    //files from the bundle are copied into the documents directory in the app delegate
    //locate the file saved in documents directory
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@%@%@", Base_URL, _config.appId, Get_Condolence_Message] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //if internet get the data from the live end point and copy that over the model
         _data = [responseObject objectForKey:@"condolence_messages"];
         [_tableView reloadData];
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //if not internet, copy the data from the documents directory to the data model
         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
         NSString *documentsDirectoryPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"condolence.json"];
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:documentsDirectoryPath] options:NSJSONReadingMutableContainers error:nil];
         _data = [dic objectForKey:@"condolence_messages"];
         [_tableView reloadData];
     }];
}

#pragma mark - Setup Table View
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:17]];
        [cell.textLabel setTextColor:[UIColor darkTextColor]];
        cell.textLabel.numberOfLines = 0;
        if (indexPath.row % 2) {
            cell.contentView.backgroundColor = [[UIColor alloc]initWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];
        } else {
            cell.contentView.backgroundColor = [[UIColor alloc]initWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
        }
    }

    cell.textLabel.text = [_data objectAtIndex:indexPath.row];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_caller respondsToSelector:@selector(condolencePicked:)]) {
        [_caller performSelector:@selector(condolencePicked:) withObject:[_data objectAtIndex:indexPath.row] afterDelay:0];
    }
    
}

@end

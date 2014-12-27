//
//  MemoryGivingDonationListViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 23/10/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "MemoryGivingDonationListViewController.h"
#import "MemoryGivingDonationViewController.h"
#import "MemoryGivingTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "XMLDictionary.h"

@interface MemoryGivingDonationListViewController () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MemoryGivingDonationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"MemoryGivingTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [HelperClass dashboardSetup:_config.statusBarColour red:140 green:180 blue:58 backgroundImageView:_backgroundImageView sideMenuButton:nil closeButton:nil backButton:_backButton addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:nil saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
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

#pragma mark - TableView DataSource & Delegates
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrayData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemoryGivingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (indexPath.row % 2) {
        cell.contentView.backgroundColor = [[UIColor alloc]initWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];
    } else {
        cell.contentView.backgroundColor = [[UIColor alloc]initWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
    }
    
    cell.titleLabel.text = [HelperClass removeSpanTags:[[_arrayData objectAtIndex:indexPath.row] objectForKey:@"name"]];
    cell.funeralLabel.text = [HelperClass removeSpanTags:[[_arrayData objectAtIndex:indexPath.row] objectForKey:@"funeral_director"]];
    cell.charityLabel.text = [HelperClass removeSpanTags:[[_arrayData objectAtIndex:indexPath.row] objectForKey:@"charity"]];
    
    [cell.image setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@", [[_arrayData objectAtIndex:indexPath.row] objectForKey:@"cropped_photo_path"]]] placeholderImage:[UIImage imageNamed:@"products-placeholder-icon"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *xmlString = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                     "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                     "<soap:Body>"
                     "<loadTributeById xmlns=\"http://memorygiving.com/admin/api/WebService.asmx\">"
                     "<api_key>915C917E-A299-42AA-8102-F092529FF02B</api_key>"
                     "<tribute_id>%@</tribute_id>"
                     "</loadTributeById>"
                     "</soap:Body>"
                     "</soap:Envelope>",[[_arrayData objectAtIndex:indexPath.row] objectForKey:@"id"]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://memorygiving.com/admin/api/WebService.asmx?op=loadTributeById"]];
    
    [request setHTTPBody:[xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue: [NSString stringWithFormat:@"%lu",(unsigned long)[xmlString dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *dic = [NSDictionary dictionaryWithXMLData:responseObject];
         
         NSMutableDictionary *arrayData = [[[[dic objectForKey:@"soap:Body"] objectForKey:@"loadTributeByIdResponse"] objectForKey:@"loadTributeByIdResult"] objectForKey:@"Data"];
         
         if (arrayData.count != 0)
         {
             MemoryGivingDonationViewController *controller = [MemoryGivingDonationViewController new];
             [controller setConfig:_config];
             [controller setArrayData:arrayData];
             [self.navigationController pushViewController:controller animated:YES];
         }
         else
         {
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Search Error" message:@"There is no search results.\n Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
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

@end

//
//  MemoryGivingMenuViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 23/10/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "MemoryGivingMenuViewController.h"
#import "MemoryGivingTableViewCell.h"
#import "MemoryGivingAboutUsViewController.h"
#import "MemoryGivingContactUsViewController.h"
#import "MemoryGivingDonationSearchFormViewController.h"
#import "MemoryGivingOurPromiseViewController.h"

@interface MemoryGivingMenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *sideMenuButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSArray *data;
@property (strong, nonatomic) NSArray *imagesArray;

@end

@implementation MemoryGivingMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"MemoryGivingTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [HelperClass dashboardSetup:_config.statusBarColour red:[_config.colourRed floatValue] green:[_config.colourGreen floatValue] blue:[_config.colourBlue floatValue] backgroundImageView:_backgroundImageView sideMenuButton:_sideMenuButton closeButton:nil backButton:nil addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:nil saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
    
    _data = @[@"About Us", @"Contact Us",  @"Donations", @"Our Promise"];
    
    _imagesArray = @[@"memory-giving-about-us-icon", @"memory-giving-contact-us-icon",  @"memory-giving-donation-icon", @"memory-giving-our-promise-icon"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView DataSource & Delegates
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_data count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemoryGivingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (indexPath.row % 2) {
        cell.contentView.backgroundColor = [[UIColor alloc]initWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];
    } else {
        cell.contentView.backgroundColor = [[UIColor alloc]initWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
    }
    
    cell.titleLabel.text = _data[indexPath.row];
    cell.image.image = [UIImage imageNamed:_imagesArray[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    if (indexPath.row == 0)
    {
        MemoryGivingAboutUsViewController *controller = [MemoryGivingAboutUsViewController new];
        [controller setConfig:_config];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if (indexPath.row == 1)
    {
        MemoryGivingContactUsViewController *controller = [MemoryGivingContactUsViewController new];
        [controller setConfig:_config];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if (indexPath.row == 2)
    {
        MemoryGivingDonationSearchFormViewController *controller = [MemoryGivingDonationSearchFormViewController new];
        [controller setConfig:_config];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if (indexPath.row == 3)
    {
        MemoryGivingOurPromiseViewController *controller = [MemoryGivingOurPromiseViewController new];
        [controller setConfig:_config];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}

@end

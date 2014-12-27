//
//  MemoryGivingDonationViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 23/10/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "MemoryGivingDonationViewController.h"
#import "MemoryGivingDonationFormViewController.h"
#import "MemoryGivingDonationTableViewCell.h"

@interface MemoryGivingDonationViewController () <UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageThumbnail;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIImageView *funeralHomeImage;
@property (weak, nonatomic) IBOutlet UILabel *funeralDescription;
@property (weak, nonatomic) IBOutlet UILabel *funeralTelephone;
@property (weak, nonatomic) IBOutlet UILabel *funeralEmail;
@property (weak, nonatomic) IBOutlet UIImageView *charityImage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *giftAidPotentialLabel;


@property (nonatomic, strong) MemoryGivingDonationTableViewCell *prototypeCell;

@end

@implementation MemoryGivingDonationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"MemoryGivingDonationTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [HelperClass dashboardSetup:_config.statusBarColour red:140 green:180 blue:58 backgroundImageView:_backgroundImageView sideMenuButton:nil closeButton:nil backButton:_backButton addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:nil saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    //scrollview setup for the entire form for 3.5" and 4" devices
    if ([[UIScreen mainScreen] bounds].size.height <= 480.0) {
        [_scrollView setFrame:CGRectMake(0, 64, 320, 416)];
    }
    else
    {
        [_scrollView setFrame:CGRectMake(0, 64, 320, 504)];
    }
    
    [_imageThumbnail setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",[_arrayData objectForKey:@"cropped_photo_thumb_path"]]]]]];
    
    [_nameLabel setText:[_arrayData objectForKey:@"name"]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    [formatter setAMSymbol:@"am"];
    [formatter setPMSymbol:@"pm"];
    
    NSDate *date = [formatter dateFromString:[_arrayData objectForKey:@"date_of_death"]];
    [formatter setDateFormat:@"dd MMMM yyyy"];
    
    [_dateLabel setText:[NSString stringWithFormat:@"Age %@, %@", [_arrayData objectForKey:@"age"], [formatter stringFromDate:date]]];
    
    [_descriptionTextView setText:[_arrayData objectForKey:@"message"]];
    
    [_funeralHomeImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",[[_arrayData objectForKey:@"funeral_director"] objectForKey:@"cropped_logo_path"]]]]]];
    
    [_funeralDescription setText:[[_arrayData objectForKey:@"funeral_director"] objectForKey:@"description"]];
    
    [_funeralTelephone setText:[[_arrayData objectForKey:@"funeral_director"] objectForKey:@"telephone"]];
    
    [_funeralEmail setText:[[_arrayData objectForKey:@"funeral_director"] objectForKey:@"contact_email"]];
    
    [_charityImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",[[_arrayData objectForKey:@"charity"] objectForKey:@"cropped_logo_path"]]]]]];
    
    [_totalPriceLabel setText:[NSString stringWithFormat:@"£%@", [_arrayData objectForKey:@"donations_total"]]];
    
    [_giftAidPotentialLabel setText:[NSString stringWithFormat:@"£%@", [_arrayData objectForKey:@"gift_aid_total"]] ];
    
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

- (IBAction)donateButtonPressed:(id)sender
{
    MemoryGivingDonationFormViewController *controller = [MemoryGivingDonationFormViewController new];
    [controller setConfig:_config];
    [controller setNameOfDeceased:[_arrayData objectForKey:@"name"]];
    [controller setPageName:[_arrayData objectForKey:@"page_name"]];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - UITableView Delegates & Datasources
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[_arrayData objectForKey:@"donations"] objectForKey:@"anyType"] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [[_arrayData objectForKey:@"donations"] objectForKey:@"anyType"];
    
    MemoryGivingDonationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    cell.donationAmountLabel.text = [NSString stringWithFormat:@"£%@ (+£%@ gift aid)", [[array objectAtIndex:indexPath.row] objectForKey:@"donation"] , [[array objectAtIndex:indexPath.row] objectForKey:@"value_gift_aid"]];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ online donation", [[array objectAtIndex:indexPath.row] objectForKey:@"display_name"]];
    cell.messageLabel.text = [[array objectAtIndex:indexPath.row] objectForKey:@"message"];
    
//    NSString *string = [NSString stringWithFormat:@"%@ online donation", [[array objectAtIndex:indexPath.row] objectForKey:@"display_name"]];
//    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:_nameLabel.attributedText];
//    NSRange range = [string rangeOfString:@"online donation"];
//    [text addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(range.location, range.length)];
//    [cell.nameLabel setAttributedText:text];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    [formatter setAMSymbol:@"am"];
    [formatter setPMSymbol:@"pm"];
    
    NSDate *date = [formatter dateFromString:[[array objectAtIndex:indexPath.row] objectForKey:@"date_donation"]];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    [cell.donationDateLabel setText:[formatter stringFromDate:date]];
    
    return cell;
}

- (MemoryGivingDonationTableViewCell *)prototypeCell
{
    if (!_prototypeCell)
    {
        _prototypeCell = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
    }
    return _prototypeCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [[_arrayData objectForKey:@"donations"] objectForKey:@"anyType"];
    
    
    [self prototypeCell].donationAmountLabel.text = [NSString stringWithFormat:@"£%@ (+£%@ gift aid)", [[array objectAtIndex:indexPath.row] objectForKey:@"donation"] , [[array objectAtIndex:indexPath.row] objectForKey:@"value_gift_aid"]];
    [self prototypeCell].nameLabel.text = [NSString stringWithFormat:@"%@ online donation", [[array objectAtIndex:indexPath.row] objectForKey:@"display_name"]];
    [self prototypeCell].messageLabel.text = [[array objectAtIndex:indexPath.row] objectForKey:@"message"];
    [self prototypeCell].donationDateLabel.text = [[array objectAtIndex:indexPath.row] objectForKey:@"date_donation"];
    
    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height+1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

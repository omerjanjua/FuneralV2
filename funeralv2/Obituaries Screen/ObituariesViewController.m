//
//  ObituariesViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 21/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "ObituariesViewController.h"
#import "ObituariesTableViewCell.h"
#import "ObituariesData.h"
#import "UIImageView+AFNetworking.h"

@interface ObituariesViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>{
    MFMailComposeViewController *mailController;
}

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *sideMenuButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (retain, nonatomic) NSArray *data;
@property (retain, nonatomic) NSMutableArray *filteredArray;

@end

@implementation ObituariesViewController

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
    
    
    UINib *nib = [UINib nibWithNibName:@"ObituariesTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [_searchBar setBackgroundImage:[UIImage new]];
    [_searchBar setTranslucent:YES];
    
    [HelperClass dashboardSetup:_config.statusBarColour red:[_config.colourRed floatValue] green:[_config.colourGreen floatValue] blue:[_config.colourBlue floatValue] backgroundImageView:_backgroundImageView sideMenuButton:_sideMenuButton closeButton:nil backButton:nil addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:nil saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
    
    [self apiCall];
    
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup View
-(void)apiCall
{
    //files from the bash scripts are saved into te nsbundle
    //files from the bundle are copied into the documents directory in the app delegate
    //locate the file saved in documents directory
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@%@%@", Base_URL, _config.appId, Get_Obituaries] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //if internet get the data from the live end point and copy that over the model
         _data = [MTLJSONAdapter modelsOfClass:[ObituariesData class] fromJSONArray:[responseObject objectForKey:@"matches"] error:nil];
         _filteredArray = [[NSMutableArray alloc] initWithArray:_data];
         [_tableView reloadData];
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //if not internet, copy the data from the documents directory to the data model
         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
         NSString *documentsDirectoryPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"items.json"];
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:documentsDirectoryPath] options:NSJSONReadingMutableContainers error:nil];
         _data = [MTLJSONAdapter modelsOfClass:[ObituariesData class] fromJSONArray:[dic objectForKey:@"matches"] error:nil];
         _filteredArray = [[NSMutableArray alloc] initWithArray:_data];
         [_tableView reloadData];
     }];
}

#pragma mark - Setup Table View
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_filteredArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self basicCellAtIndexPath:indexPath];
}

- (ObituariesTableViewCell *)basicCellAtIndexPath:(NSIndexPath *)indexPath {
    ObituariesTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setController:self];
    [self configureBasicCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureBasicCell:(ObituariesTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [cell setConfig:_config];
    
    if (indexPath.row % 2) {
        cell.contentView.backgroundColor = [[UIColor alloc]initWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];
    } else {
        cell.contentView.backgroundColor = [[UIColor alloc]initWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
    }
    
    cell.titleLabel.text = [[_filteredArray objectAtIndex:indexPath.row] title];
    cell.descriptionLabel.text = [HelperClass stringByStrippingHTML:[[_filteredArray objectAtIndex:indexPath.row] description]];
    
    
    if ([[_filteredArray objectAtIndex:indexPath.row] obituaryDate] == NULL) {
        cell.dateLabel.text = @"";
    }
    else {
        NSDateFormatter *formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [formatter dateFromString:[[_filteredArray objectAtIndex:indexPath.row] obituaryDate]];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        cell.dateLabel.text = [NSString stringWithFormat:@"Funeral Date: %@", [formatter stringFromDate:date]];
    }
    
    [cell.obituaryImage setImageWithURL:[NSURL URLWithString:[[_data objectAtIndex:indexPath.row] imageUrl]] placeholderImage:[UIImage imageNamed:@"obituaries-placeholder-icon"]];
    cell.obituaryImage.layer.cornerRadius = cell.obituaryImage.bounds.size.width / 2.0;
    cell.obituaryImage.layer.masksToBounds = YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForBasicCellAtIndexPath:indexPath];
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static ObituariesTableViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
    });
    
    [self configureBasicCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell
{
    [sizingCell layoutIfNeeded];
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Setup Search
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _filteredArray = [[NSMutableArray alloc] initWithArray:_data];
    [_tableView reloadData];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([@"" isEqualToString:[searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]])
    {
        _filteredArray = nil;
        _filteredArray = [[NSMutableArray alloc] initWithArray:_data];
        [_tableView reloadData];
    }
    else
    {
        _filteredArray = nil;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title CONTAINS[c]  %@", _searchBar.text];
        _filteredArray = [NSMutableArray arrayWithArray:[_data filteredArrayUsingPredicate:predicate]];
        [_tableView reloadData];
    }
}

#pragma mark - Setup Email
-(void)showEmailController:(NSString *)testString
{
    NSMutableString *emailBody = [[NSMutableString alloc] initWithString:@"<html><body>"];
    [emailBody appendString:[NSString stringWithFormat:@"<p>%@</p><p>I am using the %@ app, download it free from the AppStore!</p> <p>%@</p>", testString, _config.appName, _config.appleAppUrl]];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_config.iconImageUrl]]];
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
    
    //adding the base64 image data to the email body
    NSString *base64String = [imageData base64EncodedStringWithOptions:0];
    [emailBody appendString:[NSString stringWithFormat:@"<p><b><img src='data:image/png;base64,%@'></b></p>", base64String]];
    [emailBody appendString:@"</body></html>"];
    
    //initiating the mfmailviewcontroller modally
    mailController = [MFMailComposeViewController new];
    mailController.mailComposeDelegate = self;
    [mailController setSubject:[NSString stringWithFormat:@"%@", _config.appName]];
    [mailController setMessageBody:emailBody isHTML:YES];
    [self presentViewController:mailController animated:YES completion:nil];
}
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{    
    if (result == MFMailComposeResultSent)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:@"Message Sent Successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
    }
    else if (result == MFMailComposeResultFailed)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        mailController = nil;
    }];
}

@end

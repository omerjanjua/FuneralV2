//
//  ProductsViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 21/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "ProductsViewController.h"
#import "ProductsTableViewCell.h"
#import "ProductCategory.h"
#import "ProductsCategoryViewController.h"
#import "ProductsItemViewController.h"
#import "ProductItem.h"
#import "ProductsDetailedNoImageViewController.h"
#import "ProductsDetailedViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProductsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *sideMenuButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSArray *data;

@end

@implementation ProductsViewController

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
    
    UINib *nib = [UINib nibWithNibName:@"ProductsTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [HelperClass dashboardSetup:_config.statusBarColour red:[_config.colourRed floatValue] green:[_config.colourGreen floatValue] blue:[_config.colourBlue floatValue] backgroundImageView:_backgroundImageView sideMenuButton:_sideMenuButton closeButton:nil backButton:nil addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:nil saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
    
    [self apiCall];
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
    [manager GET:[NSString stringWithFormat:@"%@%@%@", Base_URL, _config.appId, Get_Products] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //if internet get the data from the live end point and copy that over the model
         _data = [MTLJSONAdapter modelsOfClass:[ProductCategory class] fromJSONArray:[responseObject objectForKey:@"matches"] error:nil];
         [_tableView reloadData];
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //if not internet, copy the data from the documents directory to the data model
         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
         NSString *documentsDirectoryPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"products.json"];
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:documentsDirectoryPath] options:NSJSONReadingMutableContainers error:nil];
         _data = [MTLJSONAdapter modelsOfClass:[ProductCategory class] fromJSONArray:[dic objectForKey:@"matches"] error:nil];
         [_tableView reloadData];
     }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_data count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (indexPath.row % 2) {
        cell.contentView.backgroundColor = [[UIColor alloc]initWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];
    } else {
        cell.contentView.backgroundColor = [[UIColor alloc]initWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
    }
    
    cell.titleLabel.text = [[_data objectAtIndex:indexPath.row] title];
    
    [cell.productImage setImageWithURL:[NSURL URLWithString:[[_data objectAtIndex:indexPath.row] imageUrl]] placeholderImage:[UIImage imageNamed:@"products-placeholder-icon"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ProductCategory *selectedProduct = _data[indexPath.row];
    
    if ([selectedProduct.categories count] > 0)
    {
        ProductsCategoryViewController *controller = [ProductsCategoryViewController new];
        [controller setData:selectedProduct.categories];
        [controller setConfig:_config];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if ([selectedProduct.products count] > 0)
    {
        ProductsItemViewController *controller = [ProductsItemViewController new];
        [controller setData:selectedProduct.products];
        [controller setConfig:_config];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end

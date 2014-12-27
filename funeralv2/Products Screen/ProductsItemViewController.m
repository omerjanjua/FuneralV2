//
//  ProductsItemViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 10/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "ProductsItemViewController.h"
#import "ProductsItemTableViewCell.h"
#import "ProductItem.h"
#import "ProductsDetailedViewController.h"
#import "ProductsDetailedNoImageViewController.h"
#import "ProductsUIWebViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProductsItemViewController () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ProductsItemViewController

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
    
    UINib *nib = [UINib nibWithNibName:@"ProductsItemTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [HelperClass dashboardSetup:_config.statusBarColour red:[_config.colourRed floatValue] green:[_config.colourGreen floatValue] blue:[_config.colourBlue floatValue] backgroundImageView:_backgroundImageView sideMenuButton:nil closeButton:nil backButton:_backButton addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:nil saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table View Setup
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_data count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductItem *productData = _data[indexPath.row];
    
    ProductsItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (indexPath.row % 2) {
        cell.contentView.backgroundColor = [[UIColor alloc]initWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];
    } else {
        cell.contentView.backgroundColor = [[UIColor alloc]initWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
    }
    
    cell.titleLabel.text = productData.title;
    
    cell.descriptionLabel.text = [HelperClass stringByStrippingHTML:productData.description];
    
    cell.priceLabel.text = [NSString stringWithFormat:@"%@ %@", [HelperClass CMSResponseSetCurrencySign:_config.countrySettings price:productData.price],productData.price];
    
    [cell.productImage setImageWithURL:[NSURL URLWithString:productData.imageUrl] placeholderImage:[UIImage imageNamed:@"products-placeholder-icon"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (self.navigationController.topViewController != self)
        return;
    
    ProductItem *productData = _data[indexPath.row];
   
    if (![productData.websiteUrl isEqualToString:@""])
    {
        ProductsUIWebViewController *controller = [[ProductsUIWebViewController alloc] initWithURL:[NSURL URLWithString:productData.websiteUrl]];
        controller.config = _config;
        [self.navigationController pushViewController:controller animated:YES];
        
    }
    
    else if ([productData.imageUrl isEqualToString:@""] && [productData.imageUrl2 isEqualToString:@""] && [productData.imageUrl3 isEqualToString:@""] && [productData.imageUrl4 isEqualToString:@""])
    {
        ProductsDetailedNoImageViewController *controller = [ProductsDetailedNoImageViewController new];
        [controller setConfig:_config];
        controller.name = productData.title;
        controller.description = productData.description;
        controller.price = productData.price;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else
    {
        if([[UIScreen mainScreen] bounds].size.height <= 480.0)
        {
            NSMutableArray *tempArray = [NSMutableArray new];
            if (![productData.imageUrl isEqualToString:@""]) {
                [tempArray addObject:productData.imageUrl];
            }
            if (![productData.imageUrl2 isEqualToString:@""]) {
                [tempArray addObject:productData.imageUrl2];
            }
            if (![productData.imageUrl3 isEqualToString:@""]) {
                [tempArray addObject:productData.imageUrl3];
            }
            if (![productData.imageUrl4 isEqualToString:@""]) {
                [tempArray addObject:productData.imageUrl4];
            }
            
            ProductsDetailedViewController *controller = [[ProductsDetailedViewController alloc] initWithNibName:@"ProductsDetailedViewController_35" bundle:nil];
            [controller setConfig:_config];
            controller.name = productData.title;
            controller.description = productData.description;
            controller.price = productData.price;
            controller.imageUrl = productData.imageUrl;
            controller.imageUrl2 = productData.imageUrl2;
            controller.imageUrl3 = productData.imageUrl3;
            controller.imageUrl4 = productData.imageUrl4;
            controller.data = tempArray;
            [self.navigationController pushViewController:controller animated:YES];
        }
            else
        {
            NSMutableArray *tempArray = [NSMutableArray new];
            if (![productData.imageUrl isEqualToString:@""]) {
                [tempArray addObject:productData.imageUrl];
            }
            if (![productData.imageUrl2 isEqualToString:@""]) {
                [tempArray addObject:productData.imageUrl2];
            }
            if (![productData.imageUrl3 isEqualToString:@""]) {
                [tempArray addObject:productData.imageUrl3];
            }
            if (![productData.imageUrl4 isEqualToString:@""]) {
                [tempArray addObject:productData.imageUrl4];
            }
            
            ProductsDetailedViewController *controller = [[ProductsDetailedViewController alloc] initWithNibName:@"ProductsDetailedViewController" bundle:nil];
            [controller setConfig:_config];
            controller.name = productData.title;
            controller.description = productData.description;
            controller.price = productData.price;
            controller.imageUrl = productData.imageUrl;
            controller.imageUrl2 = productData.imageUrl2;
            controller.imageUrl3 = productData.imageUrl3;
            controller.imageUrl4 = productData.imageUrl4;
            controller.data = tempArray;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }    
}

@end

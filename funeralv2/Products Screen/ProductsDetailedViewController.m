//
//  ProductsDetailedViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 10/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "ProductsDetailedViewController.h"
#import "iCarousel.h"
#import "UIImageView+AFNetworking.h"
#import "EnquiryFormViewController.h"

@interface ProductsDetailedViewController () <iCarouselDataSource, iCarouselDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet iCarousel *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScroll;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIButton *enquiryButton;

@end

@implementation ProductsDetailedViewController

@synthesize description;

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
    
    [HelperClass dashboardSetup:_config.statusBarColour red:[_config.colourRed floatValue] green:[_config.colourGreen floatValue] blue:[_config.colourBlue floatValue] backgroundImageView:_backgroundImageView sideMenuButton:nil closeButton:nil backButton:_backButton addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:_enquiryButton saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
    
    _productName.text = _name;
    _productPrice.text = [NSString stringWithFormat:@"%@ %@", [HelperClass CMSResponseSetCurrencySign:_config.countrySettings price:_price], _price];
    
    _enquiryButton = [HelperClass CMSResponseSetEnquiryButtonText:_enquiryButton CMSSettings:_config.countrySettings];

    self.navigationController.interactivePopGestureRecognizer.delegate = self;

    NSString *formattedString = [NSString stringWithFormat:@"<body style='color: rgb(137,137,137); font-family:Helvetica Neue;font-size:13px;'>%@</body>", self.description];
    _descriptionTextView.attributedText = [[NSAttributedString alloc] initWithData:[formattedString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];

    _imageView.type = iCarouselTypeLinear;
    [self initIndicatorScrollView:_imageScroll withData:_data];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender
{
    [_imageView setHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)enquireButtonPressed:(id)sender
{
    EnquiryFormViewController *controller = [EnquiryFormViewController new];
    [controller setConfig:_config];
    [self.navigationController presentViewController:controller animated:YES completion:nil];
}

#pragma mark - iCarousel Setup
-(NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return _data.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIImageView *)view
{
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIImageView alloc] initWithFrame:CGRectMake(20, 84, 280, 136)];
        [view setImageWithURL:[NSURL URLWithString:[_data objectAtIndex:index]]];
    }
    else
    {
        [view setImageWithURL:[NSURL URLWithString:[_data objectAtIndex:index]]];
    }
    return view;
}

-(void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    [self setSelectedIndicator:_imageScroll withSelectedIndex:carousel.currentItemIndex];
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.1f;
    }
    return value;
}

-(void)initIndicatorScrollView:(UIScrollView *)scrollView withData:(NSMutableArray *)data{
    //Suppose that each dot indicator has size of 16 x 16 and there is 5px space between them
    
    CGSize indicatorSize = CGSizeMake(9,9);
    float padding = 5;
    float leftMargin = (scrollView.frame.size.width - indicatorSize.width*[data count] - padding*([data count] - 1)) / 2.0;
    
    for (int i = 0; i < [data count]; i++) {
        UIButton *indicator = [UIButton buttonWithType:UIButtonTypeCustom];
        [indicator setFrame:CGRectMake(leftMargin, 5, indicatorSize.width, indicatorSize.height)];
        [indicator setImage:[UIImage imageNamed:@"image-scroll-unselected"] forState:UIControlStateNormal];
        [indicator setImage:[UIImage imageNamed:@"image-scroll-selected"] forState:UIControlStateSelected];
        [indicator setTag:100+i];
        [scrollView addSubview:indicator];
        
        leftMargin += indicatorSize.width + padding;
    }
    
    [self setSelectedIndicator:_imageScroll withSelectedIndex:0];
}

-(void)setSelectedIndicator:(UIScrollView *)scrollView withSelectedIndex:(int)selectedIndex{
    for (UIView *view in [scrollView subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            [(UIButton *)view setSelected:NO];
            [(UIButton *)view setImageEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
        }
    }
    [(UIButton *)[scrollView viewWithTag:100 + selectedIndex] setSelected:YES];
    [(UIButton *)[scrollView viewWithTag:100 + selectedIndex] setImageEdgeInsets:UIEdgeInsetsZero];
}

@end

//
//  ContactUsViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 21/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "ContactUsViewController.h"
#import "ContactTableViewCell.h"
#import "ContactPopUpViewController.h"
#import "ContactData.h"
#import "LocationPin.h"
#import "UIViewController+MJPopupViewController.h"
#import <objc/runtime.h>

static char kContactAssociatedAnnotationKey;

@interface ContactUsViewController (){
    NSString *pendingPinId;
    NSMutableArray *annotations;
    BOOL fuzzyAll;
    LocationPin *currentSelected;
}

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *sideMenuButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *switchControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ContactUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _currentSelectedIndex = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    annotations= [NSMutableArray new];
    fuzzyAll = NO;
    
    UINib *nib = [UINib nibWithNibName:@"ContactTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [HelperClass dashboardSetup:_config.statusBarColour red:[_config.colourRed floatValue] green:[_config.colourGreen floatValue] blue:[_config.colourBlue floatValue] backgroundImageView:_backgroundImageView sideMenuButton:_sideMenuButton closeButton:nil backButton:nil addMenuButton:nil tickMenuButton:nil navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:nil saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:_switchControl];
    
    [self apiCall];
    // Do any additional setup after loading the view from its nib.
    if (pendingPinId) {
        LocationPin *pin = [[LocationPin alloc] init];
        pin.pinID = pendingPinId;
        int index = [_mapView.annotations indexOfObject:pin];
        
        [_mapView selectAnnotation:[_mapView.annotations objectAtIndex:index] animated:YES];
        pendingPinId = nil;
    }
    [_switchControl addTarget:self action:@selector(action) forControlEvents:UIControlEventValueChanged];
}
-(void)stickPopupToBottom{}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)action
{
    if (_switchControl.selectedSegmentIndex == 0) {
        [_tableView setHidden:YES];
        [_mapView setHidden:NO];
    }
    else if (_switchControl.selectedSegmentIndex == 1) {
        [_mapView setHidden:YES];
        [_tableView setHidden:NO];
    }
}

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
         [self setupMapView];
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //if not internet, copy the data from the documents directory to the data model
         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
         NSString *documentsDirectoryPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"location.json"];
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:documentsDirectoryPath] options:NSJSONReadingMutableContainers error:nil];
         _data = [MTLJSONAdapter modelsOfClass:[ContactData class] fromJSONArray:[dic objectForKey:@"matches"] error:nil];
         [_tableView reloadData];
         [self setupMapView];
     }];
}

-(void)setupMapView
{
    _mapView.showsUserLocation = YES;
    
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager startUpdatingLocation];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = 20;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest; //kCLLocationAccuracyHundredMeters
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    for (ContactData *contactData in _data)
    {
        NSString *name = contactData.name;
        NSString *fullAddress = contactData.fullAddress;
        NSString *latitude = contactData.latitude;
        NSString *longitude = contactData.longitude;
        NSString *email = contactData.email;
        NSString *telephone = contactData.telephone;
        
        NSLog(@"%@%@%@%@%@%@", name, fullAddress, latitude, longitude, email, telephone);
        
        float f_lat = [latitude doubleValue];
        float f_long = [longitude doubleValue];
        
        if ((f_lat >= -90 && f_lat <= 90) && (f_long >= -180 && f_long <= 180))
        {
            MKCoordinateRegion region;
            region.center.latitude = f_lat;
            region.center.longitude = f_long;
            region.span.latitudeDelta = 0.01f;
            region.span.longitudeDelta = 0.01f;
            [_mapView setRegion:region animated:YES];
            _mapView.delegate = self;
            
            LocationPin *pin = [[LocationPin alloc] init];
            pin.pinID = contactData.pinId;
            pin.coordinate = region.center;

            [annotations addObject:pin];
            
            objc_setAssociatedObject(pin,
                                     &kContactAssociatedAnnotationKey,
                                     contactData,
                                     OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
            topLeftCoord.longitude = fmin(topLeftCoord.longitude, pin.coordinate.longitude);
            topLeftCoord.latitude = fmax(topLeftCoord.latitude, pin.coordinate.latitude);
            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, pin.coordinate.longitude);
            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, pin.coordinate.latitude);
        }
    }
    [_mapView addAnnotations:annotations];
    
    if (_currentSelectedIndex > -1 && _mapView.annotations.count > 0) {
        [_mapView selectAnnotation:[_mapView.annotations objectAtIndex:_currentSelectedIndex] animated:YES];
    }
    else{
        MKCoordinateRegion region;
        region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
        region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
        region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1;
        
        region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1;
        
        region = [_mapView regionThatFits:region];
        
        if ((region.center.latitude >= -90 && region.center.latitude <=90) && (region.center.longitude >= -180 && region.center.longitude<=180))
        {
            [_mapView setRegion:region animated:NO];
        }
    }
}

-(void)showMapAnnotationWithPinId:(NSString *)pinID{
    if (!self.isViewLoaded) {
        pendingPinId = [pinID copy];
        
    }
    else{
        LocationPin *pin = [[LocationPin alloc] init];
        pin.pinID = pinID;
        int index = [_mapView.annotations indexOfObject:pin];
        
        [_mapView selectAnnotation:[_mapView.annotations objectAtIndex:index] animated:YES];
    }
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    ContactPopUpViewController *controller = [[ContactPopUpViewController alloc] initWithNibName:@"ContactPopUpViewController" bundle:nil];
    [controller setPopupCaller:self];
    controller.userCurrentLat = _mapView.userLocation.coordinate.latitude;
    controller.userCurrentLong = _mapView.userLocation.coordinate.longitude;
    
    ContactData *data = objc_getAssociatedObject(view.annotation,
                                                 &kContactAssociatedAnnotationKey);
    controller.name = [data name];
    controller.email = [data email];
    controller.telephone = [data telephone];
    controller.contactDataLat = [data latitude];
    controller.contactDataLong = [data longitude];
    controller.address = [data fullAddress];
    
     __weak typeof(_mapView) weakMapView = _mapView;
    
    currentSelected = view.annotation;
    
    fuzzyAll = YES;
    [weakMapView removeAnnotations:annotations];
    [weakMapView addAnnotations:annotations];
    
    [self presentPopupViewController:controller animationType:MJPopupViewAnimationFade dismissed:^{
        fuzzyAll = NO;
        [weakMapView removeAnnotations:annotations];
        [weakMapView addAnnotations:annotations];
    }];
    
}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *defaultPinID = @"annotation";
    MKAnnotationView *view = (MKAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    
    if (view == nil) {
        view = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
    }
    if (!fuzzyAll) {
        view.image = [UIImage imageNamed:@"contact-map-pin"];
    }
    else{
        if ([currentSelected isEqual:annotation]) {
            view.image = [UIImage imageNamed:@"contact-map-pin-selected"];
        }
        else{
            view.image = [UIImage imageNamed:@"contact-map-pin-unselected"];
        }
        
    }
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (indexPath.row % 2) {
        cell.contentView.backgroundColor = [[UIColor alloc]initWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];
    } else {
        cell.contentView.backgroundColor = [[UIColor alloc]initWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
    }

    //pass information to the next screen
    [cell setController:self];
    [cell setConfig:_config];
    cell.userCurrentLat = _mapView.userLocation.coordinate.latitude;
    cell.userCurrentLong = _mapView.userLocation.coordinate.longitude;
    cell.email = [[_data objectAtIndex:indexPath.row] email];
    cell.telephone = [[_data objectAtIndex:indexPath.row] telephone];
    cell.contactDataLat = [[_data objectAtIndex:indexPath.row] latitude];
    cell.contactDataLong = [[_data objectAtIndex:indexPath.row] longitude];
    
    //display information in labels
    cell.nameLabel.text = [[_data objectAtIndex:indexPath.row] name];
    cell.addressLabel.text = [[_data objectAtIndex:indexPath.row] fullAddress];
    cell.numberLabel.text = [[_data objectAtIndex:indexPath.row] telephone];
    [cell.emailButton setTitle:[[_data objectAtIndex:indexPath.row] email] forState:UIControlStateNormal];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end

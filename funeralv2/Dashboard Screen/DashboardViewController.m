//
//  DashboardViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 06/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "DashboardViewController.h"
#import "AdviceViewController.h"
#import "ContactUsViewController.h"
#import "ObituariesViewController.h"
#import "ProductsViewController.h"
#import "TodoListViewController.h"
#import "MyDetailsViewController.h"
#import "MySavedDetailsViewController.h"
#import "ObituaryUIWebViewController.h"
#import "DashboardCallScreenPopUpViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "FuneralData.h"
#import "MyWishListViewController.h"
#import "MyWishListSavedViewController.h"
@import AudioToolbox;

@interface DashboardViewController ()

@property (weak, nonatomic) IBOutlet UIView *view_4;
@property (weak, nonatomic) IBOutlet UIView *view_35;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *sideMenuButton;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dashboardImage;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UILabel *sloganLabel;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView_35;
@property (weak, nonatomic) IBOutlet UIButton *sideMenuButton_35;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel_35;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel_35;
@property (weak, nonatomic) IBOutlet UIImageView *dashboardImage_35;
@property (weak, nonatomic) IBOutlet UIButton *callButton_35;
@property (weak, nonatomic) IBOutlet UILabel *sloganLabel_35;
@property (weak, nonatomic) IBOutlet UIButton *button1_35;
@property (weak, nonatomic) IBOutlet UIButton *button2_35;
@property (weak, nonatomic) IBOutlet UIButton *button3_35;
@property (weak, nonatomic) IBOutlet UIButton *button4_35;
@property (weak, nonatomic) IBOutlet UIButton *button5_35;
@property (retain, nonatomic) NSArray *data;
@property CLBeaconRegion * beaconRegion;
@property CLLocationManager * locationManager;
@property CLBeaconRegion * beaconRegion2;
@property CLLocationManager * locationManager2;
@property CLBeaconRegion * beaconRegion3;
@property CLLocationManager * locationManager3;
@property CLBeaconRegion * beaconRegion4;
@property CLLocationManager * locationManager4;
@property CLBeaconRegion * beaconRegion5;
@property CLLocationManager * locationManager5;
@property CLBeaconRegion * beaconRegion6;
@property CLLocationManager * locationManager6;
@property CLBeaconRegion * beaconRegion7;
@property CLLocationManager * locationManager7;
@property CLBeaconRegion * beaconRegion8;
@property CLLocationManager * locationManager8;
@property CLBeaconRegion * beaconRegion9;
@property CLLocationManager * locationManager9;
@property CLBeaconRegion * beaconRegion10;
@property CLLocationManager * locationManager10;

@end

@implementation DashboardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if ([manager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        [manager requestAlwaysAuthorization];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
    [self apiCall];
    [self setupiBeacons];
    
    //nsnotification setup
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeModal:) name:@"Execute_Detail_View" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma maek - Api Call
-(void)apiCall
{
    //files from the bash scripts are saved into te nsbundle
    //files from the bundle are copied into the documents directory in the app delegate
    //locate the file saved in documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"funerals.json"];
    
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", Base_URL, _config.appId, Get_Funerals]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    
    if (!error)
    {
        //If no error and there's a valid internet connection get the data from the live end point and copy that over the model
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        [responseString writeToFile:documentsDirectoryPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:documentsDirectoryPath] options:NSJSONReadingMutableContainers error:nil];
        _data = [MTLJSONAdapter modelsOfClass:FuneralData.class fromJSONArray:[dic objectForKey:@"funerals"] error:nil];
    }
    else
    {
        //When app launches if not internet, copy the data from the documents directory to the data model
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:documentsDirectoryPath] options:NSJSONReadingMutableContainers error:nil];
        _data = [MTLJSONAdapter modelsOfClass:FuneralData.class fromJSONArray:[dic objectForKey:@"funerals"] error:nil];
        
    }
}

#pragma mark - Setup View
-(void)setupView
{
    if([[UIScreen mainScreen] bounds].size.height <= 480.0) {
        self.view = _view_35;
        [_titleLabel_35 setText:_config.appName];
        [_sloganLabel_35 setText:_config.welcomeMessage];
    }
    else {
        self.view = _view_4;
        [_titleLabel setText:_config.appName];
        [_sloganLabel setText:_config.welcomeMessage];
    }
    
    [HelperClass dashboardSetup:_config.statusBarColour red:[_config.colourRed floatValue] green:[_config.colourGreen floatValue] blue:[_config.colourBlue floatValue] backgroundImageView:_backgroundImageView sideMenuButton:_sideMenuButton closeButton:nil backButton:nil addMenuButton:nil tickMenuButton:nil navigationTitle:_welcomeLabel navigationSubTitle:_titleLabel navigationThirdTitle:_sloganLabel dashboardImage:_dashboardImage submitButton:nil saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
    
    [HelperClass dashboardScrollViewSetup:_config.dashboardButton1 option2:_config.dashboardButton2 option3:_config.dashboardButton3 option4:_config.dashboardButton4 option5:_config.dashboardButton5 scrollViewButton1:_button1 scrollViewButton2:_button2 scrollViewButton3:_button3 scrollViewButton4:_button4 scrollViewButton5:_button5];
    
    [HelperClass dashboardSetup:_config.statusBarColour red:[_config.colourRed floatValue] green:[_config.colourGreen floatValue] blue:[_config.colourBlue floatValue] backgroundImageView:_backgroundImageView_35 sideMenuButton:_sideMenuButton_35 closeButton:nil backButton:nil addMenuButton:nil tickMenuButton:nil navigationTitle:_welcomeLabel_35 navigationSubTitle:_titleLabel_35 navigationThirdTitle:_sloganLabel_35 dashboardImage:_dashboardImage_35 submitButton:nil saveButton:nil todoListTextField:nil uiViewColour:nil uisegmentedControlColour:nil];
    
    [HelperClass dashboardScrollViewSetup:_config.dashboardButton1 option2:_config.dashboardButton2 option3:_config.dashboardButton3 option4:_config.dashboardButton4 option5:_config.dashboardButton5 scrollViewButton1:_button1_35 scrollViewButton2:_button2_35 scrollViewButton3:_button3_35 scrollViewButton4:_button4_35 scrollViewButton5:_button5_35];
}

#pragma mark - Setup iBeacons
-(void)closeModal:(NSNotification *)notification
{
//This is the nsnotification fired when the user opens the app via clicking on a UILocaNotification
//If the is app being launched first time where no details have been saved previously then the app looks up the varaible "detailsSaved" from the NSUserDefaults and loads up MyDetailsViewController if the current class displayed on the screen is not MyDetailsViewController
//If the app is launched where details have been saved previously then is again check the varaible "detailsSaved" from the NSUserDefaults and loads up MySavedDetailsViewController if the current class displayed on the screen is not MySavedDetailsViewController
//There's 2 checks being made below
//1: check with varaible detailsSaved which screen should load
//2: check with the current visible navigation controller if the current class is the same class as it should load up to be, If not hack the controller to display the desired class
    
    NSString *key = [notification object];
    
    if ([@"Execute_Detail_View_Controller" isEqualToString:key])
    {
        
        BOOL detailsSaved = [UserDefault boolForKey:@"detailsSaved"];
        if (!detailsSaved) {
            if(![self.navigationController.visibleViewController isKindOfClass:[MyDetailsViewController class]])
            {
                MyDetailsViewController *controller = [MyDetailsViewController new];
                [controller setConfig:_config];
                [self.navigationController pushViewController:controller animated:YES];
            }
        }
        else
        {
            if(![self.navigationController.visibleViewController isKindOfClass:[MySavedDetailsViewController class]])
            {
                if([[UIScreen mainScreen] bounds].size.height <= 480.0)
                {
                    MySavedDetailsViewController *controller = [[MySavedDetailsViewController alloc] initWithNibName:@"MySavedDetailsViewController_35" bundle:nil];
                    [controller setConfig:_config];
                    [self.navigationController pushViewController:controller animated:YES];
                }
                else
                {
                    MySavedDetailsViewController *controller = [[MySavedDetailsViewController alloc] initWithNibName:@"MySavedDetailsViewController" bundle:nil];
                    [controller setConfig:_config];
                    [self.navigationController pushViewController:controller animated:YES];
                }
            }
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    [_locationManager startRangingBeaconsInRegion:_beaconRegion];
    [_locationManager2 startRangingBeaconsInRegion:_beaconRegion2];
    [_locationManager3 startRangingBeaconsInRegion:_beaconRegion3];
    [_locationManager4 startRangingBeaconsInRegion:_beaconRegion4];
    [_locationManager5 startRangingBeaconsInRegion:_beaconRegion5];
    [_locationManager6 startRangingBeaconsInRegion:_beaconRegion6];
    [_locationManager7 startRangingBeaconsInRegion:_beaconRegion7];
    [_locationManager8 startRangingBeaconsInRegion:_beaconRegion8];
    [_locationManager9 startRangingBeaconsInRegion:_beaconRegion9];
    [_locationManager10 startRangingBeaconsInRegion:_beaconRegion10];
    
    //beacon from CMS 1
    if ([_data count] > 0 && (FuneralData *)[_data objectAtIndex:0] != NULL) {
        if ([region.identifier isEqualToString:[(FuneralData *)[_data objectAtIndex:0] beaconName]] && CLProximityImmediate) {
            UILocalNotification * notification = [UILocalNotification new];
            notification.alertBody = [NSString stringWithFormat:@"Would you like to send your details for %@?", [(FuneralData *)[_data objectAtIndex:0] funeralName]];
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
            
            AudioServicesPlaySystemSound(1007); //message sound
            AudioServicesPlaySystemSound(4095); //vibrate
        }
    }
    
    //beacon from CMS 2
    if ([_data count] > 1 && (FuneralData *)[_data objectAtIndex:1] != NULL) {
        if ([region.identifier isEqualToString:[(FuneralData *)[_data objectAtIndex:1] beaconName]] && CLProximityImmediate) {
            UILocalNotification * notification = [UILocalNotification new];
            notification.alertBody = [NSString stringWithFormat:@"Would you like to send your details for %@?", [(FuneralData *)[_data objectAtIndex:1] funeralName]];
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
            
            AudioServicesPlaySystemSound(1007); //message sound
            AudioServicesPlaySystemSound(4095); //vibrate
        }
    }
    
    //beacon from CMS 3
    if ([_data count] > 2 && (FuneralData *)[_data objectAtIndex:2] != NULL) {
        if ([region.identifier isEqualToString:[(FuneralData *)[_data objectAtIndex:2] beaconName]] && CLProximityImmediate) {
            UILocalNotification * notification = [UILocalNotification new];
            notification.alertBody = [NSString stringWithFormat:@"Would you like to send your details for %@?", [(FuneralData *)[_data objectAtIndex:2] funeralName]];
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
            
            AudioServicesPlaySystemSound(1007); //message sound
            AudioServicesPlaySystemSound(4095); //vibrate
        }
    }
    
    //beacon from CMS 4
    if ([_data count] > 3 && (FuneralData *)[_data objectAtIndex:3] != NULL) {
        if ([region.identifier isEqualToString:[(FuneralData *)[_data objectAtIndex:3] beaconName]] && CLProximityImmediate) {
            UILocalNotification * notification = [UILocalNotification new];
            notification.alertBody = [NSString stringWithFormat:@"Would you like to send your details for %@?", [(FuneralData *)[_data objectAtIndex:3] funeralName]];
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
            
            AudioServicesPlaySystemSound(1007); //message sound
            AudioServicesPlaySystemSound(4095); //vibrate
        }
    }
    
    //beacon from CMS 5
    if ([_data count] > 4 && (FuneralData *)[_data objectAtIndex:4] != NULL) {
        if ([region.identifier isEqualToString:[(FuneralData *)[_data objectAtIndex:4] beaconName]] && CLProximityImmediate) {
            UILocalNotification * notification = [UILocalNotification new];
            notification.alertBody = [NSString stringWithFormat:@"Would you like to send your details for %@?", [(FuneralData *)[_data objectAtIndex:4] funeralName]];
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];

            AudioServicesPlaySystemSound(1007); //message sound
            AudioServicesPlaySystemSound(4095); //vibrate
        }
    }
    
    //beacon from CMS 6
    if ([_data count] > 5 && (FuneralData *)[_data objectAtIndex:5] != NULL) {
        if ([region.identifier isEqualToString:[(FuneralData *)[_data objectAtIndex:5] beaconName]] && CLProximityImmediate) {
            UILocalNotification * notification = [UILocalNotification new];
            notification.alertBody = [NSString stringWithFormat:@"Would you like to send your details for %@?", [(FuneralData *)[_data objectAtIndex:5] funeralName]];
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
            
            AudioServicesPlaySystemSound(1007); //message sound
            AudioServicesPlaySystemSound(4095); //vibrate
        }
    }
    
    //beacon from CMS 7
    if ([_data count] > 6 && (FuneralData *)[_data objectAtIndex:6] != NULL) {
        if ([region.identifier isEqualToString:[(FuneralData *)[_data objectAtIndex:6] beaconName]] && CLProximityImmediate) {
            UILocalNotification * notification = [UILocalNotification new];
            notification.alertBody = [NSString stringWithFormat:@"Would you like to send your details for %@?", [(FuneralData *)[_data objectAtIndex:6] funeralName]];
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
            
            AudioServicesPlaySystemSound(1007); //message sound
            AudioServicesPlaySystemSound(4095); //vibrate
        }
    }
    
    //beacon from CMS 8
    if ([_data count] > 7 && (FuneralData *)[_data objectAtIndex:7] != NULL) {
        if ([region.identifier isEqualToString:[(FuneralData *)[_data objectAtIndex:7] beaconName]] && CLProximityImmediate) {
            UILocalNotification * notification = [UILocalNotification new];
            notification.alertBody = [NSString stringWithFormat:@"Would you like to send your details for %@?", [(FuneralData *)[_data objectAtIndex:7] funeralName]];
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
            
            AudioServicesPlaySystemSound(1007); //message sound
            AudioServicesPlaySystemSound(4095); //vibrate
        }
    }
    
    //beacon from CMS 9
    if ([_data count] > 8 && (FuneralData *)[_data objectAtIndex:8] != NULL) {
        if ([region.identifier isEqualToString:[(FuneralData *)[_data objectAtIndex:8] beaconName]] && CLProximityImmediate) {
            UILocalNotification * notification = [UILocalNotification new];
            notification.alertBody = [NSString stringWithFormat:@"Would you like to send your details for %@?", [(FuneralData *)[_data objectAtIndex:8] funeralName]];
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
            
            AudioServicesPlaySystemSound(1007); //message sound
            AudioServicesPlaySystemSound(4095); //vibrate
        }
    }
    
    //beacon from CMS 10
    if ([_data count] > 9 && (FuneralData *)[_data objectAtIndex:9] != NULL) {
        if ([region.identifier isEqualToString:[(FuneralData *)[_data objectAtIndex:9] beaconName]] && CLProximityImmediate) {
            UILocalNotification * notification = [UILocalNotification new];
            notification.alertBody = [NSString stringWithFormat:@"Would you like to send your details for %@?", [(FuneralData *)[_data objectAtIndex:9] funeralName]];
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
            
            AudioServicesPlaySystemSound(1007); //message sound
            AudioServicesPlaySystemSound(4095); //vibrate
        }
    }
    
    NSLog(@"region entered");
}

-(void)locationManager:(CLLocationManager*)manager didExitRegion:(CLRegion*)region //delegate set to NO in vewididload
{
    [_locationManager stopRangingBeaconsInRegion:_beaconRegion];
    [_locationManager2 stopRangingBeaconsInRegion:_beaconRegion2];
    [_locationManager3 stopRangingBeaconsInRegion:_beaconRegion3];
    [_locationManager4 stopRangingBeaconsInRegion:_beaconRegion4];
    [_locationManager5 stopRangingBeaconsInRegion:_beaconRegion5];
    [_locationManager6 stopRangingBeaconsInRegion:_beaconRegion6];
    [_locationManager7 stopRangingBeaconsInRegion:_beaconRegion7];
    [_locationManager8 stopRangingBeaconsInRegion:_beaconRegion8];
    [_locationManager9 stopRangingBeaconsInRegion:_beaconRegion9];
    [_locationManager10 stopRangingBeaconsInRegion:_beaconRegion10];
    NSLog(@"region exit");
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    if ([beacons count] == 0)
        return;
    
    CLBeacon *beacon = [beacons firstObject];
    
    //beacon from CMS 1
    if ([_data count] > 0 && (FuneralData *)[_data objectAtIndex:0] != NULL) {
        if ([region.identifier isEqualToString:[(FuneralData *)[_data objectAtIndex:0] beaconName]] && beacon.proximity == CLProximityImmediate) {
            
            static dispatch_once_t once;
            dispatch_once(&once, ^ {
                
                UILocalNotification * notification = [UILocalNotification new];
                notification.alertBody = [NSString stringWithFormat:@"Would you like to send your details for %@?", [(FuneralData *)[_data objectAtIndex:0] funeralName]];
                [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
                
                AudioServicesPlaySystemSound(1007); //message sound
                AudioServicesPlaySystemSound(4095); //vibrate
            });
        }
    }
    
    //beacon from CMS 2
    if ([_data count] > 1 && (FuneralData *)[_data objectAtIndex:1] != NULL) {
        if ([region.identifier isEqualToString:[(FuneralData *)[_data objectAtIndex:1] beaconName]] && beacon.proximity == CLProximityImmediate) {
            
            static dispatch_once_t once;
            dispatch_once(&once, ^ {
                
                UILocalNotification * notification = [UILocalNotification new];
                notification.alertBody = [NSString stringWithFormat:@"Would you like to send your details for %@?", [(FuneralData *)[_data objectAtIndex:1] funeralName]];
                [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
                
                AudioServicesPlaySystemSound(1007); //message sound
                AudioServicesPlaySystemSound(4095); //vibrate
            });
        }
    }

    //beacon from CMS 3
    if ([_data count] > 2 && (FuneralData *)[_data objectAtIndex:2] != NULL) {
        if ([region.identifier isEqualToString:[(FuneralData *)[_data objectAtIndex:2] beaconName]] && beacon.proximity == CLProximityImmediate) {
            
            static dispatch_once_t once;
            dispatch_once(&once, ^ {
                
                UILocalNotification * notification = [UILocalNotification new];
                notification.alertBody = [NSString stringWithFormat:@"Would you like to send your details for %@?", [(FuneralData *)[_data objectAtIndex:2] funeralName]];
                [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
                
                AudioServicesPlaySystemSound(1007); //message sound
                AudioServicesPlaySystemSound(4095); //vibrate
            });
        }
    }
    
    //beacon from CMS 4
    if ([_data count] > 3 && (FuneralData *)[_data objectAtIndex:3] != NULL) {
        if ([region.identifier isEqualToString:[(FuneralData *)[_data objectAtIndex:3] beaconName]] && beacon.proximity == CLProximityImmediate) {
            
            static dispatch_once_t once;
            dispatch_once(&once, ^ {
                
                UILocalNotification * notification = [UILocalNotification new];
                notification.alertBody = [NSString stringWithFormat:@"Would you like to send your details for %@?", [(FuneralData *)[_data objectAtIndex:3] funeralName]];
                [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
                
                AudioServicesPlaySystemSound(1007); //message sound
                AudioServicesPlaySystemSound(4095); //vibrate
            });
        }
    }
    
    //beacon from CMS 5
    if ([_data count] > 4 && (FuneralData *)[_data objectAtIndex:4] != NULL) {
        if ([region.identifier isEqualToString:[(FuneralData *)[_data objectAtIndex:4] beaconName]] && beacon.proximity == CLProximityImmediate) {
            
            static dispatch_once_t once;
            dispatch_once(&once, ^ {
                
                UILocalNotification * notification = [UILocalNotification new];
                notification.alertBody = [NSString stringWithFormat:@"Would you like to send your details for %@?", [(FuneralData *)[_data objectAtIndex:4] funeralName]];
                [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
                
                AudioServicesPlaySystemSound(1007); //message sound
                AudioServicesPlaySystemSound(4095); //vibrate
            });
        }
    }
    
    //beacon from CMS 6
    if ([_data count] > 5 && (FuneralData *)[_data objectAtIndex:5] != NULL) {
        if ([region.identifier isEqualToString:[(FuneralData *)[_data objectAtIndex:5] beaconName]] && beacon.proximity == CLProximityImmediate) {
            
            static dispatch_once_t once;
            dispatch_once(&once, ^ {
                
                UILocalNotification * notification = [UILocalNotification new];
                notification.alertBody = [NSString stringWithFormat:@"Would you like to send your details for %@?", [(FuneralData *)[_data objectAtIndex:5] funeralName]];
                [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
                
                AudioServicesPlaySystemSound(1007); //message sound
                AudioServicesPlaySystemSound(4095); //vibrate
            });
        }
    }
    
    //beacon from CMS 7
    if ([_data count] > 6 && (FuneralData *)[_data objectAtIndex:6] != NULL) {
        if ([region.identifier isEqualToString:[(FuneralData *)[_data objectAtIndex:6] beaconName]] && beacon.proximity == CLProximityImmediate) {
            
            static dispatch_once_t once;
            dispatch_once(&once, ^ {
                
                UILocalNotification * notification = [UILocalNotification new];
                notification.alertBody = [NSString stringWithFormat:@"Would you like to send your details for %@?", [(FuneralData *)[_data objectAtIndex:6] funeralName]];
                [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
                
                AudioServicesPlaySystemSound(1007); //message sound
                AudioServicesPlaySystemSound(4095); //vibrate
            });
        }
    }
    
    //beacon from CMS 8
    if ([_data count] > 7 && (FuneralData *)[_data objectAtIndex:7] != NULL) {
        if ([region.identifier isEqualToString:[(FuneralData *)[_data objectAtIndex:7] beaconName]] && beacon.proximity == CLProximityImmediate) {
            
            static dispatch_once_t once;
            dispatch_once(&once, ^ {
                
                UILocalNotification * notification = [UILocalNotification new];
                notification.alertBody = [NSString stringWithFormat:@"Would you like to send your details for %@?", [(FuneralData *)[_data objectAtIndex:7] funeralName]];
                [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
                
                AudioServicesPlaySystemSound(1007); //message sound
                AudioServicesPlaySystemSound(4095); //vibrate
            });
        }
    }
    
    //beacon from CMS 9
    if ([_data count] > 8 && (FuneralData *)[_data objectAtIndex:8] != NULL) {
        if ([region.identifier isEqualToString:[(FuneralData *)[_data objectAtIndex:8] beaconName]] && beacon.proximity == CLProximityImmediate) {
            
            static dispatch_once_t once;
            dispatch_once(&once, ^ {
                
                UILocalNotification * notification = [UILocalNotification new];
                notification.alertBody = [NSString stringWithFormat:@"Would you like to send your details for %@?", [(FuneralData *)[_data objectAtIndex:8] funeralName]];
                [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
                
                AudioServicesPlaySystemSound(1007); //message sound
                AudioServicesPlaySystemSound(4095); //vibrate
            });
        }
    }
    
    //beacon from CMS 10
    if ([_data count] > 9 && (FuneralData *)[_data objectAtIndex:9] != NULL) {
        if ([region.identifier isEqualToString:[(FuneralData *)[_data objectAtIndex:9] beaconName]] && beacon.proximity == CLProximityImmediate) {
            
            static dispatch_once_t once;
            dispatch_once(&once, ^ {
                
                UILocalNotification * notification = [UILocalNotification new];
                notification.alertBody = [NSString stringWithFormat:@"Would you like to send your details for %@?", [(FuneralData *)[_data objectAtIndex:9] funeralName]];
                [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
                
                AudioServicesPlaySystemSound(1007); //message sound
                AudioServicesPlaySystemSound(4095); //vibrate
            });
        }
    }
    
    NSLog(@"didRangeBeacons");
}

-(void)setupiBeacons
{
    
    //beacon 1
    if ([_data count] > 0 && (FuneralData *)[_data objectAtIndex:0] != NULL) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        [_beaconRegion setNotifyEntryStateOnDisplay:YES];
        [_beaconRegion setNotifyOnEntry:YES];
        [_beaconRegion setNotifyOnExit:NO];
        NSUUID * uid = [[NSUUID alloc] initWithUUIDString:[(FuneralData *)[_data objectAtIndex:0] beaconUuid]];
        _beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uid major:[(FuneralData *)[_data objectAtIndex:0] beaconMajor].integerValue minor:[(FuneralData *)[_data objectAtIndex:0] beaconMinor].integerValue identifier:[(FuneralData *)[_data objectAtIndex:0] beaconName]];
        [_locationManager startMonitoringForRegion:_beaconRegion];
        [_locationManager startRangingBeaconsInRegion:_beaconRegion];
    }
    
    //beacon 2
    if ([_data count] > 1 && (FuneralData *)[_data objectAtIndex:1] != NULL) {
        _locationManager2 = [[CLLocationManager alloc] init];
        _locationManager2.delegate = self;
        [_beaconRegion2 setNotifyEntryStateOnDisplay:YES];
        [_beaconRegion2 setNotifyOnEntry:YES];
        [_beaconRegion2 setNotifyOnExit:NO];
        NSUUID * uid2 = [[NSUUID alloc] initWithUUIDString:[(FuneralData *)[_data objectAtIndex:1] beaconUuid]];
        _beaconRegion2 = [[CLBeaconRegion alloc] initWithProximityUUID:uid2 major:[(FuneralData *)[_data objectAtIndex:1] beaconMajor].integerValue minor:[(FuneralData *)[_data objectAtIndex:1] beaconMinor].integerValue identifier:[(FuneralData *)[_data objectAtIndex:1] beaconName]];
        [_locationManager2 startMonitoringForRegion:_beaconRegion2];
        [_locationManager2 startRangingBeaconsInRegion:_beaconRegion2];
    }
    
    //beacon 3
    if ([_data count] > 2 && (FuneralData *)[_data objectAtIndex:2] != NULL) {
        _locationManager3 = [[CLLocationManager alloc] init];
        _locationManager3.delegate = self;
        [_beaconRegion3 setNotifyEntryStateOnDisplay:YES];
        [_beaconRegion3 setNotifyOnEntry:YES];
        [_beaconRegion3 setNotifyOnExit:NO];
        NSUUID * uid3 = [[NSUUID alloc] initWithUUIDString:[(FuneralData *)[_data objectAtIndex:2] beaconUuid]];
        _beaconRegion3 = [[CLBeaconRegion alloc] initWithProximityUUID:uid3 major:[(FuneralData *)[_data objectAtIndex:2] beaconMajor].integerValue minor:[(FuneralData *)[_data objectAtIndex:2] beaconMinor].integerValue identifier:[(FuneralData *)[_data objectAtIndex:2] beaconName]];
        [_locationManager3 startMonitoringForRegion:_beaconRegion3];
        [_locationManager3 startRangingBeaconsInRegion:_beaconRegion3];
    }
    
    //beacon 4
    if ([_data count] > 3 && (FuneralData *)[_data objectAtIndex:3] != NULL) {
        _locationManager4 = [[CLLocationManager alloc] init];
        _locationManager4.delegate = self;
        [_beaconRegion4 setNotifyEntryStateOnDisplay:YES];
        [_beaconRegion4 setNotifyOnEntry:YES];
        [_beaconRegion4 setNotifyOnExit:NO];
        NSUUID * uid4 = [[NSUUID alloc] initWithUUIDString:[(FuneralData *)[_data objectAtIndex:3] beaconUuid]];
        _beaconRegion4 = [[CLBeaconRegion alloc] initWithProximityUUID:uid4 major:[(FuneralData *)[_data objectAtIndex:3] beaconMajor].integerValue minor:[(FuneralData *)[_data objectAtIndex:3] beaconMinor].integerValue identifier:[(FuneralData *)[_data objectAtIndex:3] beaconName]];
        [_locationManager4 startMonitoringForRegion:_beaconRegion4];
        [_locationManager4 startRangingBeaconsInRegion:_beaconRegion4];
    }
    
    //beacon 5
    if ([_data count] > 4 && (FuneralData *)[_data objectAtIndex:4] != NULL) {
        _locationManager5 = [[CLLocationManager alloc] init];
        _locationManager5.delegate = self;
        [_beaconRegion5 setNotifyEntryStateOnDisplay:YES];
        [_beaconRegion5 setNotifyOnEntry:YES];
        [_beaconRegion5 setNotifyOnExit:NO];
        NSUUID * uid5 = [[NSUUID alloc] initWithUUIDString:[(FuneralData *)[_data objectAtIndex:4] beaconUuid]];
        _beaconRegion5 = [[CLBeaconRegion alloc] initWithProximityUUID:uid5 major:[(FuneralData *)[_data objectAtIndex:4] beaconMajor].integerValue minor:[(FuneralData *)[_data objectAtIndex:4] beaconMinor].integerValue identifier:[(FuneralData *)[_data objectAtIndex:4] beaconName]];
        [_locationManager5 startMonitoringForRegion:_beaconRegion5];
        [_locationManager5 startRangingBeaconsInRegion:_beaconRegion5];
    }
    
    //beacon 6
    if ([_data count] > 5 && (FuneralData *)[_data objectAtIndex:5] != NULL) {
        _locationManager6 = [[CLLocationManager alloc] init];
        _locationManager6.delegate = self;
        [_beaconRegion6 setNotifyEntryStateOnDisplay:YES];
        [_beaconRegion6 setNotifyOnEntry:YES];
        [_beaconRegion6 setNotifyOnExit:NO];
        NSUUID * uid6 = [[NSUUID alloc] initWithUUIDString:[(FuneralData *)[_data objectAtIndex:5] beaconUuid]];
        _beaconRegion6 = [[CLBeaconRegion alloc] initWithProximityUUID:uid6 major:[(FuneralData *)[_data objectAtIndex:5] beaconMajor].integerValue minor:[(FuneralData *)[_data objectAtIndex:5] beaconMinor].integerValue identifier:[(FuneralData *)[_data objectAtIndex:5] beaconName]];
        [_locationManager6 startMonitoringForRegion:_beaconRegion6];
        [_locationManager6 startRangingBeaconsInRegion:_beaconRegion6];
    }
    
    //beacon 7
    if ([_data count] > 6 && (FuneralData *)[_data objectAtIndex:6] != NULL) {
        _locationManager7 = [[CLLocationManager alloc] init];
        _locationManager7.delegate = self;
        [_beaconRegion7 setNotifyEntryStateOnDisplay:YES];
        [_beaconRegion7 setNotifyOnEntry:YES];
        [_beaconRegion7 setNotifyOnExit:NO];
        NSUUID * uid7 = [[NSUUID alloc] initWithUUIDString:[(FuneralData *)[_data objectAtIndex:6] beaconUuid]];
        _beaconRegion7 = [[CLBeaconRegion alloc] initWithProximityUUID:uid7 major:[(FuneralData *)[_data objectAtIndex:6] beaconMajor].integerValue minor:[(FuneralData *)[_data objectAtIndex:6] beaconMinor].integerValue identifier:[(FuneralData *)[_data objectAtIndex:6] beaconName]];
        [_locationManager7 startMonitoringForRegion:_beaconRegion7];
        [_locationManager7 startRangingBeaconsInRegion:_beaconRegion7];
    }
    
    //beacon 8
    if ([_data count] > 7 && (FuneralData *)[_data objectAtIndex:7] != NULL) {
        _locationManager8 = [[CLLocationManager alloc] init];
        _locationManager8.delegate = self;
        [_beaconRegion8 setNotifyEntryStateOnDisplay:YES];
        [_beaconRegion8 setNotifyOnEntry:YES];
        [_beaconRegion8 setNotifyOnExit:NO];
        NSUUID * uid8 = [[NSUUID alloc] initWithUUIDString:[(FuneralData *)[_data objectAtIndex:7] beaconUuid]];
        _beaconRegion8 = [[CLBeaconRegion alloc] initWithProximityUUID:uid8 major:[(FuneralData *)[_data objectAtIndex:7] beaconMajor].integerValue minor:[(FuneralData *)[_data objectAtIndex:7] beaconMinor].integerValue identifier:[(FuneralData *)[_data objectAtIndex:7] beaconName]];
        [_locationManager8 startMonitoringForRegion:_beaconRegion8];
        [_locationManager8 startRangingBeaconsInRegion:_beaconRegion8];
    }
    
    //beacon 9
    if ([_data count] > 8 && (FuneralData *)[_data objectAtIndex:8] != NULL) {
        _locationManager9 = [[CLLocationManager alloc] init];
        _locationManager9.delegate = self;
        [_beaconRegion9 setNotifyEntryStateOnDisplay:YES];
        [_beaconRegion9 setNotifyOnEntry:YES];
        [_beaconRegion9 setNotifyOnExit:NO];
        NSUUID * uid9 = [[NSUUID alloc] initWithUUIDString:[(FuneralData *)[_data objectAtIndex:8] beaconUuid]];
        _beaconRegion9 = [[CLBeaconRegion alloc] initWithProximityUUID:uid9 major:[(FuneralData *)[_data objectAtIndex:8] beaconMajor].integerValue minor:[(FuneralData *)[_data objectAtIndex:8] beaconMinor].integerValue identifier:[(FuneralData *)[_data objectAtIndex:8] beaconName]];
        [_locationManager9 startMonitoringForRegion:_beaconRegion9];
        [_locationManager9 startRangingBeaconsInRegion:_beaconRegion9];
    }
    
    //beacon 10
    if ([_data count] > 9 && (FuneralData *)[_data objectAtIndex:9] != NULL) {
        _locationManager10 = [[CLLocationManager alloc] init];
        _locationManager10.delegate = self;
        [_beaconRegion10 setNotifyEntryStateOnDisplay:YES];
        [_beaconRegion10 setNotifyOnEntry:YES];
        [_beaconRegion10 setNotifyOnExit:NO];
        NSUUID * uid10 = [[NSUUID alloc] initWithUUIDString:[(FuneralData *)[_data objectAtIndex:9] beaconUuid]];
        _beaconRegion10 = [[CLBeaconRegion alloc] initWithProximityUUID:uid10 major:[(FuneralData *)[_data objectAtIndex:9] beaconMajor].integerValue minor:[(FuneralData *)[_data objectAtIndex:9] beaconMinor].integerValue identifier:[(FuneralData *)[_data objectAtIndex:9] beaconName]];
        [_locationManager10 startMonitoringForRegion:_beaconRegion10];
        [_locationManager10 startRangingBeaconsInRegion:_beaconRegion10];
    }
}

#pragma mark - Button Interactions
- (IBAction)callButtonPressed:(id)sender
{
    DashboardCallScreenPopUpViewController *controller = [DashboardCallScreenPopUpViewController new];
    [controller setConfig:_config];
    [controller setCaller:self];
    [self presentPopupViewController:controller animationType:MJPopupViewAnimationFade];
}

- (IBAction)buttonPressed1:(id)sender
{
    [self dashboardScrollViewSetup:_config.dashboardButton1 option2:nil option3:nil option4:nil option5:nil];
}

- (IBAction)buttonPressed2:(id)sender
{
    [self dashboardScrollViewSetup:nil option2:_config.dashboardButton2 option3:nil option4:nil option5:nil];
}

- (IBAction)buttonPressed3:(id)sender
{
    [self dashboardScrollViewSetup:nil option2:nil option3:_config.dashboardButton3 option4:nil option5:nil];
}

- (IBAction)buttonPressed4:(id)sender
{
    [self dashboardScrollViewSetup:nil option2:nil option3:nil option4:_config.dashboardButton4 option5:nil];
}

- (IBAction)buttonPressed5:(id)sender
{
    [self dashboardScrollViewSetup:nil option2:nil option3:nil option4:nil option5:_config.dashboardButton5];
}

#pragma mark - Push View Controllers Logic
-(void)dashboardScrollViewSetup:(NSString *)option1 option2:(NSString *)option2 option3:(NSString *)option3 option4:(NSString *)option4 option5:(NSString *)option5
{

    //-----------------------Advice--------------------------------------
    if ([option1 isEqualToString:@"advice"] || [option2 isEqualToString:@"advice"] || [option3 isEqualToString:@"advice"] || [option4 isEqualToString:@"advice"] || [option5 isEqualToString:@"advice"])
    {
        AdviceViewController *controller = [AdviceViewController new];
        [controller setConfig:_config];
        [self.navigationController pushViewController:controller animated:NO];
    }
    
    //-----------------------Contact Us--------------------------------------
    if ([option1 isEqualToString:@"contact_us"] || [option2 isEqualToString:@"contact_us"] || [option3 isEqualToString:@"contact_us"] || [option4 isEqualToString:@"contact_us"] || [option5 isEqualToString:@"contact_us"])
    {
        ContactUsViewController *controller = [ContactUsViewController new];
        [controller setConfig:_config];
        [self.navigationController pushViewController:controller animated:NO];
    }
    
    //-----------------------Donations UK--------------------------------------
    if ([option1 isEqualToString:@"donations_uk"] || [option2 isEqualToString:@"donations_uk"] || [option3 isEqualToString:@"donations_uk"] || [option4 isEqualToString:@"donations_uk"] || [option5 isEqualToString:@"donations_uk"])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_config.resourceUrl1]];
    }
    
    //-----------------------Donations US--------------------------------------
    if ([option1 isEqualToString:@"donations_us"] || [option2 isEqualToString:@"donations_us"] || [option3 isEqualToString:@"donations_us"] || [option4 isEqualToString:@"donations_us"] || [option5 isEqualToString:@"donations_us"])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_config.resourceUrl1]];
    }
    
    //-----------------------Facebook--------------------------------------
    if ([option1 isEqualToString:@"facebook"] || [option2 isEqualToString:@"facebook"] || [option3 isEqualToString:@"facebook"] || [option4 isEqualToString:@"facebook"] || [option5 isEqualToString:@"facebook"])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_config.facebook]];
    }
    
    //-----------------------My Details--------------------------------------
    if ([option1 isEqualToString:@"my_details"] || [option2 isEqualToString:@"my_details"] || [option3 isEqualToString:@"my_details"] || [option4 isEqualToString:@"my_details"] || [option5 isEqualToString:@"my_details"])
    {
        BOOL detailsSaved = [UserDefault boolForKey:@"detailsSaved"];
        if (!detailsSaved) {
            MyDetailsViewController *controller = [MyDetailsViewController new];
            [controller setConfig:_config];
            [self.navigationController pushViewController:controller animated:NO];
        }
        else
        {
            if([[UIScreen mainScreen] bounds].size.height <= 480.0)
            {
                MySavedDetailsViewController *controller = [[MySavedDetailsViewController alloc] initWithNibName:@"MySavedDetailsViewController_35" bundle:nil];
                [controller setConfig:_config];
                [self.navigationController pushViewController:controller animated:NO];
            }
            else
            {
                MySavedDetailsViewController *controller = [[MySavedDetailsViewController alloc] initWithNibName:@"MySavedDetailsViewController" bundle:nil];
                [controller setConfig:_config];
                [self.navigationController pushViewController:controller animated:NO];
            }
        }
    }
    
    //-----------------------Obituaries--------------------------------------
    if ([option1 isEqualToString:@"obituaries"] || [option2 isEqualToString:@"obituaries"] || [option3 isEqualToString:@"obituaries"] || [option4 isEqualToString:@"obituaries"] || [option5 isEqualToString:@"obituaries"])
    {
        if (![_config.resourceUrl2 isEqualToString:@""]) {
            ObituaryUIWebViewController *controller = [ObituaryUIWebViewController new];
            [controller setConfig:_config];
            [self.navigationController pushViewController:controller animated:NO];
        }
        else
        {
            ObituariesViewController *controller = [ObituariesViewController new];
            [controller setConfig:_config];
            [self.navigationController pushViewController:controller animated:NO];
        }
    }
    
    //-----------------------Products UK--------------------------------------
    if ([option1 isEqualToString:@"products_uk"] || [option2 isEqualToString:@"products_uk"] || [option3 isEqualToString:@"products_uk"] || [option4 isEqualToString:@"products_uk"] || [option5 isEqualToString:@"products_uk"])
    {
        ProductsViewController *controller = [ProductsViewController new];
        [controller setConfig:_config];
        [self.navigationController pushViewController:controller animated:NO];
    }
    
    //-----------------------Products US--------------------------------------
    if ([option1 isEqualToString:@"products_us"] || [option2 isEqualToString:@"products_us"] || [option3 isEqualToString:@"products_us"] || [option4 isEqualToString:@"products_us"] || [option5 isEqualToString:@"products_us"])
    {
        ProductsViewController *controller = [ProductsViewController new];
        [controller setConfig:_config];
        [self.navigationController pushViewController:controller animated:NO];
    }
    
    //-----------------------Todo--------------------------------------
    if ([option1 isEqualToString:@"todo"] || [option2 isEqualToString:@"todo"] || [option3 isEqualToString:@"todo"] || [option4 isEqualToString:@"todo"] || [option5 isEqualToString:@"todo"])
    {
        TodoListViewController *controller = [TodoListViewController new];
        [controller setConfig:_config];
        [self.navigationController pushViewController:controller animated:NO];
    }
    
    //-----------------------Twitter--------------------------------------
    if ([option1 isEqualToString:@"twitter"] || [option2 isEqualToString:@"twitter"] || [option3 isEqualToString:@"twitter"] || [option4 isEqualToString:@"twitter"] || [option5 isEqualToString:@"twitter"])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_config.twitter]];
    }
    
    //-----------------------Visit Website--------------------------------------
    if ([option1 isEqualToString:@"visit_website"] || [option2 isEqualToString:@"visit_website"] || [option3 isEqualToString:@"visit_website"] || [option4 isEqualToString:@"visit_website"] || [option5 isEqualToString:@"visit_website"])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_config.website]];
    }
    
    //-----------------------My Wish List--------------------------------------
    if ([option1 isEqualToString:@"wish_list"] || [option2 isEqualToString:@"wish_list"] || [option3 isEqualToString:@"wish_list"] || [option4 isEqualToString:@"wish_list"] || [option5 isEqualToString:@"wish_list"])
    {
        BOOL wishListSaved = [UserDefault boolForKey:@"wishListSaved"];
        if (!wishListSaved) {
            
            MyWishListViewController *controller = [MyWishListViewController new];
            [controller setConfig:_config];
            [self.navigationController pushViewController:controller animated:NO];
        }
        else
        {
            if([[UIScreen mainScreen] bounds].size.height <= 480.0)
            {
                MyWishListSavedViewController *controller = [[MyWishListSavedViewController alloc] initWithNibName:@"MyWishListSavedViewController_35" bundle:nil];
                [controller setConfig:_config];
                [self.navigationController pushViewController:controller animated:NO];
            }
            else
            {
                MyWishListSavedViewController *controller = [[MyWishListSavedViewController alloc] initWithNibName:@"MyWishListSavedViewController" bundle:nil];
                [controller setConfig:_config];
                [self.navigationController pushViewController:controller animated:NO];
            }
        }
    }
}

@end

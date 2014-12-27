//
//  AppDelegate.m
//  funeralv2
//
//  Created by Omer Janjua on 04/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "AppDelegate.h"
#import "SideMenuViewController.h"
#import "DashboardViewController.h"
#import "UIImage+Tint.h"

@interface AppDelegate ()

//Initial property where all the model is copied and passed then through out the app
// 1: Bash file is executed before opening the project which hits all the end points, copy the data into JSON files and save them in the bundle directory
// 2: When app launches copy all the files from the Bundle to the documents directory
// 3: When app launches if not internet, copy the data from the documents directory to the data model
// 4: If internet get the data from the live end point and copy that over the model
@property (retain, nonatomic) Config *config;

@end

@implementation AppDelegate

//TODO: put a overlay on top of the background image used for the side menu
//TODO: pull the background image from the CMS so it doesnt need to be in the editable folder 
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [UserDefault registerDefaults:@{@"downloaded":@NO}];
    [UserDefault synchronize];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self copyingFilesFromBundleToDocumentsDirectory]; //copying files from bundle to documents directory before anything happens
    
    _config = [self apiCall]; // make the API call if(internet){save new data from end point} (!internet) {pull data from DD and save it in the model}

    DashboardViewController *dashboard = [DashboardViewController new];
    [dashboard setConfig:_config]; // pass the model data to the next screen
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:dashboard]; //making the dashboardviewcontroller as the rootviewcontroller
    
//--------------------------------pass the model data to the next screen-------------------------------------------------------------
    SideMenuViewController *menuViewController = [SideMenuViewController new];
    [menuViewController setConfig:_config];
    
//--------------------------------setting up side menu properties-------------------------------------------------------------
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navController leftMenuViewController:menuViewController rightMenuViewController:nil];
    sideMenuViewController.backgroundImage = [[UIImage imageNamed:@"background_image"] tintedImageWithColor:[UIColor colorWithRed:[_config.colourRed floatValue]/255 green:[_config.colourGreen floatValue]/255 blue:[_config.colourBlue floatValue]/255 alpha:0.75]];
    sideMenuViewController.delegate = self;
    sideMenuViewController.panGestureEnabled = YES;
    sideMenuViewController.contentViewInPortraitOffsetCenterX = 75;
    sideMenuViewController.parallaxEnabled = NO;
    sideMenuViewController.animationDuration = 0.25;

//---------------------------------------------------------------------------------------------
    
    self.window.rootViewController = sideMenuViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //calling my methods
    [self flurryIntegration];
    [self appiraterSetup];
    [self statusBarLogic];

    //registering for push notification
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [application registerForRemoteNotifications];
    }
    else
    {
        [application registerForRemoteNotificationTypes: (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Push Notification Setup
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    [UserDefault setObject:[deviceToken description] forKey:@"deviceToken"];
    [UserDefault synchronize];
    
    NSDictionary *deviceData = [NSDictionary dictionaryWithObjectsAndKeys:[[[[deviceToken description] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""], @"device_token", [[UIDevice currentDevice] systemVersion], @"ios_version", @"ios", @"device_type", [[UIDevice currentDevice] name], @"device_name", nil];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:@"%@%@%@", Base_URL, _config.appId, Push_Register] parameters:deviceData success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Push Register Successful");
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Push Notification Registeratio Failed:%@", [error localizedDescription]);
     }];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:_config.appName message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [view show];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:@"Push Notification Registeration Failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    NSLog(@"%@", [error localizedDescription]);
}

#pragma mark - Local Notification Setup
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    //Everytime a user launches the app via local notification he is navigated to the details screen, this method doesnt need amending
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Execute_Detail_View" object:@"Execute_Detail_View_Controller"];
}


#pragma mark - Setup View
-(void)copyingFilesFromBundleToDocumentsDirectory
{
//When app launches copy all the files from the Bundle to the documents directory
//This code is only executed once. ever
    
    BOOL downloaded = [UserDefault boolForKey:@"downloaded"];
    if (!downloaded)
    {
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *config = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"json"];
        [[NSFileManager defaultManager] copyItemAtPath:config toPath:[documentsDirectory stringByAppendingPathComponent:@"config.json"] error:nil];
        
        NSString *items = [[NSBundle mainBundle] pathForResource:@"items" ofType:@"json"];
        [[NSFileManager defaultManager] copyItemAtPath:items toPath:[documentsDirectory stringByAppendingPathComponent:@"items.json"] error:nil];
        
        NSString *location = [[NSBundle mainBundle] pathForResource:@"location" ofType:@"json"];
        [[NSFileManager defaultManager] copyItemAtPath:location toPath:[documentsDirectory stringByAppendingPathComponent:@"location.json"] error:nil];
        
        NSString *services = [[NSBundle mainBundle] pathForResource:@"services" ofType:@"json"];
        [[NSFileManager defaultManager] copyItemAtPath:services toPath:[documentsDirectory stringByAppendingPathComponent:@"services.json"] error:nil];
        
        NSString *todoList = [[NSBundle mainBundle] pathForResource:@"todo-list" ofType:@"json"];
        [[NSFileManager defaultManager] copyItemAtPath:todoList toPath:[documentsDirectory stringByAppendingPathComponent:@"todo-list.json"] error:nil];
        
        NSString *products = [[NSBundle mainBundle] pathForResource:@"products" ofType:@"json"];
        [[NSFileManager defaultManager] copyItemAtPath:products toPath:[documentsDirectory stringByAppendingPathComponent:@"products.json"] error:nil];
        
        NSString *condolences = [[NSBundle mainBundle] pathForResource:@"condolence" ofType:@"json"];
        [[NSFileManager defaultManager] copyItemAtPath:condolences toPath:[documentsDirectory stringByAppendingPathComponent:@"condolence.json"] error:nil];
        
        NSString *funerals = [[NSBundle mainBundle] pathForResource:@"funerals" ofType:@"json"];
        [[NSFileManager defaultManager] copyItemAtPath:funerals toPath:[documentsDirectory stringByAppendingPathComponent:@"funerals.json"] error:nil];
        
        [UserDefault setBool:YES forKey:@"downloaded"];
        [UserDefault synchronize];
    }
}

-(Config *)apiCall
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"config.json"];
    
    //calling this code earlier than the if block so atleast some data is copied in the model to be used for the nsurlrequest api end point link
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:documentsDirectoryPath] options:NSJSONReadingMutableContainers error:nil];
    _config = [MTLJSONAdapter modelOfClass:Config.class fromJSONDictionary:dic error:nil];
    
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", Base_URL, _config.appId, Get_Settings]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    
    if (!error)
    {
//If no error and there's a valid internet connection get the data from the live end point and copy that over the model
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        [responseString writeToFile:documentsDirectoryPath atomically:YES encoding:NSUTF8StringEncoding error:nil];

        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:documentsDirectoryPath] options:NSJSONReadingMutableContainers error:nil];
        _config = [MTLJSONAdapter modelOfClass:Config.class fromJSONDictionary:dic error:nil];
    }
    else
    {
//When app launches if not internet, copy the data from the documents directory to the data model
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:documentsDirectoryPath] options:NSJSONReadingMutableContainers error:nil];
        _config = [MTLJSONAdapter modelOfClass:Config.class fromJSONDictionary:dic error:nil];
        
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:_config.appName message:@"No internet connection avaialble, the app will go into offline mode!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [view show];
    }

    return _config; //
}

-(void)statusBarLogic
{
    if ([_config.statusBarColour isEqualToString:@"Light"]) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    if ([_config.statusBarColour isEqualToString:@"Dark"]) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
}

#pragma mark - Flurry Integration
-(void)flurryIntegration
{
    //note: iOS only allows one crash reporting tool per app, for now we have Flurry enabled to Yes
    [Flurry setCrashReportingEnabled:YES];
    [Flurry startSession:_config.flurry];
}

#pragma mark - Appirater Setup
-(void)appiraterSetup
{
    [Appirater setAppId:_config.appleAppId];
    [Appirater setDaysUntilPrompt:3];
    [Appirater setUsesUntilPrompt:5];
    [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:2];
    [Appirater setDebug:NO];
    [Appirater appLaunched:YES];
}

@end

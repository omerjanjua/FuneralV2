//
//  Imports.h
//  funeralv2
//
//  Created by Omer Janjua on 05/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#ifndef funeralv2_Imports_h
#define funeralv2_Imports_h

//#define UserDefault [[NSUserDefaults alloc]initWithSuiteName:[[NSBundle mainBundle] bundleIdentifier]]
#define UserDefault [NSUserDefaults standardUserDefaults]
#define APP ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#include "RESideMenu.h"
#import "Mantle.h"
#import "AFHTTPRequestOperationManager.h"
#import "Flurry.h"
#import "Appirater.h"
#import "Config.h"
#import "HelperClass.h"

#pragma mark - URL Defines
#define Base_URL @"http://appcms-id.appitized-dev.com/api/"
#define Push_Register @"/push/register"
#define Get_Settings @"/config"
#define Get_Advice @"/services"
#define Get_TodoList @"/todo"
#define Get_Obituaries @"/item-list"
#define Get_Products @"/product"
#define Send_Enquiry @"/enquiry"
#define Send_Feedback @"/feedback"
#define Get_Location @"/locations"
#define Get_Condolence_Message @"/condolence-messages"
#define Get_Funerals @"/funerals"
#define Send_MyDetails @"/mydetails/store"

#endif

//
//  Config.h
//  funeralv2
//
//  Created by Omer Janjua on 06/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "MTLModel.h"
#import "Imports.h"

@interface Config : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSString *welcomeMessage;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *website;
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) NSString *appleAppId;
@property (nonatomic, strong) NSString *appleAppUrl;
@property (nonatomic, strong) NSString *facebook;
@property (nonatomic, strong) NSString *twitter;
@property (nonatomic, strong) NSString *flurry;
@property (nonatomic, strong) NSString *resourceUrl1;
@property (nonatomic, strong) NSString *resourceUrl2;
@property (nonatomic, strong) NSString *iconImageUrl;
@property (nonatomic, strong) NSNumber *colourRed;
@property (nonatomic, strong) NSNumber *colourGreen;
@property (nonatomic, strong) NSNumber *colourBlue;
@property (nonatomic, strong) NSString *statusBarColour;
@property (nonatomic, strong) NSString *countrySettings;
@property (nonatomic, strong) NSString *dashboardButton1;
@property (nonatomic, strong) NSString *dashboardButton2;
@property (nonatomic, strong) NSString *dashboardButton3;
@property (nonatomic, strong) NSString *dashboardButton4;
@property (nonatomic, strong) NSString *dashboardButton5;
@property (nonatomic, strong) NSMutableArray *componentList;

@end

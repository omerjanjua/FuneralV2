//
//  Config.m
//  funeralv2
//
//  Created by Omer Janjua on 06/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "Config.h"

@implementation Config

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"appId" : @"config.app_id",
             @"welcomeMessage" : @"config.welcome_title.data",
             @"email" : @"config.email",
             @"website" : @"config.website",
             @"appName" : @"config.app_name",
             @"appleAppId" : @"config.apple_app_id",
             @"appleAppUrl" : @"config.apple_app_url",
             @"facebook" : @"config.facebook",
             @"twitter" : @"config.twitter",
             @"flurry" : @"config.flurry",
             @"resourceUrl1" : @"config.resource_url_1",
             @"resourceUrl2" : @"config.resource_url_2",
             @"iconImageUrl" : @"config.icon_image_url",
             @"colourRed" : @"config.templatesettings.app_theme_colour.red",
             @"colourGreen" : @"config.templatesettings.app_theme_colour.green",
             @"colourBlue" : @"config.templatesettings.app_theme_colour.blue",
             @"statusBarColour" : @"config.templatesettings.status_bar_colour",
             @"countrySettings" : @"config.templatesettings.country_settings",
             @"dashboardButton1" : @"config.templatesettings.dashboard_button_1",
             @"dashboardButton2" : @"config.templatesettings.dashboard_button_2",
             @"dashboardButton3" : @"config.templatesettings.dashboard_button_3",
             @"dashboardButton4" : @"config.templatesettings.dashboard_button_4",
             @"dashboardButton5" : @"config.templatesettings.dashboard_button_5",
             @"componentList" : @"config.components.list"
             //TODO: do something about the background image for the app being called from the cms once implemented
             };
}

@end

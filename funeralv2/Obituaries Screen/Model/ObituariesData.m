//
//  ObituariesData.m
//  funeralv2
//
//  Created by Omer Janjua on 09/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "ObituariesData.h"

@implementation ObituariesData

@synthesize description;

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"title": @"title.data",
             @"description" : @"details.data",
             @"obituaryDate" : @"ext_funeral_date",
             @"imageUrl": @"ext_image.image_url"
             };
}

@end

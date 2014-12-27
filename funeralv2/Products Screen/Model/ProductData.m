//
//  ProductData.m
//  funeralv2
//
//  Created by Omer Janjua on 10/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "ProductData.h"

@implementation ProductData

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"title": @"title.data",
             @"imageUrl": @"ext_image_crop.image_url"
             };
}

@end

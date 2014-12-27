//
//  ProductItem.m
//  funeralv2
//
//  Created by Omer Janjua on 10/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "ProductItem.h"

@implementation ProductItem

@synthesize description;

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                                          @"title": @"title.data",
                                                                                          @"description": @"description.data",
                                                                                          @"price": @"price",
                                                                                          @"websiteUrl": @"ext_url.data",
                                                                                          @"imageUrl": @"ext_image_crop.image_url",
                                                                                          @"imageUrl2": @"ext_image_crop_1.image_url",
                                                                                          @"imageUrl3": @"ext_image_crop_2.image_url",
                                                                                          @"imageUrl4": @"ext_image_crop_3.image_url"
                                                                                          }];
}

@end

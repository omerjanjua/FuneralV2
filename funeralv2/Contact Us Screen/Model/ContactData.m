//
//  ContactData.m
//  funeralv2
//
//  Created by Omer Janjua on 26/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "ContactData.h"

@implementation ContactData

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"pinId": @"id",
             @"name": @"name",
             @"latitude": @"latitude",
             @"longitude": @"longitude",
             @"email" : @"email",
             @"telephone" : @"telephone",
             @"fullAddress": @"full_address"
             };
}

@end

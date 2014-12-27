//
//  AdviceData.m
//  funeralv2
//
//  Created by Omer Janjua on 29/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "AdviceData.h"

@implementation AdviceData

@synthesize description;

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"title" : @"title.data",
             @"description" : @"description.data"
             };
}

@end

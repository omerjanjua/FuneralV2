//
//  FuneralData.m
//  funeralv2
//
//  Created by Omer Janjua on 02/10/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "FuneralData.h"

@implementation FuneralData

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"funeralName" : @"name",
             @"beaconName" : @"ibeacon_name",
             @"beaconMessage" : @"message",
             @"beaconUuid" : @"ibeacon_uuid",
             @"beaconMajor" : @"ibeacon_major",
             @"beaconMinor" : @"ibeacon_minor"
             };
}

@end

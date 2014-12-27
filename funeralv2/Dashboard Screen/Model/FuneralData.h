//
//  FuneralData.h
//  funeralv2
//
//  Created by Omer Janjua on 02/10/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "MTLModel.h"
#import "Imports.h"

@interface FuneralData : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *funeralName;
@property (nonatomic, strong) NSString *beaconName;
@property (nonatomic, strong) NSString *beaconMessage;
@property (nonatomic, strong) NSString *beaconUuid;
@property (nonatomic, strong) NSString *beaconMajor;
@property (nonatomic, strong) NSString *beaconMinor;

@end

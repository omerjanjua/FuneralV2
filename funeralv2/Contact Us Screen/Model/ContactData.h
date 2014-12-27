//
//  ContactData.h
//  funeralv2
//
//  Created by Omer Janjua on 26/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "MTLModel.h"

@interface ContactData : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *pinId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *fullAddress;

@end

//
//  AdviceData.h
//  funeralv2
//
//  Created by Omer Janjua on 29/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "MTLModel.h"
#import "Imports.h"

@interface AdviceData : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;

@end

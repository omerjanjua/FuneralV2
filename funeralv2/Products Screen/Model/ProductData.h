//
//  ProductData.h
//  funeralv2
//
//  Created by Omer Janjua on 10/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "MTLModel.h"

@interface ProductData : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *imageUrl;

@end

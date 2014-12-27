//
//  ProductItem.h
//  funeralv2
//
//  Created by Omer Janjua on 10/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "ProductData.h"

@interface ProductItem : ProductData

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* description;
@property (strong, nonatomic) NSString* price;
@property (strong, nonatomic) NSString* websiteUrl;
@property (strong, nonatomic) NSString* imageUrl;
@property (strong, nonatomic) NSString* imageUrl2;
@property (strong, nonatomic) NSString* imageUrl3;
@property (strong, nonatomic) NSString* imageUrl4;

@end

//
//  ObituariesData.h
//  funeralv2
//
//  Created by Omer Janjua on 09/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "MTLModel.h"

@interface ObituariesData : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *obituaryDate;
@property (nonatomic, strong) NSString *imageUrl;

@end

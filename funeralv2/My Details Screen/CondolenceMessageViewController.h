//
//  CondolenceMessageViewController.h
//  funeralv2
//
//  Created by Omer Janjua on 28/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Imports.h"
@class CreateMyDetailsViewController;
@interface CondolenceMessageViewController : UIViewController

@property (retain, nonatomic) Config *config;

@property (nonatomic,weak) CreateMyDetailsViewController *caller;

@end

//
//  MemoryGivingContactUsViewController.h
//  funeralv2
//
//  Created by Omer Janjua on 23/10/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Imports.h"

@interface MemoryGivingContactUsViewController : UIViewController

@property (retain, nonatomic) Config *config;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendAMessasageConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *clickToCallConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@end
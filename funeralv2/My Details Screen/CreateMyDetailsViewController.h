//
//  CreateMyDetailsViewController.h
//  funeralv2
//
//  Created by Omer Janjua on 27/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Imports.h"

@interface CreateMyDetailsViewController : UIViewController

@property (retain, nonatomic) Config *config;
@property (weak, nonatomic) NSString *condolenceMessage;
@property (retain, nonatomic) UIViewController *caller;

-(void)condolencePicked:(NSString *)condolenceMessage;

@end

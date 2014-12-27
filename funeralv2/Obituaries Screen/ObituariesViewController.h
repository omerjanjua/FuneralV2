//
//  ObituariesViewController.h
//  funeralv2
//
//  Created by Omer Janjua on 21/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Imports.h"
@import MessageUI;

@interface ObituariesViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (retain, nonatomic) Config *config;

-(void)showEmailController:(NSString *)testString;

@end

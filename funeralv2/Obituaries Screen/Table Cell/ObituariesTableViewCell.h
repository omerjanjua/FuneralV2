//
//  ObituariesTableViewCell.h
//  funeralv2
//
//  Created by Omer Janjua on 09/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Imports.h"
#import "ObituariesViewController.h"
@import Social;

@interface ObituariesTableViewCell : UITableViewCell <MFMessageComposeViewControllerDelegate, UIActionSheetDelegate>

@property (retain, nonatomic) Config *config;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *obituaryImage;
@property (weak, nonatomic) UIViewController *controller;

- (IBAction)shareButtonPressed:(id)sender;

@end

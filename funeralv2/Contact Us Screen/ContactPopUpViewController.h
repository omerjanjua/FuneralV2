//
//  ContactPopUpViewController.h
//  funeralv2
//
//  Created by Omer Janjua on 29/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MessageUI;
@import MapKit;

@interface ContactPopUpViewController : UIViewController <MFMailComposeViewControllerDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property (weak, nonatomic) UIViewController *controller;

@property (assign, nonatomic) NSString *name;
@property (assign, nonatomic) NSString *email;
@property (assign, nonatomic) NSString *telephone;
@property (assign, nonatomic) NSString *address;
@property (assign, nonatomic) CLLocationDegrees userCurrentLat;
@property (assign, nonatomic) CLLocationDegrees userCurrentLong;
@property (assign, nonatomic) NSString *contactDataLat;
@property (assign, nonatomic) NSString *contactDataLong;
@property (retain, nonatomic) Config *config;
@property (weak, nonatomic) UIViewController *popupCaller;

- (IBAction)emailButtonPressed:(id)sender;
- (IBAction)callNowButtonPressed:(id)sender;
- (IBAction)getDirectionsButtonPressed:(id)sender;

@end

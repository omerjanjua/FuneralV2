//
//  ContactUsViewController.h
//  funeralv2
//
//  Created by Omer Janjua on 21/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Imports.h"
@import MapKit;

@interface ContactUsViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) Config *config;
@property (strong, nonatomic) NSArray *data;
@property (nonatomic, assign) int currentSelectedIndex;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

-(void)showMapAnnotationWithPinId:(NSString *)pinID;

@end

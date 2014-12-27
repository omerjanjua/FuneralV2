//
//  LocationPin.h
//  funeralv2
//
//  Created by Omer Janjua on 26/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface LocationPin : UIView <MKAnnotation>

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *pinID;

@end

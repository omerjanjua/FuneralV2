//
//  DashboardViewController.h
//  funeralv2
//
//  Created by Omer Janjua on 06/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Imports.h"
@import CoreLocation;

@interface DashboardViewController : UIViewController <CLLocationManagerDelegate>

@property (retain, nonatomic) Config *config;

@end

/*
 
 //DISCLAIMER: I realise this is the worst possible way of implementing this approach, but at the time of this code being implemented Apple\s method did not accept arrays for iBeacon values. so for each iBeacon functionality being implemented in the class the below steps had to copied and pasted.
 
 1: iBeacon CLBeaconRegion property declared 
 
 2: iBeacon CLLocationManager property declared
 
 3: In locationManager didEnterRegion method use the above properties with method startRangingBeaconsInRegion
 
 4: In the same method get the beacon name & message from the array pulled from the CMS [(FuneralData *)[_data objectAtIndex:1]
 
 5: In locationManager didExitRegion method use the step 1 and step 2 properties with method stopRangingBeaconsInRegion
 
 6: In locationManager didRangeBeacons method get the beacon message from the CMS [(FuneralData *)[_data objectAtIndex:1] to be posted as a UILocalNotification
 
 7: In setupiBeacons method carry out the necesarry steps to initiliase the beacons 
 
 */
//
//  MemoryGivingDonationTableViewCell.h
//  funeralv2
//
//  Created by Omer Janjua on 25/11/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemoryGivingDonationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *donationAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *donationDateLabel;

@end

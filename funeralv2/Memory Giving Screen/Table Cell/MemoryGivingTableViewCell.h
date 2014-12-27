//
//  MemoryGivingTableViewCell.h
//  funeralv2
//
//  Created by Omer Janjua on 29/10/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemoryGivingTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *funeralLabel;
@property (weak, nonatomic) IBOutlet UILabel *charityLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

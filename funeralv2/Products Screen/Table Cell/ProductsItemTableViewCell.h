//
//  ProductsItemTableViewCell.h
//  funeralv2
//
//  Created by Omer Janjua on 10/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductsItemTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;

@end

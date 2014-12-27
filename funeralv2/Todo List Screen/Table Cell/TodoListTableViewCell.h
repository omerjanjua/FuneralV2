//
//  TodoListTableViewCell.h
//  funeralv2
//
//  Created by Omer Janjua on 01/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodoListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;

@end

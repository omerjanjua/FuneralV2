//
//  TodoListViewController.h
//  funeralv2
//
//  Created by Omer Janjua on 21/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodoListViewController : UIViewController<UITextFieldDelegate>{
    
    __weak IBOutlet NSLayoutConstraint *navigationViewHeightConstraint;
}

@property (retain, nonatomic) Config *config;

@end

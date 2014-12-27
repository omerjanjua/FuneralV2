//
//  ObituaryUIWebViewController.h
//  funeralv2
//
//  Created by Omer Janjua on 29/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Imports.h"

@interface ObituaryUIWebViewController : UIViewController <UIWebViewDelegate>

@property (retain, nonatomic) Config *config;
@property (retain, nonatomic) NSString *websiteUrl;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

//
//  ProductsUIWebViewController.h
//  funeralv2
//
//  Created by Omer Janjua on 28/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Imports.h"

@interface ProductsUIWebViewController : UIViewController <UIWebViewDelegate>

@property (retain, nonatomic) Config *config;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
-(instancetype)initWithURL:(NSURL *)aURL;
@end

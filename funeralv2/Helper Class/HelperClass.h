//
//  HelperClass.h
//  funeralv2
//
//  Created by Omer Janjua on 19/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Imports.h"
#import "JVFloatLabeledTextField.h"

@interface HelperClass : NSObject

+(void)dashboardSetup:(NSString *)statusBarColour red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue backgroundImageView:(UIImageView *)backgroundImageView sideMenuButton:(UIButton *)sideMenuButton closeButton:(UIButton *)closeButton
           backButton:(UIButton *)backButton addMenuButton:(UIButton *)addMenuButton tickMenuButton:(UIButton *)tickMenuButton navigationTitle:(UILabel *)navigationTitle navigationSubTitle:(UILabel *)navigationSubTitle navigationThirdTitle:(UILabel *)navigationThirdTitle dashboardImage:(UIImageView *)dashboardImage submitButton:(UIButton *)submitButton saveButton:(UIButton *)saveButton todoListTextField:(JVFloatLabeledTextField *)todoListTextField uiViewColour:(UIView *)uiViewColour uisegmentedControlColour:(UISegmentedControl *)uisegmentedControlColour;

+(void)dashboardScrollViewSetup:(NSString *)option1 option2:(NSString *)option2 option3:(NSString *)option3 option4:(NSString *)option4 option5:(NSString *)option5 scrollViewButton1:(UIButton *)scrollViewButton1 scrollViewButton2:(UIButton *)scrollViewButton2 scrollViewButton3:(UIButton *)scrollViewButton3 scrollViewButton4:(UIButton *)scrollViewButton4 scrollViewButton5:(UIButton *)scrollViewButton5;

+(BOOL)validateEmail:(NSString *)text;

+(BOOL)validateNotEmpty:(NSString *)text;

+(NSString *)removeSpanTags:(NSString *)string;

+(NSString *)stringByStrippingHTML:(NSString*)string;

+(UIButton *)CMSResponseSetEnquiryButtonText:(UIButton *)button CMSSettings:(NSString *)CMSSettings;

+(NSString *)CMSResponseSetEnquiryText:(UILabel *)titleLabel CMSSettings:(NSString *)CMSSettings;

+(NSString *)CMSResponseSetEnquiryErrorMessage:(NSString *)CMSSettings;

+(NSString *)CMSResponseSetCurrencySign:(NSString *)CMSSettings price:(NSString *)price;

@end

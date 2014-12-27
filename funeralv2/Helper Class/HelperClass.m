//
//  HelperClass.m
//  funeralv2
//
//  Created by Omer Janjua on 19/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "HelperClass.h"
#import "UIImage+Tint.h"

@implementation HelperClass

+(void)dashboardSetup:(NSString *)statusBarColour        //coming from model
                  red:(CGFloat)red                       //coming from model
                green:(CGFloat)green                     //coming from model
                 blue:(CGFloat)blue                      //coming from model
  backgroundImageView:(UIImageView *)backgroundImageView
       sideMenuButton:(UIButton *)sideMenuButton
          closeButton:(UIButton *)closeButton
           backButton:(UIButton *)backButton
        addMenuButton:(UIButton *)addMenuButton
       tickMenuButton:(UIButton *)tickMenuButton
      navigationTitle:(UILabel *)navigationTitle
   navigationSubTitle:(UILabel *)navigationSubTitle
 navigationThirdTitle:(UILabel *)navigationThirdTitle
       dashboardImage:(UIImageView *)dashboardImage
         submitButton:(UIButton *)submitButton
           saveButton:(UIButton *)saveButton
    todoListTextField:(JVFloatLabeledTextField *)todoListTextField
         uiViewColour:(UIView *)uiViewColour
uisegmentedControlColour:(UISegmentedControl *)uisegmentedControlColour

{
    if ([statusBarColour isEqualToString:@"Light"])
    {
        [sideMenuButton setImage:[UIImage imageNamed:@"navigation-menu-button"] forState:UIControlStateNormal];
        [closeButton setImage:[UIImage imageNamed:@"navigation-close-button"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigation-back-button"] forState:UIControlStateNormal];
        [addMenuButton setImage:[UIImage imageNamed:@"navigation-add-button"] forState:UIControlStateNormal];
        [tickMenuButton setImage:[UIImage imageNamed:@"navigation-tick-button"] forState:UIControlStateNormal];
        [navigationTitle setTextColor:[UIColor whiteColor]];
        [navigationSubTitle setTextColor:[UIColor whiteColor]];
        [navigationThirdTitle setTextColor:[UIColor whiteColor]];
        [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [todoListTextField setTextColor:[UIColor whiteColor]];
        [todoListTextField setFloatingLabelActiveTextColor:[UIColor whiteColor]];
        [todoListTextField setFloatingLabelTextColor:[UIColor whiteColor]];
        
        [uiViewColour setBackgroundColor:[UIColor whiteColor]];
        [uisegmentedControlColour setTintColor:[UIColor whiteColor]];
    }
    if ([statusBarColour isEqualToString:@"Dark"])
    {
        [sideMenuButton setImage:[UIImage imageNamed:@"navigation-menu-button-black"] forState:UIControlStateNormal];
        [closeButton setImage:[UIImage imageNamed:@"navigation-close-button-black"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigation-back-button-black"] forState:UIControlStateNormal];
        [addMenuButton setImage:[UIImage imageNamed:@"navigation-add-button-black"] forState:UIControlStateNormal];
        [tickMenuButton setImage:[UIImage imageNamed:@"navigation-tick-button-black"] forState:UIControlStateNormal];
        [navigationTitle setTextColor:[UIColor blackColor]];
        [navigationSubTitle setTextColor:[UIColor blackColor]];
        [navigationThirdTitle setTextColor:[UIColor blackColor]];
        [submitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [todoListTextField setTextColor:[UIColor blackColor]];
        [todoListTextField setFloatingLabelActiveTextColor:[UIColor blackColor]];
        [todoListTextField setFloatingLabelTextColor:[UIColor blackColor]];
        
        [uiViewColour setBackgroundColor:[UIColor blackColor]];
        [uisegmentedControlColour setTintColor:[UIColor blackColor]];
    }

    [backgroundImageView setImage:[[UIImage imageNamed:@"background_image"] tintedImageWithColor:[UIColor colorWithRed:red/255 green:green/255 blue:blue/255 alpha:1]]]; //TODO: get from CMS
    [dashboardImage setImage:[UIImage imageNamed:@"dashboard-image"]]; //TODO: get from CMS
}

//TODO: refactor
+(void)dashboardScrollViewSetup:(NSString *)option1     //coming from model
                        option2:(NSString *)option2     //coming from model
                        option3:(NSString *)option3     //coming from model
                        option4:(NSString *)option4     //coming from model
                        option5:(NSString *)option5     //coming from model
              scrollViewButton1:(UIButton *)scrollViewButton1
              scrollViewButton2:(UIButton *)scrollViewButton2
              scrollViewButton3:(UIButton *)scrollViewButton3
              scrollViewButton4:(UIButton *)scrollViewButton4
              scrollViewButton5:(UIButton *)scrollViewButton5
{
    
//-----------------------Advice--------------------------------------
    if ([option1 isEqualToString:@"advice"])
    {
        [scrollViewButton1 setImage:[UIImage imageNamed:@"dashboard-advice"] forState:UIControlStateNormal];
    }
    
    if ([option2 isEqualToString:@"advice"])
    {
        [scrollViewButton2 setImage:[UIImage imageNamed:@"dashboard-advice"] forState:UIControlStateNormal];
    }
    
    if ([option3 isEqualToString:@"advice"])
    {
        [scrollViewButton3 setImage:[UIImage imageNamed:@"dashboard-advice"] forState:UIControlStateNormal];
    }
    
    if ([option4 isEqualToString:@"advice"])
    {
        [scrollViewButton4 setImage:[UIImage imageNamed:@"dashboard-advice"] forState:UIControlStateNormal];
    }
    
    if ([option5 isEqualToString:@"advice"])
    {
        [scrollViewButton5 setImage:[UIImage imageNamed:@"dashboard-advice"] forState:UIControlStateNormal];
    }
    
//-----------------------Contact Us--------------------------------------
    if ([option1 isEqualToString:@"contact_us"])
    {
        [scrollViewButton1 setImage:[UIImage imageNamed:@"dashboard-contact-us"] forState:UIControlStateNormal];
    }
    
    if ([option2 isEqualToString:@"contact_us"])
    {
        [scrollViewButton2 setImage:[UIImage imageNamed:@"dashboard-contact-us"] forState:UIControlStateNormal];
    }
    
    if ([option3 isEqualToString:@"contact_us"])
    {
        [scrollViewButton3 setImage:[UIImage imageNamed:@"dashboard-contact-us"] forState:UIControlStateNormal];
    }
    
    if ([option4 isEqualToString:@"contact_us"])
    {
        [scrollViewButton4 setImage:[UIImage imageNamed:@"dashboard-contact-us"] forState:UIControlStateNormal];
    }
    
    if ([option5 isEqualToString:@"contact_us"])
    {
        [scrollViewButton5 setImage:[UIImage imageNamed:@"dashboard-contact-us"] forState:UIControlStateNormal];
    }
    
//-----------------------Donations UK--------------------------------------
    if ([option1 isEqualToString:@"donations_uk"])
    {
        [scrollViewButton1 setImage:[UIImage imageNamed:@"dashboard-donations-uk"] forState:UIControlStateNormal];
    }
    
    if ([option2 isEqualToString:@"donations_uk"])
    {
        [scrollViewButton2 setImage:[UIImage imageNamed:@"dashboard-donations-uk"] forState:UIControlStateNormal];
    }
    
    if ([option3 isEqualToString:@"donations_uk"])
    {
        [scrollViewButton3 setImage:[UIImage imageNamed:@"dashboard-donations-uk"] forState:UIControlStateNormal];
    }
    
    if ([option4 isEqualToString:@"donations_uk"])
    {
        [scrollViewButton4 setImage:[UIImage imageNamed:@"dashboard-donations-uk"] forState:UIControlStateNormal];
    }
    
    if ([option5 isEqualToString:@"donations_uk"])
    {
        [scrollViewButton5 setImage:[UIImage imageNamed:@"dashboard-donations-uk"] forState:UIControlStateNormal];
    }
    
//-----------------------Donations US--------------------------------------
    if ([option1 isEqualToString:@"donations_us"])
    {
        [scrollViewButton1 setImage:[UIImage imageNamed:@"dashboard-donations-us"] forState:UIControlStateNormal];
    }
    
    if ([option2 isEqualToString:@"donations_us"])
    {
        [scrollViewButton2 setImage:[UIImage imageNamed:@"dashboard-donations-us"] forState:UIControlStateNormal];
    }
    
    if ([option3 isEqualToString:@"donations_us"])
    {
        [scrollViewButton3 setImage:[UIImage imageNamed:@"dashboard-donations-us"] forState:UIControlStateNormal];
    }
    
    if ([option4 isEqualToString:@"donations_us"])
    {
        [scrollViewButton4 setImage:[UIImage imageNamed:@"dashboard-donations-us"] forState:UIControlStateNormal];
    }
    
    if ([option5 isEqualToString:@"donations_us"])
    {
        [scrollViewButton5 setImage:[UIImage imageNamed:@"dashboard-donations-us"] forState:UIControlStateNormal];
    }
    
//-----------------------Facebook--------------------------------------
    if ([option1 isEqualToString:@"facebook"])
    {
        [scrollViewButton1 setImage:[UIImage imageNamed:@"dashboard-facebook"] forState:UIControlStateNormal];
    }
    
    if ([option2 isEqualToString:@"facebook"])
    {
        [scrollViewButton2 setImage:[UIImage imageNamed:@"dashboard-facebook"] forState:UIControlStateNormal];
    }
    
    if ([option3 isEqualToString:@"facebook"])
    {
        [scrollViewButton3 setImage:[UIImage imageNamed:@"dashboard-facebook"] forState:UIControlStateNormal];
    }
    
    if ([option4 isEqualToString:@"facebook"])
    {
        [scrollViewButton4 setImage:[UIImage imageNamed:@"dashboard-facebook"] forState:UIControlStateNormal];
    }
    
    if ([option5 isEqualToString:@"facebook"])
    {
        [scrollViewButton5 setImage:[UIImage imageNamed:@"dashboard-facebook"] forState:UIControlStateNormal];
    }
    
    
    
//-----------------------My Details--------------------------------------
    if ([option1 isEqualToString:@"my_details"])
    {
        [scrollViewButton1 setImage:[UIImage imageNamed:@"dashboard-my-details"] forState:UIControlStateNormal];
    }
    
    if ([option2 isEqualToString:@"my_details"])
    {
        [scrollViewButton2 setImage:[UIImage imageNamed:@"dashboard-my-details"] forState:UIControlStateNormal];
    }
    
    if ([option3 isEqualToString:@"my_details"])
    {
        [scrollViewButton3 setImage:[UIImage imageNamed:@"dashboard-my-details"] forState:UIControlStateNormal];
    }
    
    if ([option4 isEqualToString:@"my_details"])
    {
        [scrollViewButton4 setImage:[UIImage imageNamed:@"dashboard-my-details"] forState:UIControlStateNormal];
    }
    
    if ([option5 isEqualToString:@"my_details"])
    {
        [scrollViewButton5 setImage:[UIImage imageNamed:@"dashboard-my-details"] forState:UIControlStateNormal];
    }
    
//-----------------------Obituaries--------------------------------------
    if ([option1 isEqualToString:@"obituaries"])
    {
        [scrollViewButton1 setImage:[UIImage imageNamed:@"dashboard-obituaries"] forState:UIControlStateNormal];
    }
    
    if ([option2 isEqualToString:@"obituaries"])
    {
        [scrollViewButton2 setImage:[UIImage imageNamed:@"dashboard-obituaries"] forState:UIControlStateNormal];
    }
    
    if ([option3 isEqualToString:@"obituaries"])
    {
        [scrollViewButton3 setImage:[UIImage imageNamed:@"dashboard-obituaries"] forState:UIControlStateNormal];
    }
    
    if ([option4 isEqualToString:@"obituaries"])
    {
        [scrollViewButton4 setImage:[UIImage imageNamed:@"dashboard-obituaries"] forState:UIControlStateNormal];
    }
    
    if ([option5 isEqualToString:@"obituaries"])
    {
        [scrollViewButton5 setImage:[UIImage imageNamed:@"dashboard-obituaries"] forState:UIControlStateNormal];
    }
    
//-----------------------Products UK--------------------------------------
    if ([option1 isEqualToString:@"products_uk"])
    {
        [scrollViewButton1 setImage:[UIImage imageNamed:@"dashboard-products-uk"] forState:UIControlStateNormal];
    }
    
    if ([option2 isEqualToString:@"products_uk"])
    {
        [scrollViewButton2 setImage:[UIImage imageNamed:@"dashboard-products-uk"] forState:UIControlStateNormal];
    }
    
    if ([option3 isEqualToString:@"products_uk"])
    {
        [scrollViewButton3 setImage:[UIImage imageNamed:@"dashboard-products-uk"] forState:UIControlStateNormal];
    }
    
    if ([option4 isEqualToString:@"products_uk"])
    {
        [scrollViewButton4 setImage:[UIImage imageNamed:@"dashboard-products-uk"] forState:UIControlStateNormal];
    }
    
    if ([option5 isEqualToString:@"products_uk"])
    {
        [scrollViewButton5 setImage:[UIImage imageNamed:@"dashboard-products-uk"] forState:UIControlStateNormal];
    }

//-----------------------Products US--------------------------------------
    if ([option1 isEqualToString:@"products_us"])
    {
        [scrollViewButton1 setImage:[UIImage imageNamed:@"dashboard-products-us"] forState:UIControlStateNormal];
    }
    
    if ([option2 isEqualToString:@"products_us"])
    {
        [scrollViewButton2 setImage:[UIImage imageNamed:@"dashboard-products-us"] forState:UIControlStateNormal];
    }
    
    if ([option3 isEqualToString:@"products_us"])
    {
        [scrollViewButton3 setImage:[UIImage imageNamed:@"dashboard-products-us"] forState:UIControlStateNormal];
    }
    
    if ([option4 isEqualToString:@"products_us"])
    {
        [scrollViewButton4 setImage:[UIImage imageNamed:@"dashboard-products-us"] forState:UIControlStateNormal];
    }
    
    if ([option5 isEqualToString:@"products_us"])
    {
        [scrollViewButton5 setImage:[UIImage imageNamed:@"dashboard-products-us"] forState:UIControlStateNormal];
    }
    
//-----------------------Todo--------------------------------------
    if ([option1 isEqualToString:@"todo"])
    {
        [scrollViewButton1 setImage:[UIImage imageNamed:@"dashboard-todo"] forState:UIControlStateNormal];
    }
    
    if ([option2 isEqualToString:@"todo"])
    {
        [scrollViewButton2 setImage:[UIImage imageNamed:@"dashboard-todo"] forState:UIControlStateNormal];
    }
    
    if ([option3 isEqualToString:@"todo"])
    {
        [scrollViewButton3 setImage:[UIImage imageNamed:@"dashboard-todo"] forState:UIControlStateNormal];
    }
    
    if ([option4 isEqualToString:@"todo"])
    {
        [scrollViewButton4 setImage:[UIImage imageNamed:@"dashboard-todo"] forState:UIControlStateNormal];
    }
    
    if ([option5 isEqualToString:@"todo"])
    {
        [scrollViewButton5 setImage:[UIImage imageNamed:@"dashboard-todo"] forState:UIControlStateNormal];
    }
    
    
//-----------------------Twitter--------------------------------------
    if ([option1 isEqualToString:@"twitter"])
    {
        [scrollViewButton1 setImage:[UIImage imageNamed:@"dashboard-twitter"] forState:UIControlStateNormal];
    }
    
    if ([option2 isEqualToString:@"twitter"])
    {
        [scrollViewButton2 setImage:[UIImage imageNamed:@"dashboard-twitter"] forState:UIControlStateNormal];
    }
    
    if ([option3 isEqualToString:@"twitter"])
    {
        [scrollViewButton3 setImage:[UIImage imageNamed:@"dashboard-twitter"] forState:UIControlStateNormal];
    }
    
    if ([option4 isEqualToString:@"twitter"])
    {
        [scrollViewButton4 setImage:[UIImage imageNamed:@"dashboard-twitter"] forState:UIControlStateNormal];
    }
    
    if ([option5 isEqualToString:@"twitter"])
    {
        [scrollViewButton5 setImage:[UIImage imageNamed:@"dashboard-twitter"] forState:UIControlStateNormal];
    }
    
    
//-----------------------Visit Website--------------------------------------
    if ([option1 isEqualToString:@"visit_website"])
    {
        [scrollViewButton1 setImage:[UIImage imageNamed:@"dashboard-visit-website"] forState:UIControlStateNormal];
    }
    
    if ([option2 isEqualToString:@"visit_website"])
    {
        [scrollViewButton2 setImage:[UIImage imageNamed:@"dashboard-visit-website"] forState:UIControlStateNormal];
    }
    
    if ([option3 isEqualToString:@"visit_website"])
    {
        [scrollViewButton3 setImage:[UIImage imageNamed:@"dashboard-visit-website"] forState:UIControlStateNormal];
    }
    
    if ([option4 isEqualToString:@"visit_website"])
    {
        [scrollViewButton4 setImage:[UIImage imageNamed:@"dashboard-visit-website"] forState:UIControlStateNormal];
    }
    
    if ([option5 isEqualToString:@"visit_website"])
    {
        [scrollViewButton5 setImage:[UIImage imageNamed:@"dashboard-visit-website"] forState:UIControlStateNormal];
    }
    
    
//-----------------------Wish List--------------------------------------
    if ([option1 isEqualToString:@"wish_list"])
    {
        [scrollViewButton1 setImage:[UIImage imageNamed:@"dashboard-wish-list"] forState:UIControlStateNormal];
    }
    
    if ([option2 isEqualToString:@"wish_list"])
    {
        [scrollViewButton2 setImage:[UIImage imageNamed:@"dashboard-wish-list"] forState:UIControlStateNormal];
    }
    
    if ([option3 isEqualToString:@"wish_list"])
    {
        [scrollViewButton3 setImage:[UIImage imageNamed:@"dashboard-wish-list"] forState:UIControlStateNormal];
    }
    
    if ([option4 isEqualToString:@"wish_list"])
    {
        [scrollViewButton4 setImage:[UIImage imageNamed:@"dashboard-wish-list"] forState:UIControlStateNormal];
    }
    
    if ([option5 isEqualToString:@"wish_list"])
    {
        [scrollViewButton5 setImage:[UIImage imageNamed:@"dashboard-wish-list"] forState:UIControlStateNormal];
    }
}

+(BOOL)validateEmail:(NSString *)text
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:text];
}

+(BOOL)validateNotEmpty:(NSString *)text
{
    return ([text length] == 0) ? NO : YES;
}

+(NSString *)removeSpanTags:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"<span class=\"match\">" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"</span>" withString:@""];
    
    return string;
}

+(NSString *)stringByStrippingHTML:(NSString*)string
{
    NSRange range;
    while ((range = [string rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
    {
        string = [string stringByReplacingCharactersInRange:range withString:@""];
    }
    return string;
}

+(UIButton *)CMSResponseSetEnquiryButtonText:(UIButton *)button CMSSettings:(NSString *)CMSSettings
{
    if ([CMSSettings isEqualToString:@"UK"]) {
        [button setTitle:@"Enquiry" forState:UIControlStateNormal];
    } else if ([CMSSettings isEqualToString:@"USA"]) {
        [button setTitle:@"Inquiry" forState:UIControlStateNormal];
    }
    
    return button;
}

+(NSString *)CMSResponseSetEnquiryText:(UILabel *)titleLabel CMSSettings:(NSString *)CMSSettings
{
    if ([CMSSettings isEqualToString:@"UK"]) {
        titleLabel.text = @"Enquiry";
    } else if ([CMSSettings isEqualToString:@"USA"]) {
        titleLabel.text = @"Inquiry";
    }
    
    return titleLabel.text;
}

+(NSString *)CMSResponseSetEnquiryErrorMessage:(NSString *)CMSSettings
{
    NSString *string;
    
    if ([CMSSettings isEqualToString:@"UK"]) {
        string = @"Your enquiry message has now been sent.";
    } else if ([CMSSettings isEqualToString:@"USA"]) {
        string = @"Your inquiry message has now been sent.";
    }
    
    return string;
}

+(NSString *)CMSResponseSetCurrencySign:(NSString *)CMSSettings price:(NSString *)price
{
    NSString *string;
    
    if ([CMSSettings isEqualToString:@"UK"]) {
        string = @"£";
    } else if ([CMSSettings isEqualToString:@"USA"]) {
        string = @"$";
    }
    
    if ([price isEqualToString:@""]) {
        string = @"";
    }
    
    return string;
}

@end
//
//  LocationPin.m
//  funeralv2
//
//  Created by Omer Janjua on 26/09/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "LocationPin.h"

@implementation LocationPin

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(BOOL)isEqual:(id)object{
    
    if (![object isKindOfClass:[LocationPin class]]) {
        return NO;
    }
    
    if ([_pinID isEqualToString:((LocationPin *)object).pinID]) {
        return  YES;
    }
    return NO;
}

@end

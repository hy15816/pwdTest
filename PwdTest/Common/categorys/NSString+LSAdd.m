//
//  NSString+LSAdd.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/7.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "NSString+LSAdd.h"

@implementation NSString (LSAdd)

- (CGFloat)heightWithFont:(UIFont*)font width:(CGFloat)width {
    
    return [self sizeWithFont:font width:width].height;
    
}
- (CGSize)sizeWithFont:(UIFont*)font width:(CGFloat)width {
    
    CGSize size;
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
        
        CGRect rect = [self boundingRectWithSize:CGSizeMake(width, HUGE)
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:@{NSFontAttributeName:font} context:nil];
        size = rect.size;
        
    }else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        size = [self sizeWithFont:font constrainedToSize:CGSizeMake(width, HUGE) lineBreakMode:NSLineBreakByWordWrapping];
#pragma clang diagnostic pop

    }
    
    
    return size;
}
@end

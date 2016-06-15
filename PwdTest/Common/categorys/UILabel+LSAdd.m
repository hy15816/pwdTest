//
//  UILabel+LSAdd.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/17.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "UILabel+LSAdd.h"

@implementation UILabel (LSAdd)


- (void)centerLineAttributed:(NSRange)range color:(UIColor*)color {
    
//    NSUInteger length = [self.text length];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:range];
    [attri addAttribute:NSStrikethroughColorAttributeName value:color range:range];
    
    self.attributedText = attri;
//    return attri;
}

@end

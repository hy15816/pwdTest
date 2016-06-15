//
//  LSQuickLoginButton.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/3.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "LSQuickLoginButton.h"
#import "UIView+YYAdd.h"

@implementation LSQuickLoginButton

- (void)awakeFromNib {
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // 调整图片的位置和尺寸
    self.imageView.top = 0;
    self.imageView.centerX = self.width *.5;
//    self.imageView.height = self.height *.6;
//    self.imageView.width = self.imageView.height;
    
    // 调整文字的的
    self.titleLabel.left = 0;
    self.titleLabel.top = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.top;
//    NSLog(@"x=0,y=%f,w=%f,h=%f",self.imageView.height,self.width,self.height - self.titleLabel.top);
}
@end

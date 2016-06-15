//
//  LSLoginTextField.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/3.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "LSLoginTextField.h"

@interface LSLoginTextField () <UITextFieldDelegate>

@end

@implementation LSLoginTextField

// 占位文字颜色
#define kPlaceholderColorKey @"placeholderLabel.textColor"
// 默认的占位文字颜色
#define kPlaceholderDefaultColor [UIColor grayColor]
// 聚焦的占位文字颜色
#define kPlaceholderFocusColor [UIColor whiteColor]

- (void)awakeFromNib
{
    // 文本框的光标颜色
    self.tintColor = kPlaceholderFocusColor;
    // 文字颜色
    self.textColor = kPlaceholderFocusColor;
    // 设置占位文字的颜色
    [self setValue:kPlaceholderDefaultColor forKeyPath:kPlaceholderColorKey];
    [self resignFirstResponder];
}

/**
 *  文本框聚焦时调用(成为第一响应者)（弹出当前文本框对应的键盘时调用）
 */
- (BOOL)becomeFirstResponder
{
    [self setValue:kPlaceholderFocusColor forKeyPath:kPlaceholderColorKey];
    return [super becomeFirstResponder];
}

/**
 *  文本框失去焦点时调用(成为第一响应者)（弹出当前文本框对应的键盘时调用）
 */
- (BOOL)resignFirstResponder
{
    [self setValue:kPlaceholderDefaultColor forKeyPath:kPlaceholderColorKey];
    return [super resignFirstResponder];
}

@end

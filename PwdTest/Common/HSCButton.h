//
//  HSCButton.h
//  AAAA
//
//  Created by zhangmh on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
/*

 */
#import <UIKit/UIKit.h>

@interface HSCButton : UIButton
{
    CGPoint beginPoint;
}

@property (nonatomic) BOOL dragEnable;
@property (assign,nonatomic) CGFloat margin;
@end

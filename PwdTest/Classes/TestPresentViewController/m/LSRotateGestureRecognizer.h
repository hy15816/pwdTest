//
//  LSRotateGestureRecognizer.h
//  anxindian
//
//  Created by Lost_souls on 16/5/15.
//  Copyright © 2016年 anerfa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSRotateGestureRecognizerDelegate <NSObject>

- (void)LSTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@interface LSRotateGestureRecognizer : UIGestureRecognizer

/**
 *   转动的角度
 */
@property (nonatomic, assign) CGFloat degrees;

@property (nonatomic, assign) NSInteger selectedIndex;
/**
 *  用于手势结束判断是tap还是拖动
 */
@property (nonatomic, assign) BOOL moved;

@property (assign,nonatomic) id<LSRotateGestureRecognizerDelegate> rotateDelegate;

@end

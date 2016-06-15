//
//  LSRotateGestureRecognizer.m
//  anxindian
//
//  Created by Lost_souls on 16/5/15.
//  Copyright © 2016年 anerfa. All rights reserved.
//

#import "LSRotateGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "LSPendulumView.h"
#import "LSPendulum.h"

typedef NS_ENUM(NSInteger ,LSRotateType) {
    LSRotateTypeRightTopDefault = 0,
    LSRotateTypeRightTop ,
    LSRotateTypeLeftDown
};

@interface LSRotateGestureRecognizer ()

@property (assign,nonatomic) LSRotateType rotateType;

@end

@implementation LSRotateGestureRecognizer


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    self.moved = NO;
    self.rotateType = LSRotateTypeRightTopDefault;
    
    self.state = (touches.count == 1) ? UIGestureRecognizerStateBegan : UIGestureRecognizerStateFailed;
    
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.state = UIGestureRecognizerStateChanged;
    
    self.moved = YES;
    
    UITouch *touch = [touches anyObject];
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    
    CGPoint s_currentLocation = [touch locationInView:self.view.superview];
    CGPoint s_previousLocation = [touch previousLocationInView:self.view.superview];
    
    CGPoint currentLocation = [touch locationInView:self.view];
    CGPoint previousLocation = [touch previousLocationInView:self.view];
    
    CGFloat deviceW = [UIScreen mainScreen].bounds.size.width;

    BOOL b2 = currentLocation.x > 0 && currentLocation.y <center.y && currentLocation.y > center.y -24 ;
    
    // 向右上滑动
    if (s_currentLocation.x >= s_previousLocation.x && s_currentLocation.y < s_previousLocation.y) {
        self.rotateType = LSRotateTypeRightTop;
    }
    // 左下滑动
    if (s_currentLocation.x >= deviceW-24-20 && s_currentLocation.y > s_previousLocation.y) {
        self.rotateType = LSRotateTypeLeftDown;
        
    }
    
    switch (self.rotateType) {
        case LSRotateTypeRightTopDefault:
            //
            NSLog(@"-1-1-1-1-1--1");
            self.degrees = 0; //atan2((currentLocation.y - center.y), (currentLocation.x - center.x)) - atan2((previousLocation.y - center.y), (previousLocation.x - center.x)); //
            self.state = UIGestureRecognizerStateBegan;
            
            if (self.rotateDelegate && [self.rotateDelegate respondsToSelector:@selector(LSTouchesMoved:withEvent:)]) {
                [self.rotateDelegate LSTouchesMoved:touches withEvent:event];
            }
            return;
            break;
        case LSRotateTypeRightTop:
            //
        {
            if (b2) {
                self.degrees = atan2((currentLocation.y - center.y), (currentLocation.x - center.x)) - atan2((previousLocation.y - center.y), (previousLocation.x - center.x));
                
            }else {
                //
                self.degrees = 0;//atan2((currentLocation.y - center.y), (currentLocation.x - center.x)) - atan2((previousLocation.y - center.y), (previousLocation.x - center.x)); //
                self.state = UIGestureRecognizerStateBegan;
                
            }
        }
            break;
        case LSRotateTypeLeftDown:
            //
        {
            self.degrees = atan2((currentLocation.y - center.y), (currentLocation.x - center.x)) - atan2((previousLocation.y - center.y), (previousLocation.x - center.x));
        }
            break;
            
        default:
            
            break;
    }
    
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.state == UIGestureRecognizerStateChanged) {
        LSPendulumView *pendulumView = (LSPendulumView *)self.view;
        
        for (LSPendulum *itemView in self.view.subviews) {
            CGPoint itemViewCenterPoint = CGPointMake(CGRectGetMidX(itemView.bounds), CGRectGetMidY(itemView.bounds));
            
            CGPoint itemCenterPointInWindow = [itemView convertPoint:itemViewCenterPoint toView:nil];
            CGRect basePendulumItemRectInWindow = [pendulumView.pendulum.superview convertRect:pendulumView.pendulum.frame toView:nil];
            
            if (CGRectContainsPoint(basePendulumItemRectInWindow, itemCenterPointInWindow)) {
                CGPoint itemCenterPointInBasePendulunItem = [itemView convertPoint:itemViewCenterPoint toView:pendulumView.pendulum];
                
                if ([self point:itemCenterPointInBasePendulunItem at:itemView]) {
                    break;
                }
            }
        }
    }
    else if(self.state == UIGestureRecognizerStateBegan) {
        for (LSPendulum *itemView in self.view.subviews) {
            CGPoint touchPoint = [self locationInView:itemView];
            
            if ([self point:touchPoint at:itemView]) {
                break;
            }
        }
    }
    
    self.state = UIGestureRecognizerStateEnded;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    self.state = UIGestureRecognizerStateCancelled;
}

-(BOOL)point:(CGPoint)point at:(LSPendulum *)itemView
{
    //    NSLog(@"self.degrees:%f",self.degrees);
    //    NSLog(@"self.selectedIndex:%d",self.seletedIndex);
    
//    if (CGPathContainsPoint(itemView.bezierPath.CGPath, NULL, point, NO)) {
        self.degrees = kDEGREES_TO_RADIANS(180) + atan2(self.view.transform.a, self.view.transform.b) + atan2(itemView.transform.a, itemView.transform.b);
        
        self.selectedIndex = itemView.tag;
        
        return YES;
//    }
    
    return NO;
}


@end

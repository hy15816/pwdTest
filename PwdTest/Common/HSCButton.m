//
//  HSCButton.m
//  AAAA
//
//  Created by zhangmh on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HSCButton.h"

@implementation HSCButton

@synthesize dragEnable;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!dragEnable) {
        return;
    }
    UITouch *touch = [touches anyObject];
    
    beginPoint = [touch locationInView:self];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!dragEnable) {
        return;
    }
    UITouch *touch = [touches anyObject];
    
    CGPoint nowPoint = [touch locationInView:self];
    
    float offsetX = nowPoint.x - beginPoint.x;
    float offsetY = nowPoint.y - beginPoint.y;
    
    self.center = CGPointMake(self.center.x + offsetX, self.center.y + offsetY);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self chagedFrame];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self chagedFrame];
}

- (void)chagedFrame {
    
    [UIView animateWithDuration:.35 animations:^{
        
        CGFloat x = self.frame.origin.x;
        CGFloat y = self.frame.origin.y;
        if (x < 0) {
            x = _margin;
        }
        
        if (x > [UIScreen mainScreen].bounds.size.width - self.frame.size.width) {
            x = [UIScreen mainScreen].bounds.size.width - self.frame.size.width-_margin;
        }
        
        if (y<0) {
            y = _margin;
        }
        
        if (y > [UIScreen mainScreen].bounds.size.height - self.frame.size.height) {
            y = [UIScreen mainScreen].bounds.size.height - self.frame.size.height-_margin;
        }
        
        self.frame = CGRectMake(x, y, self.frame.size.width, self.frame.size.height);
    }];
}

- (void)setMargin:(CGFloat)margin{
    
    _margin = margin;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

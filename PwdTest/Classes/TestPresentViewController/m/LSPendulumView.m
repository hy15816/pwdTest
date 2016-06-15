//
//  LSPendulumView.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/15.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "LSPendulumView.h"
#import "LSPendulum.h"
#import "LSRotateGestureRecognizer.h"

@interface LSPendulumView ()


@end

@implementation LSPendulumView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame ];
    if (self) {
        //
        [self add];
    }
    return self;
}

- (void)add{
    
    [self addSubview:self.pendulum];
    LSRotateGestureRecognizer *rotateGR = [[LSRotateGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotateGesture:)];
    [self addGestureRecognizer:rotateGR];

    
    
}


- (void)handleRotateGesture:(LSRotateGestureRecognizer *)rotateGR
{
    if (rotateGR.state == UIGestureRecognizerStateChanged) {//rotate
        self.pendulum.transform = CGAffineTransformRotate(self.transform, rotateGR.degrees);
    }
    else if(rotateGR.state == UIGestureRecognizerStateEnded && rotateGR.moved ) {// 拖动结束
        
        [UIView animateWithDuration:0.3f animations:^{
            self.pendulum.transform = CGAffineTransformRotate(self.transform, rotateGR.degrees);
        } completion:^(BOOL finished) {
            
//            if ([self.delegate respondsToSelector:@selector(wheelView:didSelectItemAtIndex:)]) {
//                [self.delegate wheelView:self didSelectItemAtIndex:rotateGR.seletedIndex];
//            }
        }];
        
    }else if (rotateGR.state == UIGestureRecognizerStateEnded && !rotateGR.moved){ // 单击结束
        //        NSLog(@"rotateGR.seletedIndex:%d",rotateGR.seletedIndex);
        CGAffineTransform _transform = CGAffineTransformRotate(self.transform, rotateGR.degrees);
        if (rotateGR.selectedIndex != 3) {
            _transform = CGAffineTransformIdentity;
        }
        
        [UIView animateWithDuration:0.3f animations:^{
            self.pendulum.transform = _transform;
        } completion:^(BOOL finished) {
            
//            if ([self.delegate respondsToSelector:@selector(wheelView:didSelectItemAtIndex:)]) {
//                [self.delegate wheelView:self didSelectItemAtIndex:rotateGR.seletedIndex];
//            }
        }];
    }
}



- (LSPendulum *)pendulum {
    
    if (!_pendulum) {
        _pendulum = [[LSPendulum alloc] initWithFrame:CGRectMake(0, self.frame.size.height-30, self.frame.size.width, 30)];
        _pendulum.backgroundColor = [UIColor blueColor];
    }
    
    return _pendulum;
}

@end

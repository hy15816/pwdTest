//
//  LSPresentAnimatedTransitioning.h
//  PwdTest
//
//  Created by Lost_souls on 16/5/11.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,LSPresentTransitionType) {
    
    LSPresentTransitionTypePresent = 0,
    LSPresentTransitionTypeDismiss
};

@interface LSPresentAnimatedTransitioning : NSObject<UIViewControllerAnimatedTransitioning>


+ (instancetype)transitionWithTransitionType:(LSPresentTransitionType)type;
- (instancetype)initWithTransitionType:(LSPresentTransitionType)type;

@end



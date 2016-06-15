//
//  TargetViewController.h
//  PwdTest
//
//  Created by Lost_souls on 16/5/11.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LSPresentDelegate <NSObject>

- (void)presentedOneControllerPressedDissmiss;
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent;

@end

@interface TargetViewController : UIViewController

@property (assign,nonatomic) id< LSPresentDelegate > delegate;

@end




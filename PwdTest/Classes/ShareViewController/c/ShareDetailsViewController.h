//
//  ShareDetailsViewController.h
//  PwdTest
//
//  Created by Lost_souls on 16/5/2.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "BaseViewController.h"

@protocol ShareDetailsViewControllerDelegate;

@interface ShareDetailsViewController : BaseViewController

@property (strong,nonatomic) void (^timeout)(UIColor *color);
@property (assign,nonatomic) id <ShareDetailsViewControllerDelegate> delegate;

@end

@protocol ShareDetailsViewControllerDelegate <NSObject>

- (UIColor * )parentViewColor;

@end

//
//  BaseViewController.h
//  PwdTest
//
//  Created by Lost_souls on 16/4/29.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BmobIMSDK/BmobIMSDK.h>
#import "BmobSDK/Bmob.h"

typedef NS_ENUM(NSInteger,BaseAlertMsgType) {
    
    BaseAlertMsgTypeUserNameErr = 0,
    BaseAlertMsgTypeUserPwdErr,
    BaseAlertMsgTypeVerifyErr,
    BaseAlertMsgTypeWWANErr,
    BaseAlertMsgTypeSucLogin
    
};


@interface BaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>



- (void)addRightItemWithTitle:(NSString *)title block:(UIViewController* (^)(UIBarButtonItem *item))block;
- (void)addRightItemWithSystem:(UIBarButtonSystemItem)systemItem block:(UIViewController* (^)(UIBarButtonItem *item))block;
- (void)printLog;
- (void)printLog:(NSString *)log;
- (void)showMsgWith:(BaseAlertMsgType)type;

@end

//
//  LoginViewController.h
//  PwdTest
//
//  Created by Lost_souls on 16/5/3.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController

@property (strong,nonatomic) void (^LoginSuccessBlock)();
@property (strong,nonatomic) void (^LoginViewCloseBlock)();
@end

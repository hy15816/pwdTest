//
//  RegisterViewController.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/4.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "RegisterViewController.h"


@interface RegisterViewController ()

@property (strong, nonatomic) IBOutlet UITextField *userNameField;
@property (strong, nonatomic) IBOutlet UITextField *pwdField;
@property (strong, nonatomic) IBOutlet UITextField *verifyPwdField;
- (IBAction)registerAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation RegisterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)registerAction:(UIButton *)sender {
    
    if (self.userNameField.text.length < 6) {
        [self showMsgWith:BaseAlertMsgTypeUserNameErr];
        return;
    }
    
    if (self.pwdField.text.length < 6) {
        [self showMsgWith:BaseAlertMsgTypeUserPwdErr];
        return;
    }
    
    if (![self.pwdField.text isEqualToString:self.verifyPwdField.text]) {
        [self showMsgWith:BaseAlertMsgTypeVerifyErr];
        return;
    }
    
    BmobUser *user = [[BmobUser alloc] init];
    user.username = self.userNameField.text;
    user.password = self.pwdField.text;
    
    // 注册成功已经登录了，即本地有缓存用户
    [user signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            //
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameLogin object:user.objectId];
            [Common CommonSaveMM:self.pwdField.text];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self printLog:error.userInfo[kError]];
        }
    } ];
    
}
@end

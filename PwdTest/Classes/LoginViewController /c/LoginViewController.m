//
//  LoginViewController.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/3.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "LoginViewController.h"
#import "LSLoginTextField.h"

@interface LoginViewController ()

- (IBAction)closeAction:(UIButton *)sender;
- (IBAction)signInAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *iconImageView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconImageViewWidth;
@property (strong, nonatomic) IBOutlet LSLoginTextField *userField;
@property (strong, nonatomic) IBOutlet LSLoginTextField *userPwdFieldLogin;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginButtonAction:(UIButton *)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(BOOL)prefersStatusBarHidden {
//    
//    return YES;
//}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
//    [super preferredStatusBarStyle];
    return UIStatusBarStyleLightContent;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 *  关闭页面
 *
 *  @param sender <#sender description#>
 */
- (IBAction)closeAction:(UIButton *)sender {
    
    if (self.LoginViewCloseBlock) {
        self.LoginViewCloseBlock();
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
/**
 *  注册
 *
 *  @param sender <#sender description#>
 */
- (IBAction)signInAction:(UIButton *)sender {
    
    [self.navigationController pushViewController:kStoryboardLogin(@"RegisterViewController") animated:YES];
    
    
    
//    [self.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
    
    
    
}
/**
 *  登录
 *
 *  @param sender <#sender description#>
 */
- (IBAction)loginButtonAction:(UIButton *)sender {
    
    if (self.userField.text.length == 0) {
        [self showMsgWith:BaseAlertMsgTypeUserNameErr];
        return;
    }
    if (self.userPwdFieldLogin.text.length == 0) {
        [self showMsgWith:BaseAlertMsgTypeUserPwdErr];
        return;
    }
    
    if ([Common defaultCommon].networkStatus == NotReachable) {
        [self showMsgWith:BaseAlertMsgTypeWWANErr];
        return;
    }
    
    [BmobUser loginInbackgroundWithAccount:self.userField.text andPassword:self.userPwdFieldLogin.text block:^(BmobUser *user, NSError *error) {
        //
        if (user) {
            
            [self showMsgWith:BaseAlertMsgTypeSucLogin];
            [self printLog:[NSString stringWithFormat:@"%@-%@-%@",user.username,user.password,user.objectId]];
            
//            BmobUser *user = [BmobUser getCurrentUser];
//            
//            [user setObject:@"kaka" forKey:@"nickname"];
//            
//            [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//                
//                if (isSuccessful){
//                    NSLog(@"修改昵称 successfully");
//                    
//                    [self.navigationController popViewControllerAnimated:YES];
//                } else {
//                    NSLog(@"修改昵称 %@",error);
//                }
//            }];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameLogin object:user.objectId];
            if (self.LoginSuccessBlock) {
                self.LoginSuccessBlock();
            }
            
            // 保存密码，，，
            [Common CommonSaveMM:self.userPwdFieldLogin.text];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }else {
            [self printLog:error.userInfo[kError]];
        }
    }];
    
    
    
    
    
    
    
    
    
}
@end

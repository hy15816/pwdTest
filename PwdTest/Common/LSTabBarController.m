//
//  LSTabBarController.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/3.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "LSTabBarController.h"
#import "ContactsTableVC.h"
#import "LoginViewController.h"
#import "MoreViewController.h"
#import <BmobSDK/Bmob.h>
#import "TestRootViewController.h"
#import "HSCButton.h"

@interface LSTabBarController ()

{
    BOOL _didLogin;
    
}
@end

@implementation LSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentToLoginVC) name:kNotificationNamePresentLoginVC object:nil];
    
    [self setup];
    
    
    HSCButton *tt = [[HSCButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    tt.backgroundColor = [UIColor greenColor];
    tt.dragEnable = YES;
    tt.layer.cornerRadius = 25;
    tt.layer.borderWidth =2.f;
    tt.layer.borderColor = [UIColor whiteColor].CGColor;
    tt.layer.masksToBounds = YES;
    
    [self.view addSubview:tt];
    [self.view bringSubviewToFront:tt];

    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![BmobUser getCurrentUser]) {
        if (!_didLogin) {
            [self presentToLoginVC];
        }
    }
}

- (void)setup {
    
    [self setupChildNavigationControllerWithClass:[LSNavigationController class] tabBarImageName:@"TabBar_HomeBar" rootViewControllerClass:[ContactsTableVC class] rootViewControllerTitle:@"Contacts"];
    
    [self setupChildNavigationControllerWithClass:[LSNavigationController class] tabBarImageName:@"TabBar_HomeBar" rootViewControllerClass:[MoreViewController class] rootViewControllerTitle:@"More"];
    
    [self setupChildNavigationControllerWithClass:[LSNavigationController class] tabBarImageName:@"TabBar_HomeBar" rootViewControllerClass:[TestRootViewController class] rootViewControllerTitle:@"test"];
    
}

- (void)setupChildNavigationControllerWithClass:(Class)class tabBarImageName:(NSString *)name rootViewControllerClass:(Class)rootViewControllerClass rootViewControllerTitle:(NSString *)title
{
    UIViewController *rootVC = [[rootViewControllerClass alloc] init];
    rootVC.title = title;
    LSNavigationController *navVc = [[class  alloc] initWithRootViewController:rootVC];
    navVc.tabBarItem.image = [UIImage imageNamed:name];
    navVc.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_Sel", name]];
    [self addChildViewController:navVc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



    
-(void)presentToLoginVC{
    
    //    [self presentViewController:kStoryboardLogin(@"LoginViewController") animated:YES completion:nil];

    
    LoginViewController *login = kStoryboardLogin(@"LoginViewController");
    LSNavigationController *nav_login = [[LSNavigationController alloc] initWithRootViewController:login];
    login.LoginSuccessBlock = ^{
        _didLogin = YES;
    };
    login.LoginViewCloseBlock = ^{
        _didLogin = YES;
    };
    [self presentViewController:nav_login animated:YES completion:nil];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

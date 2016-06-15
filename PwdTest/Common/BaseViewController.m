//
//  BaseViewController.m
//  PwdTest
//
//  Created by Lost_souls on 16/4/29.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "BaseViewController.h"

typedef UIViewController*(^RightItemActionBlock)(UIBarButtonItem *item);

@interface BaseViewController ()

@property (strong,nonatomic) RightItemActionBlock rightItemActionBlock;
@property (strong,nonatomic) NSMutableString *bugString;

@end

@implementation BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *kCellID     = @"kCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return nil;

}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark - Public Methods

- (void)addRightItemWithTitle:(NSString *)title block:(UIViewController* (^)(UIBarButtonItem *item))block{
    if (block) {
        self.rightItemActionBlock = block;
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    
}

- (void)addRightItemWithSystem:(UIBarButtonSystemItem)systemItem block:(UIViewController* (^)(UIBarButtonItem *item))block;
{
    if (block) {
        self.rightItemActionBlock = block;
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:systemItem target:self action:@selector(rightItemAction:)];
}

- (void)rightItemAction:(UIBarButtonItem *)item {
    
    self.rightItemActionBlock(item);
    
    // push 跳转
    UIViewController *dvc = (UIViewController *)self.rightItemActionBlock(item);
    [self.navigationController pushViewController:dvc animated:YES];
    
}

- (void)showMsgWith:(BaseAlertMsgType)type {
    NSString *msg;
    switch (type) {
        case BaseAlertMsgTypeUserNameErr:
            msg = @"请输入正确的用户名";
            break;
        case BaseAlertMsgTypeUserPwdErr:
            msg = @"请输入正确的密码";
            break;
        case BaseAlertMsgTypeVerifyErr:
            msg = @"两次输入密码必须一致";
            break;
        case BaseAlertMsgTypeSucLogin:
            msg = @"登录成功";
            break;
        case BaseAlertMsgTypeWWANErr:
            msg = @"网络异常，请检查网络";
            break;
        default:
            break;
    }
    
    if (msg.length) {
        [self printLog:msg];
    }
}

- (void)printLog:(NSString *)log {
    
    [self.bugString appendFormat:@"%@ \n",log];
    NSLog(@"PWDLog:%@",log);
}
- (void)printLog {
    
    NSLog(@"PWDLog:%@",self.bugString);
}
- (NSMutableString *)bugString {
    
    if (!_bugString) {
        _bugString = [[NSMutableString alloc] init];
    }
    return _bugString;
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

//
//  MoreViewController.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/3.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "MoreViewController.h"
#import "LSMessageService.h"
#import "LSUserService.h"

@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView *msgTableView;
@property (strong,nonatomic) NSMutableArray *systemMsgList;
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.msgTableView];
    
    [self addRightItemWithTitle:@"设置" block:^UIViewController *(UIBarButtonItem *item) {
        return kStoryboardMore(@"SettingsTableViewController");
    }];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadSystemMsgRecord];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadSystemMsgRecord {
    
    [LSMessageService inviteMessages:[NSDate date] completion:^(NSArray *array, NSError *error) {
        if (error) {
            //[self showInfomation:error.localizedDescription];
            MMLog(@"error:%@",error.localizedDescription)
        }else{
            if (array && array.count > 0) {
                [self.systemMsgList setArray:array];
                [self.msgTableView reloadData];
            }
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.systemMsgList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"addfCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    SysMessage *msg = self.systemMsgList[indexPath.row];
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"%@请求添加您为好友",msg.fromUser.username];;//self.userInfo.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SysMessage *msg = self.systemMsgList[indexPath.row];
    
    
    [LSUserService agreeFriendWithObejctId:msg.objectId userId:msg.fromUser.objectId completion:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [LSUserService addFriendWithUser:msg.toUser friend:msg.fromUser completion:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    //[self showInfomation:@"已同意添加好友"];
                    [self printLog:@"已同意添加好友"];
                    //[button setTitle:@"已同意" forState:UIControlStateNormal];
                    //button.enabled = NO;
                }else{
                    //[self showInfomation:@"请稍后再试"];
                    [self printLog:@"请稍后再试"];
                }
            }];
        }else{
            //[self showInfomation:@"请稍后再试"];
            [self printLog:@"请稍后再试"];
        }
    }];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UITableView *)msgTableView {
    if (!_msgTableView) {
        
        _msgTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _msgTableView.delegate = self;
        _msgTableView.dataSource = self;
        
    }
    
    return _msgTableView;
}

- (NSMutableArray *)systemMsgList {
    if (!_systemMsgList) {
        _systemMsgList = [[NSMutableArray alloc] init];
    }
    
    return _systemMsgList;
}

@end

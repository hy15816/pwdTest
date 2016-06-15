//
//  ContactsTableVC.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/3.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "ContactsTableVC.h"
#import "ContactsCell.h"
#import "LSUserService.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "ChatTableViewController.h"
#import "FerindAddTableViewController.h"

@interface ContactsTableVC ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *_title;
    NSString *_subTitle;
    NSString *_imageName;
    NSString *_btnTitle;
    
}
@property (strong, nonatomic) UITableView *contactsTableView;
@property (strong, nonatomic) NSMutableArray *usersList;

//- (IBAction)click:(id)sender;

@end

@implementation ContactsTableVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [self setAlertTitle:@"您还没有联系人" sub:@"您还没有联系人哦，赶快去添加吧!" image:@"defaultUserIcon" btn:@"点击添加"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _title = @"";
    _subTitle = @"";
    _imageName = @"defaultUserIcon";
    _btnTitle = @"";
    
    [self addRightItemWithSystem:UIBarButtonSystemItemAdd block:^UIViewController *(UIBarButtonItem *item) {
        //
        return [[FerindAddTableViewController alloc] init];
    }];
    [self.view addSubview:self.contactsTableView];
    [self initDZNEmpty];
    
    
    [self setAlertTitle:@"您还没有联系人" sub:@"您还没有联系人哦，赶快去添加吧!" image:@"defaultUserIcon" btn:@"点击添加"];
}


- (void)setAlertTitle:(NSString *)title sub:(NSString *)subtitle image:(NSString *)image btn:(NSString *)btnTitle {
    
    _title = title;
    _subTitle = subtitle;
    _imageName = image;
    _btnTitle = btnTitle;
    
    self.contactsTableView.emptyDataSetSource = self;
    self.contactsTableView.emptyDataSetDelegate = self;
    [self.contactsTableView reloadEmptyDataSet];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self loadUserFriends];
}

/**
 *  调用云代码
 */
- (void)reqCloudCoude {
    
    [BmobCloud callFunctionInBackground:@"createPwdAppUserPassword" withParameters:@{@"pwd":@"123456"} block:^(id object, NSError *error) {
        if (error) {
            NSLog(@"error %@",[error description]);
        }
        NSLog(@"object      %@",object);
    }] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadUserFriends{
    [LSUserService friendsWithCompletion:^(NSArray *array, NSError *error) {
        if (error) {
//            [self printl :error.localizedDescription];
            MMLog(@"err :%@",error.localizedDescription);
            [self setAlertTitle:@"您还没有联系人" sub:@"您还没有联系人哦，赶快去添加吧!" image:@"defaultUserIcon" btn:@"点击添加"];
        }else{
            BmobUser *loginUser = [BmobUser getCurrentUser];
            NSMutableArray *result  = [NSMutableArray array];
            for (BmobObject *obj in array) {
                
                BmobUser *friend = nil;
                if ([[(BmobUser *)[obj objectForKey:@"user"] objectId] isEqualToString:loginUser.objectId]) {
                    friend = [obj objectForKey:@"friendUser"];
                }else{
                    friend = [obj objectForKey:@"user"];
                }
                BmobIMUserInfo *info = [BmobIMUserInfo userInfoWithBmobUser:friend];
                
                [result addObject:info];
            }
            if (result && result.count > 0) {
                [self.usersList setArray:result];
                [self.contactsTableView reloadData];
                
            }
            
        }
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.usersList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactsCell *cell = [ContactsCell cellWithTable:tableView];
    
    BmobIMUserInfo *info = self.usersList[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"我的好友:%@",info.name];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BmobIMUserInfo *info = self.usersList[indexPath.row];
    ChatTableViewController *chat = kStoryboardContacts(@"ChatTableViewController");
    BmobIMConversation *conversation = [BmobIMConversation conversationWithId:info.userId conversationType:BmobIMConversationTypeSingle];
    conversation.conversationTitle =  info.name;
    chat.conversation = conversation;
    [self.navigationController pushViewController:chat animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - DZNEmpty init

- (void)initDZNEmpty {
    
    self.contactsTableView.emptyDataSetSource = nil;
    self.contactsTableView.emptyDataSetDelegate = nil;
    self.contactsTableView.tableFooterView = [UIView new];
}
#pragma mark - DZNEmptyDataSetSource
/**
 *  返回自定义标题文字
 */
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = _title;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f], NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

/**
 *  返回详情文字
 */
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView; {
    
    NSString *text = _subTitle;
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f], NSForegroundColorAttributeName: [UIColor lightGrayColor], NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];

}
/**
 *  实现可以点击的按钮，按钮带文字
 */
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
    return [[NSAttributedString alloc] initWithString:_btnTitle attributes:attributes];
    
}

/**
 *  返回可以点击的按钮 上面带图片
 */
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    if (state == UIControlStateSelected) {
        [UIImage imageNamed:@"loginBtnBgClick"];
    }
    return [UIImage imageNamed:@"loginBtnBg"];
}

/**
 *  返回自定义图片
 */
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:_imageName];// @"no_wlan_icon"
}
/**
 *  返回空白区域的颜色
 */
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    
    return [UIColor groupTableViewBackgroundColor];
}
/**
 *  返回一个自定义视图
 */
//- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
//    
//    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]; [activityView startAnimating];
//    
//    return activityView;
//
//}

/**
 *  调整垂直对齐的内容视图(即:有用tableHeaderView时可见):
 */
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -self.contactsTableView.frame.size.height/2.0f;
}

/**
 *  返回间距
 */
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    
    return 0;//-self.contactsTableView.tableHeaderView.frame.size.height/2.0f;
}

//- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView {
//    
//    return nil;
//}

#pragma mark - DZNEmptyDataSetDelegate
// 显示时是否要淡入效果  （df = yes）
- (BOOL)emptyDataSetShouldFadeIn:(UIScrollView *)scrollView{
    
    return YES;
}
// 当tableView有数据时，是否显示 viw，（df = NO）
- (BOOL)emptyDataSetShouldBeForcedToDisplay:(UIScrollView *)scrollView {
    return NO;
}
// 要求知道空的状态应该渲染和显示 (Default is YES) :
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{ return YES;}

// 是否允许点击 (默认是 YES) :
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView{ return YES;}

// 是否允许滚动 (默认是 NO) :
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{ return NO;}

// 是否允许图片视图动画效果 @see imageAnimationForEmptyDataSet:
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return YES;
}
// 空白区域点击响应:
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView{
    // Do something
}
    
// 点击button 响应
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView{
    // Do something
    
    if (!self.usersList.count) {
        BmobIMUserInfo *info = [BmobIMUserInfo userInfoWithUserId:@"0e27t3bd69" username:@"testname" avatar:@"icon"];
        [self.usersList addObject:info];
    }
    
    
    // 刷新当前表格
    [self.contactsTableView reloadData];
}

#pragma mark -
//- (IBAction)click:(id)sender {
//    
//    [self.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
//    
//}

- (NSMutableArray *)usersList {
    if (!_usersList) {
        _usersList = [[NSMutableArray alloc] init];
    }
    
    return _usersList;
}

- (UITableView *)contactsTableView {
    
    if (!_contactsTableView) {
        
        _contactsTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _contactsTableView.delegate = self;
        _contactsTableView.dataSource = self;
        
    }
    
    return _contactsTableView;
}
@end


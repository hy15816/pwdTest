//
//  ChatTableViewController.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/5.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "ChatTableViewController.h"
#import "ChatCell.h"

@interface ChatTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *chatTableView;
@property (strong, nonatomic) NSMutableArray     *messagesArray;
@property (assign, nonatomic) NSUInteger         page;
@property (strong, nonatomic) IBOutlet UITextField *inputMsgField;
- (IBAction)sendAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *BaseViewTopContrain;
@property (strong, nonatomic) BmobIMUserInfo *userInfo;
@property (strong, nonatomic) BmobIM             *bmobIM;


@end

@implementation ChatTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.title = self.conversation.conversationTitle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.view addSubview:self.chatTableView];
    
    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessage:) name:kNewMessagesNotifacation object:nil];
    self.page = 0;
    
    [self loadMessageRecords];
    
    self.userInfo = [self.bmobIM userInfoWithUserId:self.conversation.conversationId];
    
    //更新缓存
    [self.conversation updateLocalCache];

    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    
    double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardF = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat bottomY = kDEVICE_H-keyboardF.size.height-50;
    
    
    
//    bottomY = bottomY>=50?bottomY:50;
    
    if (bottomY<=50) {
        bottomY = 50;
    }
    NSLog(@"bottomY:%f",bottomY);
//    [UIView animateWithDuration:duration delay:0.15 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        //
//        self.bottomView.frame = CGRectMake(0, bottomY, kDEVICE_W, kDEVICE_H-keyboardF.origin.y);
//    } completion:nil];
    
    [UIView animateWithDuration:duration animations:^{
        //
        self.BaseViewTopContrain.constant = - keyboardF.origin.y + kDEVICE_H + 50;
        self.bottomViewHeightConstraint.constant = kDEVICE_H-keyboardF.origin.y + 50;
        
//        NSLog(@"bottomY:%f",bottomY);
//        self.bottomView.frame = CGRectMake(0, bottomY, kDEVICE_W, kDEVICE_H-keyboardF.origin.y);
        
//        if (keyboardF.origin.y > self.view.height) { // 键盘的Y值已经远远超过了控制器view的高度
//            self.toolbar.y = self.view.height - self.toolbar.height;//这里的self.toolbar就是我的输入框。
//            
//        } else {
//            self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
//        }
        
    }];
    
}


-(void)receiveMessage:(NSNotification *)noti{
    BmobIMMessage *message = (BmobIMMessage *)noti.object;
    
    NSLog(@"new msg.contont :%@",message.content);
    
    if (message.extra[KEY_IS_TRANSIENT] && [message.extra[KEY_IS_TRANSIENT] boolValue]) {
        return;
    }
    if ([message.fromId isEqualToString:self.conversation.conversationId]) {
        
        BmobIMMessage *tmpMessage = nil;
        
        tmpMessage =  message;
        
        [self.messagesArray addObject:tmpMessage];
        [self scrollToBottom];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadMessageRecords{
    
    
    NSArray *array = [self.conversation queryMessagesWithMessage:nil limit:10];
    
    
    if (array && array.count > 0) {
        NSArray *result = [array sortedArrayUsingComparator:^NSComparisonResult(BmobIMMessage *obj1, BmobIMMessage *obj2) {
            if (obj1.updatedTime > obj2.updatedTime) {
                return NSOrderedDescending;
            }else if(obj1.updatedTime <  obj2.updatedTime) {
                return NSOrderedAscending;
            }else{
                return NSOrderedSame;
            }
            
        }];
        [self.messagesArray setArray:result];
        [self.chatTableView reloadData];
        
        [self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messagesArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.messagesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatCell *cell = [ChatCell cellWith:tableView];
    BmobIMMessage *msg = self.messagesArray[indexPath.row];
    cell.textLabel.text = msg.content;
    
    // Configure the cell...
//    static NSString *kTextCellID     = @"ChatCellID";
//
//    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:kTextCellID];
//    if(cell == nil) {
//        cell = [[ChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTextCellID];
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [self configCell:cell message:msg];
    return cell;

}
-(void)configCell:(ChatCell *)cell message:(BmobIMMessage *)msg{
    if ([[BmobUser getCurrentUser].objectId isEqualToString:msg.fromId]) {
        [cell setMsg:msg userInfo:nil] ;
    }else{
        [cell setMsg:msg userInfo:self.userInfo] ;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 85;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSMutableArray *)messagesArray {
    if (!_messagesArray) {
        _messagesArray = [[NSMutableArray alloc] init];
    }
    
    return _messagesArray;
}

//- (UITableView *)chatTableView {
//    
//    if (!_chatTableView) {

//        _chatTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kDEVICE_W, kDEVICE_H/2-50) style:UITableViewStylePlain];
        
        
//    }
//    
//    return _chatTableView;
//}

- (IBAction)sendAction:(UIButton *)sender {
    
    if (self.inputMsgField.text.length == 0) {
//        [self showInfomation:@"请输入内容"];
        MMLog(@"请输入内容")
    }else{
        
        BmobIMTextMessage *message = [BmobIMTextMessage messageWithText:self.inputMsgField.text attributes:nil];
        message.conversationType =  BmobIMConversationTypeSingle;
        message.createdTime = (uint64_t)([[NSDate date] timeIntervalSince1970] * 1000);
        message.updatedTime = message.createdTime;
        [self.messagesArray addObject:message];
        [self scrollToBottom];
        self.inputMsgField.text = nil;
        
        __weak typeof(self)weakSelf = self;
        [self.conversation sendMessage:message completion:^(BOOL isSuccessful, NSError *error) {
            
            if (error) {
                MMLog(@"error:%@",error);
            }
            
            if (isSuccessful) {
                [weakSelf reloadLastRow];
            }
            
            
            
        }];
        
    }
    
}

-(void)reloadLastRow{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messagesArray.count-1 inSection:0];
    [self.chatTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}

-(void)scrollToBottom{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messagesArray.count-1 inSection:0];
    [self.chatTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}
@end

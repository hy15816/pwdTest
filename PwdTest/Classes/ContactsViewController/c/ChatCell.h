//
//  ChatCell.h
//  PwdTest
//
//  Created by Lost_souls on 16/5/5.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSTextView.h"

@interface ChatCell : UITableViewCell
@property (strong, nonatomic) IBOutlet LSTextView *textView;

+ (ChatCell *)cellWith:(UITableView *)tableView;

-(void)setMsg:(BmobIMMessage *)msg userInfo:(BmobIMUserInfo *)userInfo ;
@end

//
//  ChatCell.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/5.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "ChatCell.h"

@implementation ChatCell

+ (ChatCell *)cellWith:(UITableView *)tableView {
    
    static NSString *cellID = @"chatCellID";
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ChatCell" owner:self options:nil] lastObject];
    }
    
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMsg:(BmobIMMessage *)msg userInfo:(BmobIMUserInfo *)userInfo ;
{
    [self.textView setMessage:msg user: userInfo];
}

@end

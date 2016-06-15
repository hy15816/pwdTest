//
//  ContactsCell.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/3.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "ContactsCell.h"

@implementation ContactsCell

+ (ContactsCell *)cellWithTable:(UITableView *)tableView {
    static NSString *cellIDF =@"ContactsCellIDF";
    ContactsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDF];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ContactsCell" owner:self options:nil] lastObject];
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

@end

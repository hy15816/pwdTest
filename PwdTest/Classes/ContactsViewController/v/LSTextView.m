//
//  LSTextView.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/5.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "LSTextView.h"
#import "NSString+YYAdd.h"

@interface LSTextView ()

@property (assign,nonatomic) CGFloat contentLabelHeight;
@end

@implementation LSTextView

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 0;
        [self.chatContentView addSubview:_contentLabel];
        _contentLabel.preferredMaxLayoutWidth = kDEVICE_W - 70 - 70;
    }
    return _contentLabel;
}


-(void)setMessage:(BmobIMMessage *)msg user:(BmobIMUserInfo *)userInfo {
    [super setMessage:msg user:userInfo];
    
    self.contentLabel.text = msg.content;
    
//    self.contentLabelHeight = [msg.content heightForFont:self.contentLabel.font width:self.contentLabel.preferredMaxLayoutWidth];
//    MMLog(@"self.contentLabelHeight:%f",self.contentLabelHeight);
}

- (void)layoutViewsSelf {
    
    [super layoutViewsSelf];
    
    
    
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.chatBackgroundImageView.mas_centerY);
        make.left.equalTo(self.chatContentView.mas_left).with.offset(8);
        make.right.equalTo(self.chatContentView.mas_right).with.offset(-20);
    }];
    
    [self.chatContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.avatarBackgroundImageView.mas_left).with.offset(-8);
        make.top.equalTo(self.avatarBackgroundImageView);
        make.width.lessThanOrEqualTo(@(kScreenWidth - 70));
        make.height.equalTo(self.contentLabel.mas_height).with.offset(20);
        make.bottom.equalTo(self.mas_bottom).with.offset(-8).with.priorityMedium();
    }];
    [self.chatBackgroundImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.chatContentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    self.contentLabel.textColor = [UIColor whiteColor];
    
    
}

- (void)layoutViewsOther {
    [super layoutViewsOther];
    
    self.contentLabel.hidden = NO;
    
    [self.chatContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarBackgroundImageView.mas_right).with.offset(8);
        make.top.equalTo(self.avatarBackgroundImageView);
        make.width.lessThanOrEqualTo(@(kScreenWidth - 70));
        make.height.equalTo(self.contentLabel.mas_height).with.offset(20);
        make.bottom.equalTo(self.mas_bottom).with.offset(-8).with.priorityMedium();
    }];
    [self.chatBackgroundImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.chatContentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        //make.edges.equalTo(self.chatContentView).insets(UIEdgeInsetsMake(8, 24, 18, 24));
        make.centerY.equalTo(self.chatBackgroundImageView.mas_centerY);
        make.left.equalTo(self.chatContentView.mas_left).with.offset(20);
        make.right.equalTo(self.chatContentView.mas_right).with.offset(-8);
    }];
    self.contentLabel.textColor = kCOLOR(47, 39, 37, 1);//[UIColor colorWithR:47 g:39 b:37];
}

@end

//
//  LSChatView.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/5.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

static const float timeLabelH = 15.f;
static const float avatarBtnH = 44.f;

#import "LSChatView.h"
#import "UIButton+WebCache.h"
//#import "UIImageView+WebCache.h"

@implementation LSChatView

#pragma mark - public method

- (void)layoutViewsSelf {
    
    [self.avatarBackgroundImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
        make.top.equalTo(self.timeLabel.mas_bottom).with.offset(10);
    }];
    
    [self.avatarButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.avatarBackgroundImageView);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
    }];
    self.chatBackgroundImageView.image = [UIImage imageNamed:@"bg_chat_right_nor"];

}

#pragma mark - other layout


-(void)layoutViewsOther{
    
    [self.avatarBackgroundImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
        make.top.equalTo(self.timeLabel.mas_bottom).with.offset(10);
    }];
    
    [self.avatarButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.avatarBackgroundImageView);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
    }];
    
    self.chatBackgroundImageView.image = [UIImage imageNamed:@"bg_chat_left_nor"] ;

}


#pragma mark - set

- (void)setMessage:(BmobIMMessage *)msg user:(BmobIMUserInfo *)userInfo {
    
    self.msg = msg;
    
    self.avatarBackgroundImageView.image = [UIImage imageNamed:@"head_bg"];
    self.timeLabel.text = [[Common defaultCommon].dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.msg.updatedTime / 1000.0f] ];
    
    BmobUser *loginUser = [BmobUser getCurrentUser];
    if ([_msg.fromId isEqualToString:loginUser.objectId]) {
        [self layoutViewsSelf];
        [self.avatarButton sd_setBackgroundImageWithURL:[NSURL URLWithString:[loginUser objectForKey:@"avatar"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"head"]];
    }else{
        [self layoutViewsOther];
        [self.avatarButton sd_setBackgroundImageWithURL:[NSURL URLWithString:userInfo.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"head"]];
    }

    
}


- (void)setMsg:(BmobIMMessage *)msg {
    
    _msg = msg;
}

#pragma mark - get

- (UIImageView *)chatBackgroundImageView {
    
    if (!_chatBackgroundImageView) {
        _chatBackgroundImageView = [[UIImageView alloc] init];
        [self.chatContentView addSubview:_chatBackgroundImageView];
        
    }
    return _chatBackgroundImageView;
}

- (UIButton *)avatarButton {
    
    if (!_avatarButton) {
        _avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_avatarButton];
        [_avatarButton.layer setMasksToBounds:YES];
        [_avatarButton.layer setCornerRadius:_avatarButton.frame.size.height/2.f];
    }
    
    return _avatarButton;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.layer.cornerRadius = 3;
        _timeLabel.layer.masksToBounds = YES;
        _timeLabel.backgroundColor = kCOLOR(227, 228, 232, 1.0);
        _timeLabel.textColor = kCOLOR(136, 136, 136, 1.0);
        _timeLabel.textAlignment = NSTextAlignmentCenter;
//        CGFloat width = 140;
        //_timeLabel.frame = CGRectMake((kDEVICE_W - width)/2, 5, width, 15);
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@140);
            make.top.equalTo(self.mas_top).with.offset(8);
            make.height.equalTo(@19);
        }];
    }
    
    return _timeLabel;
}

- (UIView *)chatContentView {
    
    if (!_chatContentView) {
        _chatContentView = [[UIView alloc] init];
        [self addSubview:_chatContentView];
    }
    return _chatContentView;
}

- (UIImageView *)avatarBackgroundImageView {
    
    if (!_avatarBackgroundImageView) {
        _avatarBackgroundImageView = [[UIImageView alloc] init];
        [self addSubview:_avatarBackgroundImageView];
    }
    
    return _avatarBackgroundImageView;
}

@end

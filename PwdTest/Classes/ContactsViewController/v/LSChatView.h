//
//  LSChatView.h
//  PwdTest
//
//  Created by Lost_souls on 16/5/5.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface LSChatView : UIView

@property (strong, nonatomic) UIButton *avatarButton;

@property (strong, nonatomic) UILabel *timeLabel;

@property (strong, nonatomic) UIImageView *avatarBackgroundImageView;

@property (strong, nonatomic) UIImageView *chatBackgroundImageView;

@property (strong, nonatomic) UIView *chatContentView;

@property (strong, nonatomic) BmobIMMessage *msg;

-(void)setMessage:(BmobIMMessage *)msg user:(BmobIMUserInfo *)userInfo ;

-(void)layoutViewsSelf;

-(void)layoutViewsOther;

@end

//
//  BmobIMUserInfo+User.h
//  PwdTest
//
//  Created by Lost_souls on 16/5/3.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//


#import <BmobIMSDK/BmobIMSDK.h>
#import <BmobSDK/Bmob.h>

@interface BmobIMUserInfo (User)

+(instancetype)userInfoWithBmobUser:(BmobUser *)user;

@end

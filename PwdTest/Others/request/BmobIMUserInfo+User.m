//
//  BmobIMUserInfo+User.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/3.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "BmobIMUserInfo+User.h"
#import <BmobSDK/Bmob.h>


@implementation BmobIMUserInfo (User)

+(instancetype)userInfoWithBmobUser:(BmobUser *)user{
    BmobIMUserInfo *info  = [[BmobIMUserInfo alloc] init];
    info.userId = user.objectId;
    info.name = user.username;
    info.avatar = [user objectForKey:@"avatar"];
    return info;
}

@end

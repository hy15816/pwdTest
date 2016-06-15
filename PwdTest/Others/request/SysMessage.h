//
//  SysMessage.h
//  PwdTest
//
//  Created by Lost_souls on 16/5/3.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>

@interface SysMessage : BmobObject

@property (strong, nonatomic) BmobUser *fromUser;

@property (strong, nonatomic) BmobUser *toUser;

@property (strong, nonatomic) NSNumber *type;

@end

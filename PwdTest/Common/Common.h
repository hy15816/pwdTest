//
//  Common.h
//  PwdTest
//
//  Created by Lost_souls on 16/4/29.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#define KPWD_EXTERN     extern __attribute__((visibility ("default")))
#define kUIStoryboard(name)     [UIStoryboard storyboardWithName:name bundle:nil]
#define kStoryboardShare(vc)    [kUIStoryboard(@"ShareStoryboard") instantiateViewControllerWithIdentifier:vc]
#define kStoryboardMore(vc)    [kUIStoryboard(@"MoreStoryboard") instantiateViewControllerWithIdentifier:vc]
#define kStoryboardMain(vc)    [kUIStoryboard(@"Main") instantiateViewControllerWithIdentifier:vc]
#define kStoryboardContacts(vc)    [kUIStoryboard(@"ContactsStoryboard") instantiateViewControllerWithIdentifier:vc]
#define kStoryboardLogin(vc)    [kUIStoryboard(@"LoginStoryboard") instantiateViewControllerWithIdentifier:vc]

#define kCOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define kIS_IOS(v)      [[UIDevice currentDevice].systemVersion floatValue] >= v
#define kDEVICE_W       [UIScreen mainScreen].bounds.size.width
#define kDEVICE_H       [UIScreen mainScreen].bounds.size.height

#define kDEGREES_TO_RADIANS(d) ((d) * M_PI / 180)
#define kRADIANS_TO_DEGREES(d) ((d) * 180 / M_PI)

typedef NS_ENUM(int,SystemMessageContact){
    SystemMessageContactAdd = 0,
    SystemMessageContactAgree,
    SystemMessageContactRefuse
};

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kInviteMessageTable      @"InviteMessage"
#define kFriendTable             @"Friend"
#define kNewMessagesNotifacation @"NewMessagesNotifacation"
#define kNewMessageFromer        @"NewMessageFromer"

#define kError  @"error"
#define kCode   @"code"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LSUser.h"
#import "LSNotification.h"
#import "Reachability.h"


/**
 *  友盟appkey
 */
KPWD_EXTERN NSString *const kAPPKEY_UM;
/**
 *  bmob appkey
 */
KPWD_EXTERN NSString *const kAPPKEY_BMOB;
/**
 *  登录
 */
KPWD_EXTERN NSString *const kNotificationNameLogin;
/**
 *  登出
 */
KPWD_EXTERN NSString *const kNotificationNameLogout;
/**
 *  弹出登录VC
 */
KPWD_EXTERN NSString *const kNotificationNamePresentLoginVC;


@interface Common : NSObject

/**
 *  当前用户
 */
@property (strong,nonatomic) LSUser *user;

/**
 *  获取当前网络状态
 */
@property (assign,nonatomic,readonly) NetworkStatus networkStatus;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;


// ===========================

+ (Common *)defaultCommon;

/**
 *  缓存路径
 *
 *  @return 缓存路径
 */
+(NSString *)cachePath;


+(NSString *)audioCacheDirectory;

+ (void)CommonSaveMM:(NSString *)mmString;

@end

//
//  AppDelegate.m
//  PwdTest
//
//  Created by Lost_souls on 16/4/28.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "AppDelegate.h"

#import "UMsocial.h"    // um 分享
#import "MobClick.h"    // um 统计

#import "LSUserService.h"
#import "LSTabBarController.h"

// 在PwdTest-Prefix.h 设置了
//#import <BmobIMSDK/BmobIMSDK.h>     //bmob im
//#import <BmobSDK/Bmob.h>            //bmob base


@interface AppDelegate ()<BmobIMDelegate>

// ========= bmob ============
@property (strong, nonatomic) BmobIM *sharedIM;
@property (strong, nonatomic) NSString *userid;
@property (strong, nonatomic) NSString *token;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 初始化app入口
    [self initTabBarVC];
    // 注册通知
    [self registerNotification:application];
    // 友盟分享
    [UMSocialData setAppKey:kAPPKEY_UM];
    // 友盟统计- 无IDFA
    [MobClick startWithAppkey:kAPPKEY_UM reportPolicy:BATCH channelId:nil];
    // 获取 oid
    [self createOid];
    // Bmob-IM
    [self initBmobIM];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    if ([self.sharedIM isConnected]) {
        [self.sharedIM disconnect];
    }
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    if (self.userid && self.userid.length > 0) {
        [self connectToServer];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    BmobUser *user = [BmobUser getCurrentUser];
    if (user) {
//        [self connectToServer];
    }
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    BmobUser *user = [BmobUser getCurrentUser];
    if (user) {
        NSString *string = [deviceToken description];
        //        MMLog(@"data:%@ string:%@",deviceToken,string)
        self.token = [[[string stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""];
        [self connectToServer];
    }
}

#pragma mark - 注册 Notification
- (void)registerNotification:(UIApplication *)application {
    
    if (kIS_IOS(8.0)) {
        //iOS8推送
        UIMutableUserNotificationCategory*categorys = [[UIMutableUserNotificationCategory alloc]init];
        categorys.identifier=@"PWDTestID";
        UIUserNotificationSettings*userNotifiSetting = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound)
                                                                                         categories:[NSSet setWithObjects:categorys,nil]];
        [[UIApplication sharedApplication]registerUserNotificationSettings:userNotifiSetting];
        [[UIApplication sharedApplication]registerForRemoteNotifications];
    }else{
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    }
}

#pragma mark - tab bar vc
- (void)initTabBarVC {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[LSTabBarController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

#pragma mark - UM 获取‘设备识别信息’
/**
 *  获取 ‘设备识别信息’  (友盟统计:添加测试设备时使用)
 */
- (void)createOid {
    
//    MMLog(@"---:%@",[UIDevice currentDevice].identifierForVendor.UUIDString);
//
//    Class cls = NSClassFromString(@"UMANUtil");
//    SEL deviceIDSelector = @selector(openUDIDString);
//    NSString *deviceID = nil;
//    if(cls && [cls respondsToSelector:deviceIDSelector]){
//        deviceID = [cls performSelector:deviceIDSelector];
//    }
//    if (!deviceID) {
//        MMLog(@"deviceID = nil ")
//        return;
//    }
//    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID} options:NSJSONWritingPrettyPrinted error:nil];
//    
//    MMLog(@"++++++++%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    
}

#pragma mark - Bmob
/**
 *  初始化 Bmob-IM
 */
- (void)initBmobIM {
    
    // 初始化 bmob sdk
    [Bmob registerWithAppKey:kAPPKEY_BMOB];
    
    self.sharedIM = [BmobIM sharedBmobIM];
    [self.sharedIM registerWithAppKey:kAPPKEY_BMOB];
    self.token = @"";
    
    BmobUser *user = [BmobUser getCurrentUser];
    if (user) {
        self.userid = user.objectId;
//        [self connectToServer];
    }else {
        // 接收通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogin:) name:kNotificationNameLogin object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogout:) name:kNotificationNameLogout object:nil];
    }
    
    self.sharedIM.delegate = self;
}

/**
 *  登录
 *
 *  @param noti NSNotification
 */
-(void)userLogin:(NSNotification *)noti{
    NSString *userId = noti.object;
    self.userid = userId;
    
    [self connectToServer];
}
/**
 *  登出
 *
 *  @param noti NSNotification
 */
-(void)userLogout:(NSNotification *)noti{
    [self.sharedIM disconnect];
}

/**
 *  连接服务器
 */
-(void)connectToServer{
    
    if (!self.userid) {
        MMLog(@"未登录:%@",self.userid)
        return;
    }
    if (!self.token) {
        MMLog(@" userToken == %@",self.token)
        return;
    }
    
    [self.sharedIM setupBelongId:self.userid];
    [self.sharedIM setupDeviceToken:self.token];
    [self.sharedIM connect];
}

#pragma mark - BmobIMDelegate
/**
 *  接收到新信息
 */
-(void)didRecieveMessage:(BmobIMMessage *)message withIM:(BmobIM *)im{
    
    BmobIMUserInfo *userInfo = [self.sharedIM userInfoWithUserId:message.fromId];
    if (!userInfo) {
        [LSUserService loadUserWithUserId:message.fromId completion:^(BmobIMUserInfo *result, NSError *error) {
            if (result) {
                [self.sharedIM saveUserInfo:result];
                [[NSNotificationCenter defaultCenter] postNotificationName:kNewMessageFromer object:nil];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kNewMessagesNotifacation object:message];
        }];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:kNewMessagesNotifacation object:message];
    }
}

/**
 *  获取到离线消息
 *
 *  @param array 离线消息数组
 *  @param im    BmobIM对象
 */
-(void)didGetOfflineMessagesWithIM:(BmobIM *)im{
    
    NSArray *objectIds = [self.sharedIM allConversationUsersIds];
    if (objectIds && objectIds.count > 0) {
        [LSUserService loadUsersWithUserIds:objectIds completion:^(NSArray *array, NSError *error) {
            if (array && array.count > 0) {
                [self.sharedIM saveUserInfos:array];
                [[NSNotificationCenter defaultCenter] postNotificationName:kNewMessageFromer object:nil];
            }
        }];
    }
    
}



@end

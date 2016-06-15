//
//  Common.m
//  PwdTest
//
//  Created by Lost_souls on 16/4/29.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "Common.h"


NSString *const kAPPKEY_UM      = @"5723271867e58e2332002878";
NSString *const kAPPKEY_BMOB    = @"61fc2fba11857b1a75ff14614161356f";
NSString *const kNotificationNameLogin          = @"kNotifiNameLogin";
NSString *const kNotificationNameLogout         = @"kNotifiNameLogout";
NSString *const kNotificationNamePresentLoginVC = @"NotificationNamePresentLoginVC";

static NSString *const kLSPwdUser       = @"_User";
static NSString *const kLSPwdString     = @"LS_PWD_STRING";

@interface Common ()

@property (strong,nonatomic) Reachability *reachab;
@end

@implementation Common
@synthesize user;


static Common *common = nil;

+ (Common *)defaultCommon {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (common == nil) {
            common = [[Common alloc] init];
        }
    });
    
    return common;
}

#pragma mark - Cache & Path
+(NSString *)cachePath{
    NSArray *paths       = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath  = [paths objectAtIndex:0];
    return cachePath;
}

+(NSString *)audioCacheDirectory{
    NSString *path = [NSString stringWithFormat:@"%@/Audio",[self cachePath]];
    BOOL idDirectory = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&idDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return path;
}

+ (void)CommonSaveMM:(NSString *)mmString {
    
    BmobQuery *query = [BmobQuery queryWithClassName:kLSPwdUser];
    NSString *uid = [BmobUser getCurrentUser].objectId;
    MMLog(@"uid:%@",uid)
    [query getObjectInBackgroundWithId:uid block:^(BmobObject *object, NSError *error) {
        //
        if (error) {
            MMLog(@"error:%@",error);
            return ;
        }
        
        if (object) {
            if ([object isKindOfClass:[BmobUser class]]) {
                BmobUser *buser = (BmobUser *)object;
                //表里有id为 ??? 的数据
                //打印objectId,createdAt,updatedAt
//                NSLog(@"object.objectId  = %@", [object objectId]);
//                NSLog(@"object.createdAt = %@", [object createdAt]);
//                NSLog(@"object.updatedAt = %@", [object updatedAt]);
                MMLog(@"object.username  = %@", [buser username]);
                
                // 更新列的数据
                [object setObject:mmString forKey:kLSPwdString];
                [object updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    //
                    if (error) {
                        MMLog(@"error:%@",error);
                        return ;
                    }
                    MMLog(@"UPDATE SUC")
                }];
            }
        }
        
    }];
    
}

#pragma mark - 监控网络状态

- (NetworkStatus )monitoringNetwork {
    if (self.reachab == nil) {
        self.reachab = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    }
    NetworkStatus status = [self.reachab currentReachabilityStatus];
    switch (status) {
        case NotReachable:
            //
            MMLog(@" not wlan ")
            break;
        case ReachableViaWiFi:
            //
            //MMLog(@" use wifi ")
            break;
        case ReachableViaWWAN:
            //
            //MMLog(@" use WWAN -- 2/3/4G ")
            break;
            
        default:
            break;
    }
    
    return status;
}

- (NetworkStatus)networkStatus {
    
//    Reachability *reachab = ;
//    NetworkStatus status = [reachab currentReachabilityStatus];
//    return [[Reachability reachabilityWithHostName:@"www.baidu.com"] currentReachabilityStatus];
    
    return [self monitoringNetwork];
}

#pragma mark - 

-(NSDateFormatter *)dateFormatter{
    
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
        [_dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    }
    
    return _dateFormatter;
}

@end

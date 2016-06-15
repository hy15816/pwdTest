//
//  MyDynamicModel.h
//  PwdTest
//
//  Created by Lost_souls on 16/5/7.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyDynamicView.h"


KPWD_EXTERN NSString *const kDyIdKey;
KPWD_EXTERN NSString *const kDyDateKey;
KPWD_EXTERN NSString *const kDyUsernameKey;
KPWD_EXTERN NSString *const kDyContentKey;
KPWD_EXTERN NSString *const kDyReviewListKey;
KPWD_EXTERN NSString *const kDyHasPhoneStyleKey;
KPWD_EXTERN NSString *const kDyPraisesListKey;

/**
 *  动态
 */
@interface MyDynamicModel : NSObject

/**
 *  用户id
 */
@property (strong,nonatomic) NSString *dy_id;
/**
 *  用户名
 */
@property (strong,nonatomic) NSString *dy_username;
/**
 *  动态内容
 */
@property (strong,nonatomic) NSString *dy_content;
/**
 *  发布时间
 */
@property (strong,nonatomic) NSString *dy_date;
/**
 *  评论
 */
@property (strong,nonatomic) NSMutableArray *dy_reviewList;

/**
 *  手机标识
 */
@property (assign,nonatomic) BOOL dy_hasPhoneStyle;

/**
 *  点赞
 */
@property (strong,nonatomic) NSMutableArray *dy_praisesList;



@property (assign,nonatomic) CGFloat dy_cellHeight;

+ (MyDynamicModel *)dynamic:(NSDictionary *)dic;

@end

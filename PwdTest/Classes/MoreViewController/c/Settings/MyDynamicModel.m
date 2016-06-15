//
//  MyDynamicModel.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/7.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "MyDynamicModel.h"
#import "NSDictionary+YYAdd.h"
#import "NSDictionary+LSAdd.h"

NSString *const kDyIdKey           = @"dy_id";
NSString *const kDyDateKey         = @"dy_date";
NSString *const kDyUsernameKey     = @"dy_username";
NSString *const kDyContentKey      = @"dy_content";
NSString *const kDyReviewListKey   = @"dy_reviewList";
NSString *const kDyHasPhoneStyleKey= @"dy_hasPhoneStyle";
NSString *const kDyPraisesListKey  = @"dy_praisesList";

@implementation MyDynamicModel

//@synthesize dy_date;
//@synthesize dy_id;
//@synthesize dy_reviewList;
//@synthesize dy_content;
//@synthesize dy_username;
@synthesize dy_cellHeight;

+ (MyDynamicModel *)dynamic:(NSDictionary *)dic {
    
    MyDynamicModel *dy = [[MyDynamicModel alloc] init];
    dy.dy_id = [dic stringValueForKey:kDyIdKey default:nil];
    dy.dy_date = [dic stringValueForKey:kDyDateKey default:nil];
    dy.dy_username = [dic stringValueForKey:kDyUsernameKey default:nil];
    dy.dy_content = [dic stringValueForKey:kDyContentKey default:nil];
    dy.dy_reviewList = [dic arrayForKey:kDyReviewListKey];
    dy.dy_hasPhoneStyle = [dic boolValueForKey:kDyHasPhoneStyleKey default:NO];
    dy.dy_praisesList = [dic arrayForKey:kDyPraisesListKey];
    return dy;
}

@end

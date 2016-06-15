//
//  MyDynamicView.h
//  PwdTest
//
//  Created by Lost_souls on 16/5/7.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicModel : NSObject

@property (strong,nonatomic) NSString *uid;
@property (strong,nonatomic) NSString *uname;
@property (strong,nonatomic) NSString *ucontent;

+ (DynamicModel *)model:(NSDictionary *)dic;

@end

/**
 *  cell 的高度
 */
static float kReviewCellHeight = 25.f;

@protocol MyDynamicViewDelegate;
@interface MyDynamicView : UIView

@property (strong, nonatomic) UITableView *dynamicTableView;
@property (strong, nonatomic) NSMutableArray *dataListArray;
@property (assign, nonatomic) id<MyDynamicViewDelegate> delegate;

- (void)addView;

@end

@protocol MyDynamicViewDelegate <NSObject>
@optional
- (void)myDynamic:(MyDynamicView *)dynamicView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end




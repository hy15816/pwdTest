//
//  MyDynamicCell2.h
//  PwdTest
//
//  Created by Lost_souls on 16/5/7.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDynamicModel.h"

@protocol MyDynamicCell2Delegate;
@interface MyDynamicCell2 : UITableViewCell

+ (MyDynamicCell2 *)cellWithTable:(UITableView *)table;

@property (strong,nonatomic) MyDynamicModel *dynamicModel;
@property (assign,nonatomic) id<MyDynamicCell2Delegate> delegate;
@end

@protocol MyDynamicCell2Delegate <NSObject>

//- (void)textFieldWillEditing:(UITextField *)textField;


@end

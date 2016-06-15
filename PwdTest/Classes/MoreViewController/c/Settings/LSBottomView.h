//
//  LSBottomView.h
//  PwdTest
//
//  Created by Lost_souls on 16/5/7.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSBottomViewDelegate;
@interface LSBottomView : UIView

@property (strong, nonatomic) IBOutlet UITextField *inputField;
@property (strong, nonatomic) NSString *fieleplaceholder;
@property (assign, nonatomic) id<LSBottomViewDelegate> delegate;

@end


@protocol LSBottomViewDelegate <NSObject>

- (void)LSBottomViewDismiss;

@end

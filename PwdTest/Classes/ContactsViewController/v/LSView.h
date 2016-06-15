//
//  LSView.h
//  PwdTest
//
//  Created by Lost_souls on 16/5/26.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSView;
@protocol LSViewDelegate <NSObject>

- (void)lsView:(LSView *)view tag:(NSInteger)tag;

@end

@interface LSView : UIView

@property (assign,nonatomic) id<LSViewDelegate>delegate;
+ (instancetype)createLSView:(CGRect)frame;
- (instancetype)createLSView:(CGRect)frame;
//+ (void)btnAction:(UIButton *)btn;
@end

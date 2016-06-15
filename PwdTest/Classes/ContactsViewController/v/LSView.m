//
//  LSView.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/26.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "LSView.h"

@implementation LSView

+ (instancetype)createLSView:(CGRect)frame{
    
    return [[self alloc] createLSView:frame];
}

- (instancetype)createLSView:(CGRect)frame{
    
    LSView *view = [[LSView alloc] initWithFrame:frame];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"1111" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor grayColor]];
    btn.frame = CGRectMake(0, 100, 100, 40);
    btn.tag = 1001;
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"1111" forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor grayColor]];
    btn2.frame = CGRectMake(0, 0, 100, 40);
    btn2.tag = 1002;
    [btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn2];
    
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        //
//        [self createSubViews];
    }
    
    return self;
}

- (void)createSubViews{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"1111" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor grayColor]];
    btn.frame = CGRectMake(0, 100, 100, 40);
    btn.tag = 1001;
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"1111" forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor grayColor]];
    btn2.frame = CGRectMake(0, 0, 100, 40);
    btn2.tag = 1002;
    [btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn2];
    
}

- (void)btnAction:(UIButton *)btn{

    if (self.delegate && [self.delegate respondsToSelector:@selector(lsView:tag:)]) {
        [self.delegate lsView:self tag:btn.tag];
    }
}

//+ (void)btnAction:(UIButton *)btn;{
//    
//}
@end

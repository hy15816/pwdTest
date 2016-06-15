//
//  LSBottomView.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/7.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "LSBottomView.h"

@interface LSBottomView ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;

@property (strong, nonatomic) IBOutlet UIButton *btn_AT;
@property (strong, nonatomic) IBOutlet UIButton *btn_face;
@property (strong, nonatomic) IBOutlet UIButton *btn_checkImg;

- (IBAction)btn_ATAction:(id)sender;
- (IBAction)btn_faceAction:(UIButton *)sender;
- (IBAction)btn_checkImgAction:(UIButton *)sender;


@end

@implementation LSBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//static LSBottomView *lsbottom = nil;
//+ (LSBottomView *)LSDefault {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        if (lsbottom == nil) {
//            lsbottom = [[[NSBundle mainBundle] loadNibNamed:@"LSBottomView" owner:nil options:nil] lastObject]; //[[LSBottomView alloc] init];
//        }
//    });
//    
//    return lsbottom;
//}

- (void)awakeFromNib {
    
    MMLog(@",,,,,,,")
    
//    self.inputField.delegate = self;
    self.inputField.placeholder = self.fieleplaceholder?self.fieleplaceholder:@"说点儿什么吧";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
    
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//    MMLog(@"")
//    
//}

//- (instancetype)initWithFrame:(CGRect)frame {
//    CGFloat dfHeight = frame.size.height;
//    if (dfHeight < 80.f) {
//        dfHeight = 80.f;
//    }
//    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, dfHeight)];
//    if (self) {
//        
//    }
//    
//    return self;
//}

//+ (instancetype)LSBottomViewWithFrame:(CGRect)frame {
//    
//    CGFloat dfHeight = frame.size.height;
//    if (dfHeight < 80.f) {
//        dfHeight = 80.f;
//    }
////    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, dfHeight)];
//    
//    LSBottomView *bottom =[LSBottomView LSDefault];
//    
//    bottom.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, dfHeight);
//    
//    
//    return bottom;
//}
/**
 *   @联系人
 *
 *  @param sender UIButton
 */
- (IBAction)btn_ATAction:(id)sender {
}

/**
 *  显示表情
 *
 *  @param sender UIButton
 */
- (IBAction)btn_faceAction:(UIButton *)sender {
}
/**
 *  选择图片
 *
 *  @param sender UIButton
 */
- (IBAction)btn_checkImgAction:(UIButton *)sender {
}



#pragma mark - 

- (void)textFieldDidEndEditing:(UITextField *)textField {
    MMLog(@"textFieldDidEndEditing")
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    MMLog(@"textFieldShouldEndEditing");
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    MMLog(@"res first");
    return YES;
}

- (void)textFieldEndEditing:(UITextField *)textField {
    
//    MMLog(@"textFieldEndEditing");
    
    
    [UIView animateWithDuration:.25 animations:^{
        //
        self.frame = CGRectMake(0, kDEVICE_H, kDEVICE_W, self.frame.size.height);
        
    }];
    
    
}

@end

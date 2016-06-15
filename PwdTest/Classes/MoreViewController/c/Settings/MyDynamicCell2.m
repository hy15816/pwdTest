//
//  MyDynamicCell2.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/7.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "MyDynamicCell2.h"
#import "NSString+YYAdd.h"
#import "NSString+LSAdd.h"
#import "UIView+YYAdd.h"

@interface MyDynamicCell2 ()<MyDynamicViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *dyUserImgBtn;
@property (strong, nonatomic) IBOutlet UILabel *dyUserNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dyDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *dyContentLabel;
@property (strong, nonatomic) IBOutlet MyDynamicView *dynamicView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topViewCons;
@property (strong, nonatomic) IBOutlet UIView *dySeeView;
@property (strong, nonatomic) IBOutlet UIView *dyBottomView;
@property (strong, nonatomic) IBOutlet UIView *topLineView;
@property (strong, nonatomic) IBOutlet UIImageView *topLineImgv;
@property (strong, nonatomic) IBOutlet UIView *dyPareseView;
@property (strong, nonatomic) IBOutlet UITextField *bottomField;

@end

@implementation MyDynamicCell2

+ (MyDynamicCell2 *)cellWithTable:(UITableView *)table {
    
    
    static NSString *dyCellID = @"dyCellID2";
    MyDynamicCell2 *cell = [table dequeueReusableCellWithIdentifier:dyCellID];
    if (cell == nil) {
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"MyDynamicCell2" owner:self options:nil];
        cell = [arr lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
    
    return cell;
}

-(void)setDynamicModel:(MyDynamicModel *)dynamicModel {
    
    _dynamicModel = dynamicModel;
    
    self.dyDateLabel.text = dynamicModel.dy_date;
    self.dyUserNameLabel.text = dynamicModel.dy_username;
    self.dyContentLabel.text = dynamicModel.dy_content;
    [self.dyUserImgBtn setImage:[UIImage imageNamed:@"login_register_button"] forState:UIControlStateNormal];
//    self.dyUserImgBtn.layer.cornerRadius = 20.f;
//    self.dyUserImgBtn.layer.masksToBounds = YES;
    
//    MMLog(@"content:%@",dynamicModel.dy_content)
    CGFloat h1 = [dynamicModel.dy_content heightForFont:[UIFont systemFontOfSize:14] width:kDEVICE_W - 20];
//    CGFloat h = [dynamicModel.dy_content heightWithFont:[UIFont systemFontOfSize:14] width:kDEVICE_W-20];
//    MMLog(@"h1:%f,h:%f",h1,h);
    
    self.topViewCons.constant = h1 + self.dyUserImgBtn.frame.size.height + 5 + 5 + 35;
    
    CGFloat h2 = dynamicModel.dy_reviewList.count * kReviewCellHeight;
//    MMLog(@"h2:%f",h2);
    
    CGFloat heightOther = self.dySeeView.height + self.dyBottomView.height + self.topLineView.height + self.dyPareseView.height;
    
    dynamicModel.dy_cellHeight = self.topViewCons.constant + h2 + heightOther;
    
    [self.dynamicView addView];
    self.dynamicView.dataListArray = dynamicModel.dy_reviewList;
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.dynamicView.delegate = self;
    
    UIButton *rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(self.bottomField.frame.size.width - 30, 0, 30, 30);
//    [rightBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [rightBtn setTitle:@"😓" forState:UIControlStateNormal];
    self.bottomField.rightViewMode = UITextFieldViewModeAlways;
    self.bottomField.rightView = rightBtn;
//    self.bottomField.delegate = self;
}

//#pragma mark - 
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldWillEditing:)]) {
//        [self.delegate textFieldWillEditing:textField];
//    }
//    
//    return YES;
//}

#pragma mark -
- (void)myDynamic:(MyDynamicView *)dynamicView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MMLog(@"ssssss");
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

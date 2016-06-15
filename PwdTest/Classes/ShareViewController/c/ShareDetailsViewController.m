//
//  ShareDetailsViewController.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/2.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "ShareDetailsViewController.h"
#import "FindTableViewController.h"

@interface ShareDetailsViewController ()<UIActionSheetDelegate>

- (IBAction)buttonAction:(UIButton *)sender;
@property (strong,nonatomic) UIView *bgView;


@end

@implementation ShareDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self.view addSubview:self.bgView];
    
//    self.view.alpha = .5;
    
    [self presentShareViewAlert:@"1234567890-9ytredfghjklkhgf4yhujikolmvcdfhijk" titles:@"title0",@"title1",@"title2",@"title3",nil];
    
    //[self performSelector:@selector(abc) withObject:nil afterDelay:5];
    [self abc];
    
    if (self.delegate) {
        self.view.backgroundColor =  [self.delegate parentViewColor];
    }
    
    [self addRightItemWithTitle:@"go find" block:^UIViewController *(UIBarButtonItem *item) {
        //
        return kStoryboardShare(@"FindTableViewController");
    }];
    
    
}

- (void)abc {
    
    self.timeout([UIColor greenColor]);
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)presentShareViewAlert:(NSString *)alert titles:(NSString *)otherButtonTitles, ... {
    
//    if ([UIDevice currentDevice].systemVersion.floatValue <= 8.3) {
//        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:alert delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:otherButtonTitles, nil];
//        [sheet showInView:self.view];
//    }else {
//        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:alert preferredStyle:UIAlertControllerStyleActionSheet];
//        
//        for (int i=0; i<titles.count; i++) {
//            
//            UIAlertActionStyle style = UIAlertActionStyleDefault;
//            NSString *title = titles[i];
//            
//            if (i == titles.count - 1) {
//                style = UIAlertActionStyleCancel;
//            }
//            
//            UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
//                //
//                MMLog(@"1")
//            }];
//            
//            
//            [alertVC addAction: action];
//        }
        
        
//        [alertVC addAction:[UIAlertAction actionWithTitle:@"title1" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            //
//            MMLog(@"1")
//        }]];
//        
//        [alertVC addAction:[UIAlertAction actionWithTitle:@"actio2_title" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//            //
//            MMLog(@"2")
//        }]];
        
        
        
        
//        [self presentViewController:alertVC animated:YES completion:nil];
    
//    }
    
}

#pragma mark - UIActionSheetDelegate
//- (void)actionSheetCancel:(UIActionSheet *)actionSheet {}
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    
//    MMLog(@"action sheet index :%ld",(long)buttonIndex);
//    
//}


#pragma mark - getters and setters
- (IBAction)buttonAction:(UIButton *)sender {
    
    [self presentShareViewAlert:@"1234567890-9ytredfghjklkhgf4yhujikolmvcdfhijk" titles:@"title0",@"title1",@"title2",@"title3",nil];
}

- (UIView *)bgView {
    
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bgView.backgroundColor = [UIColor lightTextColor];
        _bgView.alpha = .5;
        
    }
    
    return _bgView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

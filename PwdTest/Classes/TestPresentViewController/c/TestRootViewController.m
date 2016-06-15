//
//  TestRootViewController.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/11.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//  主控制器

#import "TestRootViewController.h"
#import "TargetViewController.h"
#import "XWInteractiveTransition.h"
#import "UIView+YYAdd.h"
#import "TestSWTableViewController.h"
#import "LSView.h"


@interface TestRootViewController ()<LSPresentDelegate,LSViewDelegate> // 子控制器的delegate

@property (assign,nonatomic) BOOL isAnimation;
@property (nonatomic, strong)  XWInteractiveTransition *interactivePush; //转场类

@end

@implementation TestRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"title" style:UIBarButtonItemStyleDone target:self action:@selector(goTest)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"img_home_message"] style:UIBarButtonItemStyleDone target:self action:@selector(goTest)];
    
    
    self.view.backgroundColor = [UIColor blueColor];
    
    UIButton *btn_1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_1 setTitle:@"点我弹出下一个VC" forState:UIControlStateNormal];
    [btn_1 setBackgroundColor:[UIColor whiteColor]];
    btn_1.frame = CGRectMake(100, 100, 100, 50);
    [btn_1 addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_1];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点我push出下一个VC" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
    btn.frame = CGRectMake(100, 200, 100, 50);
    [btn addTarget:self action:@selector(pushNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //
    self.interactivePush = [XWInteractiveTransition interactiveTransitionWithTransitionType:XWInteractiveTransitionTypePresent GestureDirection:XWInteractiveTransitionGestureDirectionDown];
    typeof(self)weakSelf = self;
    self.interactivePush.presentConifg = ^{
        [weakSelf present];
    };
    
    [self.interactivePush addPanGestureForViewController:self];
//    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
//    swipe.direction = UISwipeGestureRecognizerDirectionDown;
//    
////  [self.view addGestureRecognizer:swipe];
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(lsPan:)];
//    pan.maximumNumberOfTouches = 1;
//    [self.view addGestureRecognizer:pan];
    
    
    LSView *view = [LSView createLSView: CGRectMake(0, 300, 300, 300)];
    view.delegate = self;
    [self.view addSubview:view];
    
    
}

- (void)lsView:(LSView *)view tag:(NSInteger)tag{
    
    MMLog(@"tag:%ld",(long)tag);
}

- (void)goTest {
    
    TestSWTableViewController *test = [[TestSWTableViewController alloc] init];
    [self.navigationController pushViewController:test animated:YES];
    
}

- (void)lsPan:(UIPanGestureRecognizer*)recognize {
    
    CGFloat pointBegan;
    CGFloat moveY = [recognize translationInView:recognize.view].y;;
    CGFloat pointEnd;
    switch (recognize.state) {
        case UIGestureRecognizerStateBegan:
            //
            self.isAnimation = YES;
//            pointBegan = [recognize translationInView:recognize.view].y;
            break;
        case UIGestureRecognizerStateChanged:
            //
//            moveY = [recognize translationInView:recognize.view].y;
            break;
            
        case UIGestureRecognizerStateEnded:
//            pointEnd = [recognize translationInView:recognize.view].y;
            self.isAnimation = NO;
            break;
        default:
            break;
    }
    
    MMLog(@"pb.y:%f",pointBegan);
    MMLog(@"moveY:%f",moveY)
    MMLog(@"pe.y:%f",pointEnd);
    if (moveY > kDEVICE_H/2) {
        if (!self.isAnimation) {
            [self present];
        }
        
    }
}

- (void)swipeDown:(UISwipeGestureRecognizer*)swipe {
    
    CGFloat pointBegan;
    CGFloat pointEnd;
    switch (swipe.state) {
        case UIGestureRecognizerStateBegan:
            //
            pointBegan = swipe.view.centerY;
            break;
        case UIGestureRecognizerStateChanged:
            //
            break;
            
        case UIGestureRecognizerStateEnded:
            pointEnd = swipe.view.centerY;
            break;
        default:
            break;
    }
    
    MMLog(@"pb.y:%f",pointBegan);
    MMLog(@"pe.y:%f",pointEnd);
    
}

- (void)present {
    TargetViewController *presentedVC = [TargetViewController new];
    presentedVC.delegate = self;
    [self presentViewController:presentedVC animated:YES completion:nil];
}

- (void)pushNext {
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [self present];
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LSPresentDelegate
- (void)presentedOneControllerPressedDissmiss{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent; {
    
    return self.interactivePush;
}
@end

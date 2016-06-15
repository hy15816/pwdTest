//
//  TargetViewController.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/11.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//  目标控制器

#import "TargetViewController.h"
#import "LSPresentAnimatedTransitioning.h"
#import "XWInteractiveTransition.h"

//  把弧度转化成角度
#define kRadianToDegrees(radian) (radian * 180.0 )/(M_PI)
//  把角度转化成弧度
#define kDegreesToRadian(x) (M_PI * (x) / 180.0 )

#import "LSPendulumView.h"

@interface TargetViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong)  XWInteractiveTransition *interactiveDismiss;
@property (nonatomic, strong)  XWInteractiveTransition *interactivePush;

@property (strong,nonatomic) UIView *viewLine;

@property (assign,nonatomic) CGFloat countAngle;

@property (strong,nonatomic) UIImageView *imgv;

@end

@implementation TargetViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    MMLog(@"90° = %f 弧度",kDegreesToRadian(90));
    MMLog(@"")
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点我弹出下一个VC" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
    btn.frame = CGRectMake(100, 100, 100, 50);
    [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"复位" forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor blueColor]];
    btn2.frame = CGRectMake(100, kDEVICE_H - 100, 100, 50);
    [btn2 addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
    
    self.interactiveDismiss = [XWInteractiveTransition interactiveTransitionWithTransitionType:XWInteractiveTransitionTypeDismiss GestureDirection:XWInteractiveTransitionGestureDirectionUp];
    [self.interactiveDismiss addPanGestureForViewController:self];
    
    
    self.viewLine = [[UIView alloc] initWithFrame:CGRectMake(50, 250, kDEVICE_W, kDEVICE_W)];
    UIImageView *imgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gate_view_gate"]];
    imgv.frame = CGRectMake(0, (kDEVICE_W -11)/2, kDEVICE_W/2, 22);
    [self.viewLine addSubview:imgv];
    self.viewLine.userInteractionEnabled = YES;
    
    self.viewLine.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.viewLine];
    
    
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];

    [self.viewLine addGestureRecognizer:pan];
    
    
    // ===========================================
    
    LSPendulumView *pendulumView = [[LSPendulumView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    pendulumView.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:pendulumView];
    
    // ============================================
    
//    self.imgv =[[UIImageView alloc] initWithFrame:CGRectMake(10, 300, 300, 22)];
//    self.imgv.image = [UIImage imageNamed:@"gate_view_gate"];
//    
//    [self.view addSubview:self.imgv];
    
//    [self.imgv.layer addAnimation:[self rotation:2 degree:0.5 direction:1 repeatCount:10] forKey:nil];
    

}

CGFloat angleBetweenLines(CGPoint line1Start, CGPoint line1End, CGPoint line2Start, CGPoint line2End) {
    
    CGFloat a = line1End.x - line1Start.x;
    CGFloat b = line1End.y - line1Start.y;
    CGFloat c = line2End.x - line2Start.x;
    CGFloat d = line2End.y - line2Start.y;
    
    CGFloat rads = acos(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));
    
    return   rads; //kRadianToDegrees(rads);
    
}

- (void)reset {
    
    [UIView animateWithDuration:.2 animations:^{
        //
        self.viewLine.transform = CGAffineTransformIdentity;
    }];
}

- (void)rotation:(UIPanGestureRecognizer*)panGesture {
    
    //获取当前位置相对于手势开始时经过的弧度
//    CGFloat rotation = rotationGesture.rotation;
//    NSLog(@"%.2f",rotation);
//    
//    
//    UIView *view = rotationGesture.view;
//    if (rotationGesture.state == UIGestureRecognizerStateBegan || rotationGesture.state == UIGestureRecognizerStateChanged) {
//        view.transform = CGAffineTransformRotate(view.transform, rotationGesture.rotation);
//        [rotationGesture setRotation:0];
//    }
    
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.viewLine.bounds), CGRectGetMidY(self.viewLine.bounds));
    
    
    CGPoint currentLocation = [panGesture translationInView:panGesture.view];
    CGPoint previousLocation = [panGesture velocityInView:panGesture.view];
    MMLog(@"==========================================");
    MMLog(@"%f,%f",center.x,center.y);
    MMLog(@"%f,%f",currentLocation.x,currentLocation.y);
    MMLog(@"%f,%f",previousLocation.x,previousLocation.y);
    MMLog(@"==========================================");
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            MMLog(@"began")
            break;
        case UIGestureRecognizerStateChanged:
            MMLog(@"changed")
            
            
//            double degrees = atan2((currentLocation.y - center.y), (currentLocation.x - center.x)) - atan2((previousLocation.y - center.y), (previousLocation.x - center.x));

            double degrees = angleBetweenLines(center, currentLocation, center, CGPointMake(currentLocation.x+1, currentLocation.y+1));
            
            self.viewLine.transform = CGAffineTransformRotate(self.viewLine.transform, degrees);
            
            break;
        case UIGestureRecognizerStateEnded:
            MMLog(@"Ended")
            break;
        default:
            break;
    }
    
    
}

-( CABasicAnimation *)rotation:( float )dur degree:( float )degree direction:( int )direction repeatCount:( int )repeatCount

{
    
    CATransform3D rotationTransform = CATransform3DMakeRotation (degree, 0 , 0 , direction);
    
    CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath : @"transform" ];
    
    animation. toValue = [ NSValue valueWithCATransform3D :rotationTransform];
    
    
    animation. duration   =  dur;
    
    animation. autoreverses = NO ;
    
    animation. cumulative = NO ;
    
    animation. fillMode = kCAFillModeForwards ;
    
    animation. repeatCount = repeatCount;
    
    animation. delegate = self ;
    
    return animation;
    
}
//
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    CGPoint pointC = self.viewLine.center;
//
//    UITouch *touche =[touches anyObject];
//    CGPoint lPoint = [touche previousLocationInView:self.viewLine]; //上一次的点
//    CGPoint cPoint = [touche locationInView:self.viewLine]; //当前点
//    
//    CGFloat angle = angleBetweenLines(pointC, lPoint, pointC, cPoint);
//    MMLog(@"......angle:%f",angle);
//    
//    if (cPoint.x < lPoint.y || cPoint.y < lPoint.y) {
//        MMLog(@"右上滑")
//        self.countAngle = self.countAngle + angle;
//        MMLog(@" self.countAngle:%f",self.countAngle)
//        if (self.countAngle > M_PI / 4) {
//            self.viewLine.userInteractionEnabled = NO;
//            [UIView animateWithDuration:.25 animations:^{
//                //
//                self.viewLine.transform = CGAffineTransformMakeRotation(M_PI/2);
//            }];
//            
//        }
//        if (self.countAngle >= M_PI/2) {
//            
//            MMLog(@">>>>>>>>>>> self.countAngle:%f",self.countAngle)
//            return;
//        }
//    }
//    
//    if (cPoint.x > lPoint.x && cPoint.y > lPoint.y) {
//        MMLog(@"左下滑");
////        self.countAngle = self.countAngle - angle;
////        if (self.countAngle <=0) {
////            MMLog(@"<<<<<<<<<<self.countAngle:%f",self.countAngle)
////            return;
////        }
//        
//        angle = -angle;
//        
//        
//    }
//    
//    CGAffineTransform currentTransform = self.imgv.transform;
//    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, angle);
//    self.imgv.transform = newTransform;
//    
////    self.viewLine.transform = CGAffineTransformMakeRotation(aa);
//    
//   
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    self.countAngle = 0.0;
//}
//
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    self.countAngle = 0.0;
//}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint center = CGPointMake(CGRectGetMidX(self.imgv.bounds), CGRectGetMidY(self.view.bounds)-11);

    
    CGPoint currentLocation = [touch locationInView:self.view];
    CGPoint previousLocation = [touch previousLocationInView:self.view];
    
    double degrees = atan2((currentLocation.y - center.y), (currentLocation.x - center.x)) - atan2((previousLocation.y - center.y), (previousLocation.x - center.x));
    
    //self.imgv.transform = CGAffineTransformRotate(self.imgv.transform, degrees);
    CGPoint imgvp = CGPointMake(self.imgv.frame.origin.x + self.imgv.frame.size.width, self.imgv.frame.origin.y + self.imgv.frame.size.height *.5);
    MMLog(@"imgvp:(%f,%f)",imgvp.x,imgvp.y)
//    [UIView animateWithDuration:0.01 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        //
//        
//        CGPoint point = [self CirclePoint:self.imgv.frame.size.width withCenterCircle:center withCurrentPoint:currentLocation];
//        self.imgv.frame = CGRectMake(point.x, point.y, self.imgv.frame.size.width, self.imgv.frame.size.height);
//        
//    } completion:^(BOOL finished) {
//        //
//    }];

    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //Set some variables on the animation
    pathAnimation.calculationMode = kCAAnimationPaced;
    //We want the animation to persist - not so important in this case - but kept for clarity
    //If we animated something from left to right - and we wanted it to stay in the new position,
    //then we would need these parameters
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 1;
    //Lets loop continuously for the demonstration
    pathAnimation.repeatCount = 1;
 
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, currentLocation.x, currentLocation.y);
//    CGPathAddQuadCurveToPoint(curvedPath, NULL, 10, 450, 310, 450);
//    CGPathAddQuadCurveToPoint(curvedPath, NULL, 310, 10, 10, 10);
    CGPathAddArc(curvedPath, NULL, 0, imgvp.x,imgvp.y ,kDEGREES_TO_RADIANS(0) , kDEGREES_TO_RADIANS(90), NO);
    
    //Now we have the path, we tell the animation we want to use this path - then we release the path
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    [self.imgv.layer addAnimation:pathAnimation forKey:@"position"];
    
}

/**
 *  根据圆心的坐标点、半径、当前手势所在的坐标点，计算出圆的运动轨迹坐标
 *  @param radius 圆心半径
 *  @param centerCircle 圆心的坐标点
 *  @param currentPoint 当前的手势所在的坐标点
 *  @return CGPoint 返回圆的坐标
 */
- (CGPoint)CirclePoint:(CGFloat)radius withCenterCircle:(CGPoint)centerCircle withCurrentPoint:(CGPoint)currentPoint
{
    CGPoint cPoint;
    CGFloat x = currentPoint.x;
    CGFloat y = currentPoint.y;
    CGFloat cX ; //圆的X坐标轨迹
    CGFloat cY ; //圆的Y坐标轨迹
    CGFloat daX; // 圆心到转动按钮的距离的平方
    //CGFloat daY;
    CGFloat aX;  // 圆心到转动按钮的距离
    //CGFloat aY;
    CGFloat cosX;  // 圆心水平方向与转动按钮形成的夹角的cos值
    
    //圆心与触控点的距离的平方（勾股定理）
    daX =  (x - centerCircle.x)*(x - centerCircle.x) + (y - centerCircle.y)*(y - centerCircle.y);
    aX = sqrt(daX); //开根号  //圆心与触控点的距离
    cosX =  fabs(x - centerCircle.x)/aX;  //绝对值
    cX = cosX*radius ; //  x =R * cosX;  圆心到触控点在水平坐标的X的值
    cY = sqrt(radius*radius - cX*cX);
    
    if(x<centerCircle.x) //如果X所在的点小于圆心 在圆心的左边
    {
        cX = centerCircle.x - cX;
    }
    else
    {
        cX = centerCircle.x + cX;
    }
    
    if(y<centerCircle.y)
    {
        cY = centerCircle.y - cY;
    }
    else
    {
        cY = centerCircle.y + cY;
    }
    cPoint.x = cX;
    cPoint.y = cY;
    return cPoint;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    // 触发
//    
//    [self dismiss];
//}

- (void)dismiss {
    if (_delegate && [_delegate respondsToSelector:@selector(presentedOneControllerPressedDissmiss)]) {
        [_delegate presentedOneControllerPressedDissmiss];
    }
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [LSPresentAnimatedTransitioning transitionWithTransitionType:LSPresentTransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [LSPresentAnimatedTransitioning transitionWithTransitionType:LSPresentTransitionTypeDismiss];
}


// 
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _interactiveDismiss.interation ? _interactiveDismiss : nil;;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    
    XWInteractiveTransition *interactivePresent = [_delegate interactiveTransitionForPresent];
    return interactivePresent.interation ? interactivePresent : nil;
}



@end

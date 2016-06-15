//
//  ViewController.m
//  PwdTest
//
//  Created by Lost_souls on 16/4/28.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#define kACCOUNT_NUMBER     @"Lost_souls"
#define kBUNDLE_INDETIFIER  [[NSBundle mainBundle] bundleIdentifier]
//#define kKEY_CHAIN_WRAPPER  

#import "ShareViewController.h"
#import "UMsocial.h"
#import "MobClick.h"
#import "ShareDetailsViewController.h"

@interface ShareViewController ()<UMSocialUIDelegate,ShareDetailsViewControllerDelegate>

- (IBAction)buttonShareAction:(UIButton *)sender;
- (IBAction)buttonLoginAction:(UIButton *)sender;


@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    __block ShareViewController *blockSelf = self;
    __weak typeof(ShareViewController) *weakSelf = self;
    [self addRightItemWithTitle:@"go" block:^(UIBarButtonItem *item) {
        item.title = @"go dvc";
        ShareDetailsViewController *detail = [[ShareDetailsViewController alloc] init];
        detail.title = @"detail";
        // 实现 delegate
        detail.delegate = weakSelf;
        // 实现 block
        detail.timeout = ^(UIColor *c){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.view.backgroundColor = c;
            });
        };
        
        return detail;
    }];
    
    
}

- (UIColor *)parentViewColor {
    
    return [UIColor redColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonShareAction:(UIButton *)sender {
    
    MMLog(@"tag -- %ld",(long)sender.tag);
    switch (sender.tag) {
        case 2:
            //
            [MobClick event:@"btn2Click" attributes:@{@"name":@"btn2",@"type":@"102"}];
//            [self shareContent];
            [self shareText];
            break;
        case 3:
            //
            [MobClick event:@"btn3Click" attributes:@{@"name":@"btn3",@"type":@"103"}];
            [self presentView];
            break;
        default:
            
            break;
    }
    
    
    
}

- (void)test {
    
    [self presentView];
}

- (IBAction)buttonLoginAction:(UIButton *)sender {
    
    switch (sender.tag) {
        case 1001:
            // weibo
            [self sinaLogin];
            break;
        case 1002:
            // QQ
            break;
        case 1003:
            // wechat
            break;
            
        default:
            break;
    }
    
}

- (void)sinaLogin {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@, \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.message);
            
        }});
}

- (void)deleteLoginAuthorization{
    
    [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        NSLog(@"response is %@",response);
    }];
}

- (void)shareText {
    
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToSina] content:@"SHARE CONTENT" image:nil location:nil urlResource:nil presentedController:nil completion:^(UMSocialResponseEntity *response) {
        //
        if (response.responseCode == UMSResponseCodeSuccess) {
            MMLog(@"...........share suc");
            return ;
        }
        MMLog(@"share err:%@",response.message);
    }];
}
- (void)shareContent {
    
    [[UMSocialControllerService defaultControllerService] setShareText:@"kkkkkkkkk" shareImage:[UIImage imageNamed:@"wallet_credit_card"] socialUIDelegate:self];
}

- (void)presentView {
    
    MMLog(@"");
    [UMSocialSnsService presentSnsIconSheetView:self appKey:kAPPKEY_UM shareText:@"11111188888888888888yyyyjytygfolkijubvcdmjnhbgvfcdnbgvfvfv111111111111" shareImage:[UIImage imageNamed:@"wallet_credit_card"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,nil] delegate:self];
    
}


/**
 自定义关闭授权页面事件
 
 @param navigationCtroller 关闭当前页面的navigationCtroller对象
 
 */
-(BOOL)closeOauthWebViewController:(UINavigationController *)navigationCtroller socialControllerService:(UMSocialControllerService *)socialControllerService {
    
    return NO;
}

/**
 关闭当前页面之后
 
 @param fromViewControllerType 关闭的页面类型
 
 */
-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType {
    
}

/**
 各个页面执行授权完成、分享完成、或者评论完成时的回调函数
 
 @param response 返回`UMSocialResponseEntity`对象，`UMSocialResponseEntity`里面的viewControllerType属性可以获得页面类型
 */
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response {
    
    if (response.responseCode == UMSResponseCodeSuccess) {
        MMLog(@"....share suc ");
    }
    
    MMLog(@"response:%@",response.message);
    
}

/**
 点击分享列表页面，之后的回调方法，你可以通过判断不同的分享平台，来设置分享内容。
 例如：
 
 -(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
 {
 if (platformName == UMShareToSina) {
 socialData.shareText = @"分享到新浪微博的文字内容";
 }
 else{
 socialData.shareText = @"分享到其他平台的文字内容";
 }
 }
 
 @param platformName 点击分享平台
 
 @prarm socialData   分享内容
 */
-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData {
    
    
    MMLog(@".....did select social");
}


/**
 配置点击分享列表后是否弹出分享内容编辑页面，再弹出分享，默认需要弹出分享编辑页面
 
 @result 设置是否需要弹出分享内容编辑页面，默认需要
 
 */
-(BOOL)isDirectShareInIconActionSheet{

    
    return YES;
}


@end

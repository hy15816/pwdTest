//
//  MyDynamicViewController.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/7.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "MyDynamicViewController.h"
#import "MyDynamicCell2.h"
#import "MyDynamicModel.h"
#import "LSBottomView.h"
#import "MJRefresh.h"

@interface MyDynamicViewController ()<LSBottomViewDelegate,MyDynamicCell2Delegate>

@property (strong,nonatomic) UITableView *dytableView;
@property (strong,nonatomic) NSMutableArray *dynamicList;
@property (strong,nonatomic) LSBottomView *bottomView;

@property (assign,nonatomic) NSInteger pageNumber;
@property (assign,nonatomic) NSInteger pageSize;

@end

@implementation MyDynamicViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangedFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.dytableView];
    [self.view addSubview:self.bottomView];
    
    self.pageNumber = 1;
    self.pageSize = 5;
    
    self.dytableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //
        [self loadListData:YES pageNum:self.pageNumber pSize:self.pageSize];
    }];
    self.dytableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //
        self.pageNumber ++;
        [self loadListData:NO pageNum:self.pageNumber pSize:self.pageSize];
    }];
    
    
}

/**
 *  加载数据
 *
 *  @param refresh 刷新
 *  @param num     页数
 *  @param size    每页条数
 */
- (void)loadListData:(BOOL)refresh pageNum:(NSInteger)num pSize:(NSInteger)size {
    
    if (refresh) { //刷新
        [self.dynamicList removeAllObjects];
    }
    for (int i=0; i<5; i++) {
        NSMutableArray *reviews = [[NSMutableArray alloc] init];
        NSMutableArray *parses = [[NSMutableArray alloc] init];
        int abc = (arc4random()%20) + 1;
        for (int j=0; j < abc; j++) {
            NSDictionary *d = @{@"uid":[NSString stringWithFormat:@"%d",j],
                                @"uname":[NSString stringWithFormat:@"uname:%d",i],
                                @"ucontent":[NSString stringWithFormat:@"%d - review, review review,,, review,, review,,,",i]};
            DynamicModel *dy = [DynamicModel model:d];
            [reviews addObject:dy];
            int def = (arc4random()%30) + 1;
            for (int k=0; k<def; k++) {
                [parses addObject:[NSString stringWithFormat:@"name%d",k]];
            }
        }
        
        NSDictionary *dic = @{kDyIdKey:[NSString stringWithFormat:@"id--- %d",i],
                              kDyDateKey:[[Common defaultCommon].dateFormatter stringFromDate:[NSDate date]],
                              kDyUsernameKey:[NSString stringWithFormat:@"username,name:%d",i],
                              kDyContentKey:[NSString stringWithFormat:@"%d - cont我共发货我饿哦ent,co你好ntent,conte味道吧这是什么特傻ntco是内容ntentcontent,content--hbjbclskj弄IEu",i],
                              kDyReviewListKey:reviews,
                              kDyHasPhoneStyleKey:[NSNumber numberWithBool:i%2==0?YES:NO],
                              kDyPraisesListKey:parses
                              
                              };
        MyDynamicModel *mydy = [MyDynamicModel dynamic:dic];
        
        [self.dynamicList addObject:mydy];
    }
    
    [self.dytableView reloadData];
    [self.dytableView.mj_header endRefreshing];
    [self.dytableView.mj_footer endRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardWillChangedFrame:(NSNotification *)noti {
    NSDictionary *dic = noti.userInfo;
    float duration = [dic[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect r = [dic[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGRect r2 = [dic[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
//    MMLog(@"duration:%f",duration);
//    MMLog(@"r :%f,%f,%f,%f",r.origin.x,r.origin.y,r.size.width,r.size.height);
//    MMLog(@"r2:%f,%f,%f,%f",r2.origin.x,r2.origin.y,r2.size.width,r2.size.height);
    
    // 显示
    [UIView animateWithDuration:duration animations:^{
        //
        self.bottomView.frame = CGRectMake(0, kDEVICE_H - r.size.height - 80, kDEVICE_W, r.size.height + 80);
        [self.bottomView.inputField becomeFirstResponder];
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dynamicList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyDynamicCell2 *cell = [MyDynamicCell2 cellWithTable:tableView];
//    cell.textLabel.text = @"111111";;
    cell.dynamicModel = self.dynamicList[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    MMLog(@"....cell.h:%f",[self.dynamicList[indexPath.row] dy_cellHeight])
    return [self.dynamicList[indexPath.row] dy_cellHeight];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - LSBottomViewDelegate
- (void)LSBottomViewDismiss {
    
    
    // 刷新页面数据
}

#pragma mark - MyDynamicCell2Delegate


- (UITableView *)dytableView {
    
    if (!_dytableView) {
        _dytableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _dytableView.delegate = self;
        _dytableView.dataSource = self;
        _dytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    
    return _dytableView;
}

- (NSMutableArray *)dynamicList {
    if (!_dynamicList) {
        _dynamicList = [[NSMutableArray alloc] init];
    }
    
    return _dynamicList;
}

- (UIView *)bottomView {
    
    if (!_bottomView) {
        _bottomView = [[[NSBundle mainBundle] loadNibNamed:@"LSBottomView" owner:nil options:nil] lastObject];
        _bottomView.frame = CGRectMake(0, kDEVICE_H, kDEVICE_W, 80);
        _bottomView.fieleplaceholder = @"请输入";
        _bottomView.delegate = self;
    }
    
    return _bottomView;
}
@end

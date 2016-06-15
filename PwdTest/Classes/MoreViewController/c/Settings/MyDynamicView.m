//
//  MyDynamicView.m
//  PwdTest
//
//  Created by Lost_souls on 16/5/7.
//  Copyright © 2016年 __lost_souls. All rights reserved.
//

#import "MyDynamicView.h"
#import "NSDictionary+YYAdd.h"

@implementation DynamicModel

+ (DynamicModel *)model:(NSDictionary *)dic {
    
    DynamicModel *dynamic = [[DynamicModel alloc] init];
    dynamic.uid = [dic stringValueForKey:@"uid" default:nil];
    dynamic.uname = [dic stringValueForKey:@"uname" default:nil];
    dynamic.ucontent = [dic stringValueForKey:@"ucontent" default:nil];
    
    return dynamic;
}

@end

@interface MyDynamicView ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation MyDynamicView


- (instancetype)init{
    
    self = [super init];
    if (self) {
        //
        [self addSubview:self.dynamicTableView];
    }
    
    return self;
}

- (void)addView {
    
 [self addSubview:self.dynamicTableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *dyCellID = @"dyCellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dyCellID];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dyCellID];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    DynamicModel *dy = self.dataListArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@:%@",dy.uname,dy.ucontent];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kReviewCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(myDynamic:didSelectRowAtIndexPath:)]) {
        [self.delegate myDynamic:self didSelectRowAtIndexPath:indexPath];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)setDataListArray:(NSMutableArray *)dataListArray {
    _dataListArray = dataListArray;
    
    [self.dynamicTableView reloadData];
}

- (UITableView *)dynamicTableView {
    
    if (!_dynamicTableView) {
        _dynamicTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _dynamicTableView.scrollEnabled = NO;
        _dynamicTableView.delegate = self;
        _dynamicTableView.dataSource = self;
        _dynamicTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return _dynamicTableView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.dynamicTableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
}
@end

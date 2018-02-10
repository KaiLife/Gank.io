//
//  GKTodayVC.m
//  Gank.io
//
//  Created by 王权伟 on 2018/2/7.
//  Copyright © 2018年 王权伟. All rights reserved.
//

#import "GKTodayVC.h"
#import "GKTodayCell.h"
#import "GKTodayHeaderView.h"
#import "GKTodayModel.h"

@interface GKTodayVC ()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic) UILabel * titleLabel;//标题
@property(strong, nonatomic) UITableView * table;

@property(strong, nonatomic) NSMutableArray * data;//数据源
@property(strong, nonatomic) NSString * girlURL;//妹子图
@end

@implementation GKTodayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化UI
    [self initUI];
    
    //网络请求
    [self gankDayList];
    [self gankTitle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI {
    
    //标题
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.backgroundColor = RGB_HEX(0xD7E9F7);
    self.titleLabel.textColor = RGB_HEX(0x61ABD4);
    self.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [self.view addSubview:self.titleLabel];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(0);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft).offset(0);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight).offset(0);
            make.height.equalTo(33);
        } else {
            // Fallback on earlier versions
            make.top.left.right.equalTo(self.view);
            make.height.equalTo(33);
        }
    }];
    
    //table
    self.table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.estimatedSectionHeaderHeight = 200;
    self.table.estimatedSectionFooterHeight = 0;
    self.table.estimatedRowHeight = 108;
    [self.table registerClass:[GKTodayCell class] forCellReuseIdentifier:@"cell"];
    [self.table registerClass:[GKTodayHeaderView class] forHeaderFooterViewReuseIdentifier:@"headerView"];
    [self.view addSubview:self.table];
    
    [self.table makeConstraints:^(MASConstraintMaker *make) {
        
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.titleLabel.bottom).offset(0);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft).offset(0);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight).offset(0);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(0);
        } else {
            // Fallback on earlier versions
            make.left.bottom.right.equalTo(self.view);
            make.top.equalTo(self.titleLabel.bottom);
        }
        
    }];
}

#pragma mark 网络请求
- (void)gankTitle {
    
    NSString * url = @"/api/history/content/1/1";
    [GKNetwork getWithUrl:url completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error == nil) {
            NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            self.titleLabel.text = [[jsonDict objectForKey:@"results"][0] objectForKey:@"title"];
        }
        else {
            
        }
        
        
    }];
}

- (void)gankDayList {
    
    NSString * url = @"/api/day/history";
    [GKNetwork getWithUrl:url completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        if ([[jsonDict objectForKey:@"error"] integerValue] == 0) {
            NSArray * dayArray = [jsonDict objectForKey:@"results"];
            if (dayArray.count > 0) {
                NSString * day = dayArray[0];
                day = [day stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
                
                [self todayGank:day];
            }
        }
        
    }];
}

//最新干货
- (void)todayGank:(NSString *)day {
    
    NSString * url = [NSString stringWithFormat:@"/api/day/%@",day];
    
    [GKNetwork getWithUrl:url completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",jsonDict);
        
        NSDictionary * results = [jsonDict objectForKey:@"results"];
        
        NSMutableArray * contentArray = [NSMutableArray array];
        if ([results.allKeys containsObject:@"iOS"]) {
            [contentArray addObjectsFromArray:[results objectForKey:@"iOS"]];
        }
        
        if ([results.allKeys containsObject:@"Android"]) {
            [contentArray addObjectsFromArray:[results objectForKey:@"Android"]];
        }
        
        if ([results.allKeys containsObject:@"前端"]) {
            [contentArray addObjectsFromArray:[results objectForKey:@"前端"]];
        }
        
        if ([results.allKeys containsObject:@"拓展资源"]) {
            [contentArray addObjectsFromArray:[results objectForKey:@"拓展资源"]];
        }
        
        if ([results.allKeys containsObject:@"瞎推荐"]) {
            [contentArray addObjectsFromArray:[results objectForKey:@"瞎推荐"]];
        }
        
        if ([results.allKeys containsObject:@"App"]) {
            [contentArray addObjectsFromArray:[results objectForKey:@"App"]];
        }
        
        if ([results.allKeys containsObject:@"休息视频"]) {
            [contentArray addObjectsFromArray:[results objectForKey:@"休息视频"]];
        }
        
        if ([results.allKeys containsObject:@"福利"]) {
            
            NSArray * girlImgArray = [results objectForKey:@"福利"];
            self.girlURL = [girlImgArray[0] objectForKey:@"url"];
        }
        
        self.data = [GKTodayModel mj_objectArrayWithKeyValuesArray:contentArray];
        [self.table reloadData];
    }];
}

#pragma mark tableView相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}

static NSString * headerViewStr = @"headerView";
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    GKTodayHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewStr];
    if (headerView == nil) {
        headerView = [(GKTodayHeaderView *)[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerViewStr];
    }
    
    [headerView.girlImageView setImageWithURL:self.girlURL placeholderImage:nil];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001f;
}

static NSString * cellStr = @"cell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GKTodayCell * cell = [tableView dequeueReusableCellWithIdentifier:cellStr forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = (GKTodayCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    
    GKTodayModel * model = [self.data objectAtIndex:indexPath.row];
    
    [cell setModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GKTodayModel * model = [self.data objectAtIndex:indexPath.row];
    
    GKWebViewVC * vc = [[GKWebViewVC alloc] init];
    vc.url = model.url;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 懒加载
- (NSMutableArray *)data {
    
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    
    return _data;
}


@end

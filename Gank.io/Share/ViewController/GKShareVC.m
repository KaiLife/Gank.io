//
//  GKShareVC.m
//  Gank.io
//
//  Created by 王权伟 on 2018/2/26.
//  Copyright © 2018年 王权伟. All rights reserved.
//

#import "GKShareVC.h"
#import "GKShareCell.h"

@interface GKShareVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(strong, nonatomic) UICollectionView * coll;
@property(strong, nonatomic) NSArray * data;
@property(strong, nonatomic) UIView * backgroundView;
@property(strong, nonatomic) UIView * bottomView;
@property(strong, nonatomic) UIButton * cancelBtn;
@end

@implementation GKShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI {
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.backgroundView = [[UIView alloc] init];
    self.backgroundView.backgroundColor = [UIColor blackColor];
    self.backgroundView.alpha = 0.7f;
    [self.view addSubview:self.backgroundView];
    
    [self.backgroundView makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.left.equalTo(self.view.safeAreaLayoutGuideLeft).offset(0);
            make.right.equalTo(self.view.safeAreaLayoutGuideRight).offset(0);
            make.bottom.equalTo(self.view.safeAreaLayoutGuideBottom).offset(0);
            make.top.equalTo(self.view.safeAreaLayoutGuideTop).offset(0);
        } else {
            // Fallback on earlier versions
            make.top.left.bottom.right.equalTo(self.view);
        }
        
    }];
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.bottomView];
    
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.left.equalTo(self.view.safeAreaLayoutGuideLeft).offset(0);
            make.right.equalTo(self.view.safeAreaLayoutGuideRight).offset(0);
            make.bottom.equalTo(self.view.safeAreaLayoutGuideBottom).offset(200);
            make.height.equalTo(200);
        } else {
            // Fallback on earlier versions
            make.left.right.equalTo(self.view);
            make.height.equalTo(200);
            make.bottom.equalTo(self.view).offset(200);
        }
        
    }];
    
    self.cancelBtn = [[UIButton alloc] init];
    self.cancelBtn.backgroundColor = [UIColor whiteColor];
    [self.cancelBtn setTitleColor:RGB_HEX(0x2F2F2F) forState:UIControlStateNormal];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.bottomView addSubview:self.cancelBtn];
    
    [self.cancelBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.bottomView).offset(0);
        make.right.equalTo(self.bottomView).offset(0);
        make.bottom.equalTo(self.bottomView).offset(0);
        make.height.equalTo(44);
        
    }];
    
    @weakObj(self)
    [self.cancelBtn bk_whenTapped:^{
        @strongObj(self)
        
        [self hidden];
    }];
    
    //coll
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.coll = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.coll.backgroundColor = [UIColor whiteColor];
    self.coll.delegate = self;
    self.coll.dataSource = self;
    [self.coll registerClass:[GKShareCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.coll];
    
    [self.coll makeConstraints:^(MASConstraintMaker *make) {
 
        make.top.left.right.equalTo(self.bottomView);
        make.bottom.equalTo(self.cancelBtn.top).offset(-1);
    }];
    
}

#pragma mark collectionView相关
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

static NSString * cellStr = @"cell";
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GKShareCell * cell = (GKShareCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellStr forIndexPath:indexPath];
    
    NSDictionary * dic = [self.data safeObjectAtIndex:indexPath.row];
    
    //图标
    cell.iconImageView.image = [UIImage imageNamed:dic[@"icon"]];
    
    //标题
    cell.titleLabel.text = dic[@"title"];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((kSCREENWIDTH-60)/5, 135);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
    }
    else if (indexPath.row == 2) {
        
    }
    else if (indexPath.row == 3) {
        
    }
    else if (indexPath.row == 4) {
        
    }
    else if (indexPath.row == 5) {
        
    }
    
//    [Trochilus share:(TPlatformType) parameters:<#(NSMutableDictionary *)#> onStateChanged:^(TResponseState state, NSDictionary *userData, NSError *error) {
//
//    }];
}

#pragma mark 动画
- (void)show {
    
    [self.bottomView updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
    }];
    
    [UIView animateWithDuration:0.25f animations:^{
        
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hidden {
    
    [self.bottomView updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(200);
    }];
    
    [UIView animateWithDuration:0.25f animations:^{
        
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self hidden];
}

#pragma mark 懒加载
- (NSArray *)data {
    if (_data == nil) {
        _data = [NSArray arrayWithObjects:@{
                                            @"icon":@"qq_icon",
                                            @"title":@"QQ"
                                            },
                                            @{
                                              @"icon":@"qzone_icon",
                                              @"title":@"Qzone"
                                            },
                                            @{
                                              @"icon":@"wechat_icon",
                                              @"title":@"微信"
                                            },
                                            @{
                                              @"icon":@"wechat_friend_icon",
                                              @"title":@"朋友圈"
                                            },
                                            @{
                                              @"icon":@"weibo_icon",
                                              @"title":@"微博"
                                            }, nil];
    }
    
    return _data;
}

@end

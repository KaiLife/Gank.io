//
//  GKHistoryCell.h
//  Gank.io
//
//  Created by 王权伟 on 2018/2/10.
//  Copyright © 2018年 王权伟. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GKHistoryModel;

@interface GKHistoryCell : UITableViewCell

@property(strong, nonatomic)UIButton * moreBtn;//更多按钮

- (void)setModel:(GKHistoryModel *)model;

@end

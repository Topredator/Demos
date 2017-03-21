//
//  XL_HeaderView.h
//  Myself_Demo
//
//  Created by 商帮 on 18/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderViewDelegate <NSObject>

@optional
- (void)clickHeaderView;
@end

@class XL_GroupFriend;
@interface XL_HeaderView : UITableViewHeaderFooterView
@property (nonatomic, assign) id<HeaderViewDelegate>delegate;
@property (nonatomic, strong) XL_GroupFriend *groupModel;

+ (instancetype)headerView:(UITableView *)tableView;
@end

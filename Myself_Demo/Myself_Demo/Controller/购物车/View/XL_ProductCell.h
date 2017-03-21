//
//  XL_ProductCell.h
//  Myself_Demo
//
//  Created by 商帮 on 21/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XL_ProductCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *selectionBtn;
@property (strong, nonatomic) IBOutlet UIImageView *productImage;
@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UILabel *productPrice;

@end

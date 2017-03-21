//
//  XL_ScanCell.h
//  Myself_Demo
//
//  Created by 商帮 on 16/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XL_ScanCell : UITableViewCell
{
    IBOutlet UIView *_bigView;
    IBOutlet UIImageView *_headerImage;
    IBOutlet UILabel *name;
    
    IBOutlet UILabel *status;
    
    IBOutlet UILabel *_contentLabel;
    
    IBOutlet UIView *_picView;
    
    IBOutlet UILabel *_time;
    
    //  图片数组
    NSArray *_picsArr;
    
    UIView *_bgView;
    UIScrollView *_imageScroll;
}
@property (nonatomic, weak) id delegate;

- (void)customWithCell:(NSDictionary *)dict delegate:(id)delegate;

@end

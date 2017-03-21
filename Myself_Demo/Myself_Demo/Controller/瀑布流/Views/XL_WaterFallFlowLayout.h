//
//  XL_WaterFallFlowLayout.h
//  Myself_Demo
//
//  Created by 商帮 on 12/5/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XL_WaterFallFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) id<UICollectionViewDelegateFlowLayout>delegate;
//  cell的个数
@property (nonatomic, assign) NSInteger cellCount;
//  存放列的高度
@property (nonatomic, strong) NSMutableArray *colArr;
//  cell的位置信息
@property (nonatomic, strong) NSMutableDictionary *attributeDict;
@end

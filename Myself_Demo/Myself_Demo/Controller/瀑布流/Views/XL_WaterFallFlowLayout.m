//
//  XL_WaterFallFlowLayout.m
//  Myself_Demo
//
//  Created by 商帮 on 12/5/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_WaterFallFlowLayout.h"
CGFloat const colCount = 3;
@implementation XL_WaterFallFlowLayout
//  准备布局
- (void)prepareLayout{
    [super prepareLayout];
    _colArr = [NSMutableArray array];
    _attributeDict = [NSMutableDictionary dictionary];
    self.delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    _cellCount = [self.collectionView numberOfItemsInSection:0];
    if (_cellCount == 0) {
        return;
    }
    //  定义高度
    CGFloat top = 0;
    for (int i = 0; i < colCount; i++) {
        [_colArr addObject:[NSNumber numberWithFloat:top]];
    }
    //  cell 布局
    for (int i = 0; i < _cellCount; i++) {
        [self layoutItemWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
    }
}
//  cell 布局
- (void)layoutItemWithIndexPath:(NSIndexPath *)indexPath{
    //  通过协议得到 cell 的间隙
    UIEdgeInsets edgeInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:indexPath.row];
    //  cell 尺寸
    CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    //  获得  最小高度
    int col = 0;
    CGFloat shortHeight = [[_colArr objectAtIndex:col] floatValue];
    for (int i = 0; i < _colArr.count; i++) {
        CGFloat height = [[_colArr objectAtIndex:i] floatValue];
        if (height < shortHeight) {
            //  value
            shortHeight = height;
            //  列
            col = i;
        }
    }
    CGFloat top = [[_colArr objectAtIndex:col] floatValue];
    //  确定cell的frame
    CGRect frame = CGRectMake(edgeInsets.left + col * (edgeInsets.left + itemSize.width), top + edgeInsets.top, itemSize.width, itemSize.height);
    //  更新  列高
    [_colArr replaceObjectAtIndex:col withObject:[NSNumber numberWithFloat:top + edgeInsets.top + itemSize.height]];
    //  每个cell的frame对应的indexPath， 放入字典中
    [_attributeDict setObject:indexPath forKey:NSStringFromCGRect(frame)];
}


//为每个cell布局完毕后，需要实现这个方法， 传入frame，返回的时cell的信息
//传入当前可见cell的rect，视图滑动时调用
- (NSArray *)indexPathsOfItem:(CGRect)rect{
    //遍历布局字典通过CGRectIntersectsRect方法确定每个cell的rect与传入的rect是否有交集，如果结果为true，则此cell应该显示，将布局字典中对应的indexPath加入数组
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *rectStr in _attributeDict) {
        CGRect cellRect = CGRectFromString(rectStr);
        if (CGRectIntersectsRect(cellRect, rect)) {
            NSIndexPath *indexPath = _attributeDict[rectStr];
            [array addObject:indexPath];
        }
    }
    return array;
}


//返回cell的布局信息，如果忽略传入的rect一次性将所有的cell布局信息返回，图片过多时性能会很差
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *muArr = [NSMutableArray array];
    //indexPathsOfItem方法，根据传入的frame值计算当前应该显示的cell
    NSArray *indexPaths = [self indexPathsOfItem:rect];
    for (NSIndexPath *indexPath in indexPaths) {
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [muArr addObject:attribute];
    }
    return muArr;
}
//最后还要实现这个方法，返回collectionView内容的大小
//只需要遍历前面创建的存放列高的数组得到列最高的一个作为高度返回就可以了
- (CGSize)collectionViewContentSize{
    CGSize size = self.collectionView.frame.size;
    float maxHeight = [[_colArr objectAtIndex:0] floatValue];
    //查找最高的列的高度
    for (int i = 0; i < _colArr.count; i++) {
        float colHeight = [[_colArr objectAtIndex:i] floatValue];
        if (colHeight > maxHeight) {
            maxHeight = colHeight;
        }
    }
    size.height = maxHeight;
    return size;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    for (NSString *rectStr in _attributeDict) {
        if (_attributeDict[rectStr]==indexPath) {
            attributes.frame = CGRectFromString(rectStr);
        }
    }
    return attributes;
}

@end

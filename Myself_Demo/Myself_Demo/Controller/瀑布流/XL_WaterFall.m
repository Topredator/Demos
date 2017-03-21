//
//  XL_WaterFall.m
//  Myself_Demo
//
//  Created by 商帮 on 12/5/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_WaterFall.h"
#import "Public_Class.h"

#import "XL_WaterFallFlowLayout.h"
#import "XL_WaterFallCell.h"

#define KImgCount 17

@interface XL_WaterFall ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (nonatomic, strong) NSArray *imgArr;
@end

static NSString *identifier = @"myCollectionCell";

@implementation XL_WaterFall
//  懒加载
- (NSArray *)imgArr{
    if (!_imgArr) {
        NSMutableArray *tempArr = [NSMutableArray array];
        for (int i = 1; i < KImgCount; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"huoying%d.png", i]];
            [tempArr addObject:image];
        }
        _imgArr = tempArr;
    }
    return _imgArr;
}


- (void)loadInitWaterFall{
    self.title = @"瀑布流";
    XL_WaterFallFlowLayout *flowLayout = [[XL_WaterFallFlowLayout alloc] init];
    self.myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenFrame_width, ScreenFrame_height - 64) collectionViewLayout:flowLayout];
    self.myCollectionView.backgroundColor = [UIColor yellowColor];
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    //注册单元格
    [self.myCollectionView registerClass:[XL_WaterFallCell class] forCellWithReuseIdentifier:identifier];
    [self.view addSubview:self.myCollectionView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadInitWaterFall];
}


#pragma mark - collectionview datasource -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imgArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XL_WaterFallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[XL_WaterFallCell alloc] init];
    }
    cell.image = self.imgArr[indexPath.item];
    return cell;
}

//  图片压缩后的高度
- (CGFloat)imgHeight:(CGFloat)imgHeight imgWidth:(CGFloat)imgWidth{
    /*
        高度 / 宽度 = 压缩后的高度 / 压缩后的宽度(100) ;
     */
    CGFloat newHeight = imgHeight / imgWidth * (ScreenFrame_width - 20) / 3;
    return newHeight;
}
#pragma mark - collectionview flowLayout -
//  图片尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    UIImage *img = self.imgArr[indexPath.row];
    CGFloat height = [self imgHeight:img.size.height imgWidth:img.size.width];
    return CGSizeMake((ScreenFrame_width - 20) / 3, height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    UIEdgeInsets edgeInsets = {5, 5, 5, 5};
    return edgeInsets;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

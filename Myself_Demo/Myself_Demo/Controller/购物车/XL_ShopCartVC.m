//
//  XL_ShopCartVC.m
//  Myself_Demo
//
//  Created by 商帮 on 20/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_ShopCartVC.h"
#import "Public_Class.h"
#import "XL_storeCell.h"
#import "XL_ProductCell.h"

@interface XL_ShopCartVC ()<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *_shopTableView;
    //  全选
    IBOutlet UIButton *_allCheckBtn;
    //  总价
    IBOutlet UILabel *_totalLabel;
    //  结算
    IBOutlet UIButton *_settleBtn;
    
    //  分区数组
    NSMutableArray *_sectionDataArr;
    //  存放Y, N
    NSMutableArray *_selectList;
}
@end
@implementation XL_ShopCartVC

- (void)loadInitXL
{
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = RGB(235, 235, 235, 1);
    
    //  合计
    _totalLabel.layer.cornerRadius = 4;
    _totalLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _totalLabel.layer.masksToBounds = YES;
    //  结算按钮
    _settleBtn.layer.cornerRadius = 5;
    _settleBtn.layer.masksToBounds = YES;
    
    
    _sectionDataArr = [NSMutableArray array];
    //  模拟数据
    NSArray *section0 = @[
                          @{@"productImage": @"product1.png",@"productName": @"14秋季新款男士商务休闲鞋透气韩版板鞋英伦时尚运动青春潮流男鞋",@"productPrice": @"88.0"},
                          @{@"productImage": @"product2.png",@"productName": @"阿甘男鞋 秋冬棉鞋 运动休闲 板鞋n字母男士休闲鞋nb韩版潮流鞋子",@"productPrice": @"139.0"},
                          @{@"productImage": @"product3.png",@"productName": @"宝丽爵 瑞士正品真皮带水钻复古 防水酒桶石英表时尚潮流女表手表",@"productPrice": @"198.0"}];
    NSArray *section1 = @[
                          @{@"productImage": @"product2.png",@"productName": @"阿甘男鞋 秋冬棉鞋 运动休闲 板鞋n字母男士休闲鞋nb韩版潮流鞋子",@"productPrice": @"139.0"},
                          @{@"productImage": @"product3.png",@"productName": @"宝丽爵 瑞士正品真皮带水钻复古 防水酒桶石英表时尚潮流女表手表",@"productPrice": @"198.0"}];
    NSArray *section2 = @[
                          @{@"productImage": @"product1.png",@"productName": @"14秋季新款男士商务休闲鞋透气韩版板鞋英伦时尚运动青春潮流男鞋",@"productPrice": @"88.0"},
                          @{@"productImage": @"product3.png",@"productName": @"宝丽爵 瑞士正品真皮带水钻复古 防水酒桶石英表时尚潮流女表手表",@"productPrice": @"198.0"}];
    
    NSArray *array = @[
                     @{@"shopImage": @"shop.png",
                       @"shopName": @"MANGO旗舰店",
                       @"shopList": section0,
                       },
                     @{@"shopImage": @"shop.png",
                       @"shopName": @"摩驰旗舰店",
                       @"shopList": section1,
                       },
                     @{@"shopImage": @"shop.png",
                       @"shopName": @"berliget帝廷专卖",
                       @"shopList": section2,
                       }];
    for (NSDictionary *dict in array) {
        [_sectionDataArr addObject:dict];
    }
    
    //  每个分区是个数组，存放字典（包含isCheck）
    _selectList = [NSMutableArray array];
    for (int i = 0; i < _sectionDataArr.count; i++) {
        NSArray *shopList = _sectionDataArr[i][@"shopList"];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (int j = 0; j < shopList.count + 1; j++) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:@"N" forKey:@"isCheck"];
            [tempArr addObject:dic];
        }
        [_selectList addObject:tempArr];
    }
    
    NSInteger totalCount = 0;
    for (NSDictionary *item in _sectionDataArr) {
        NSArray *shopList = item[@"shopList"];
        totalCount += shopList.count;
    }
    self.navigationItem.title = [NSString stringWithFormat:@"购物车(%ld)", totalCount];
    
    //  全选按钮添加点击事件
    [_allCheckBtn addTarget:self action:@selector(allCheck:) forControlEvents:UIControlEventTouchUpInside];
}

// 点击section第一行
- (void)clickFirstAction:(UIButton *)btn
{
    NSInteger section = btn.tag / 1000;
    btn.selected = !btn.selected;
    NSMutableArray *currentSection = _selectList[section];
    for (NSMutableDictionary *dict in currentSection) {
        [dict setObject:btn.selected ? @"Y" : @"N" forKey:@"isCheck"];
    }
    [_shopTableView reloadData];
    //  计算总价
    [self setTotalPrice];
    //  检测全选是否勾上
    [self checkAllSelected];
}
//  点击商品那行的按钮
- (void)clickProductRowAction:(UIButton *)btn
{
    NSInteger section = btn.tag / 1000;
    NSInteger row = btn.tag % 100;
    btn.selected = !btn.selected;
    
    NSMutableArray *currentSection = _selectList[section];
    for (int i = 0; i < currentSection.count; i++) {
        if (i == row) {
            NSMutableDictionary *dict = currentSection[i];
            [dict setObject:btn.selected ? @"Y" : @"N" forKey:@"isCheck"];
            break;
        }
    }
    //  检测当前section是否全选
    NSMutableDictionary *data = _selectList[section][0];
    [data setObject:[self checkSectionAllCheck:_selectList[section]] ? @"Y" : @"N" forKey:@"isCheck"];
    
    [_shopTableView reloadData];
    //  总价
    [self setTotalPrice];
    //  全选按钮是否勾上
    [self checkAllSelected];
}

//  得到每个section最后一行的string
- (NSString *)getString:(NSArray *)arr
{
    CGFloat totalPrice = 0;
    for (NSDictionary *dict in arr) {
        totalPrice += [dict[@"productPrice"] floatValue];
    }
    return [NSString stringWithFormat:@"共%ld件商品, 合计:¥%@", arr.count, [NSString stringWithFormat:@"%.2f", totalPrice]];
}


//  检测每个section是否全选
- (BOOL)checkSectionAllCheck:(NSMutableArray *)list
{
    bool flag = true;
    for (int i = 1; i < list.count; i++) {
        NSMutableDictionary *dict = list[i];
        if (![dict[@"isCheck"] boolValue]) {
            flag = false;
            break;
        }
    }
    return flag;
}

#pragma mark - 实时计算总价 -
- (void)setTotalPrice
{
    //  商品数
    NSInteger productNum = 0;
    //  商品总价
    CGFloat totalPrice = 0;
    for (int section = 0; section < _selectList.count; section++) {
        NSMutableArray *sectionArr = _selectList[section];
        for (int row = 1; row < sectionArr.count; row++) {
            NSMutableDictionary *dict = sectionArr[row];
            if ([dict[@"isCheck"] boolValue]) {
                //  如果选中商品数++
                productNum ++;
                //  取选中的价格
                totalPrice += [_sectionDataArr[section][@"shopList"][row - 1][@"productPrice"] floatValue];
            }
        }
    }
    _totalLabel.text = [NSString stringWithFormat:@"合计:¥%.2f", totalPrice];
    [_settleBtn setTitle:[NSString stringWithFormat:@"结算(%ld)", productNum] forState:UIControlStateNormal];
}
#pragma mark - 检验全选按钮是否选中 -
- (void)checkAllSelected
{
    bool allCheck = true;
    for (NSMutableArray *tempArr in _selectList) {
        NSMutableDictionary *dict = tempArr[0];
        if (![dict[@"isCheck"] boolValue]) {
            allCheck = false;
            break;
        }
    }
    _allCheckBtn.selected = allCheck;
}

#pragma mark - 全选 -
- (void)allCheck:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        NSInteger productNum = 0;
        CGFloat totalPrice = 0;
        for (NSDictionary *dict in _sectionDataArr) {
            NSArray *shopList = dict[@"shopList"];
            productNum += shopList.count;
            for (NSDictionary *data in shopList) {
                totalPrice += [data[@"productPrice"] floatValue];
            }
        }
        _totalLabel.text = [NSString stringWithFormat:@"合计:¥%.2f", totalPrice];
        [_settleBtn setTitle:[NSString stringWithFormat:@"结算(%ld)",productNum] forState:UIControlStateNormal];
        
        //  让所有的选中
        for (NSMutableArray *tempArr in _selectList) {
            for (NSMutableDictionary *tempDic in tempArr) {
                [tempDic setObject:@"Y" forKey:@"isCheck"];
            }
        }
    } else {
        _totalLabel.text = @"合计:¥0.00";
        [_settleBtn setTitle:@"结算(0)" forState:UIControlStateNormal];
        
        //  让所有数据不选中
        for (NSMutableArray *tempArr in _selectList) {
            for (NSMutableDictionary *tempDic in tempArr) {
                [tempDic setObject:@"N" forKey:@"isCheck"];
            }
        }
    }
    [_shopTableView reloadData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadInitXL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - datasource -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sectionDataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *shopList = _sectionDataArr[section][@"shopList"];
    return shopList.count + 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *shopList = _sectionDataArr[indexPath.section][@"shopList"];
    if (indexPath.row == 0 || indexPath.row == shopList.count + 1) {
        static NSString *identifier = @"storeCell";
        XL_storeCell *cell = (XL_storeCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (nil == cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"XL_storeCell" owner:self options:nil][0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //  第一个与最后一个cell 重用
        cell.checkBtn.hidden = YES;
        cell.storeImage.hidden = YES;
        if (indexPath.row == 0) {
            cell.checkBtn.hidden = NO;
            cell.storeImage.hidden = NO;
            cell.checkBtn.tag = indexPath.section * 1000 + indexPath.row;
            [cell.checkBtn addTarget:self action:@selector(clickFirstAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.storeImage.image = [UIImage imageNamed:_sectionDataArr[indexPath.section][@"shopImage"]];
            cell.storeName.text = _sectionDataArr[indexPath.section][@"shopName"];
            cell.checkBtn.selected = [_selectList[indexPath.section][0][@"isCheck"] boolValue];
        } else {
            cell.storeName.text = [self getString:shopList];
        }
        return cell;
    } else {
        static NSString *identifier = @"productCell";
        XL_ProductCell *cell = (XL_ProductCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (nil == cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"XL_ProductCell" owner:self options:nil][0];
        }
        NSDictionary *productInfo = shopList[indexPath.row - 1];
        cell.productImage.image = [UIImage imageNamed:productInfo[@"productImage"]];
        cell.productName.text = productInfo[@"productName"];
        cell.productPrice.text = [NSString stringWithFormat:@"价格:¥%@", productInfo[@"productPrice"]];
        cell.selectionBtn.tag = indexPath.section * 1000 + indexPath.row;
        [cell.selectionBtn addTarget:self action:@selector(clickProductRowAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionBtn.selected = [_selectList[indexPath.section][indexPath.row][@"isCheck"] boolValue];
        return cell;
    }
}
#pragma mark - delegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *shopList = _sectionDataArr[indexPath.section][@"shopList"];
    if (indexPath.row == 0 || indexPath.row == shopList.count + 1) {
        return 40;
    }
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenFrame_width, 10)];
    head.backgroundColor = RGB(235, 235, 235, 1);
    return head;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 1.f;
    }
    return 10.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenFrame_width, 1)];
    foot.backgroundColor = RGB(235, 235, 235, 1);
    return foot;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *shopList = _sectionDataArr[indexPath.section][@"shopList"];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        NSLog(@"查看商铺信息");
    } else if (indexPath.row == shopList.count + 1) {
        return;
    } else {
        NSLog(@"查看商品信息");
    }
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

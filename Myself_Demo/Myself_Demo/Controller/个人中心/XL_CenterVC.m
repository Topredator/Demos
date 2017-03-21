//
//  XL_CenterVC.m
//  Myself_Demo
//
//  Created by 商帮 on 21/4/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "XL_CenterVC.h"

#import "XL_ShareHandle.h"
#import "Public_Class.h"

#import "XL_LoginVC.h"

#define KPersonInfoImage_height  144


@interface XL_CenterVC ()<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *_myCenterTableView;
    UIImageView *_personInfoImage;
    
    //  没登录时
    UIButton *_loginBtn;
    UILabel *_infoLabel;
    //  登录时
    UIImageView *_headerImage;
    UILabel *_nameLabel;
    
    NSArray *_centerDataArr;
    NSString *_nameStr;
}
@end

@implementation XL_CenterVC

//  tableview headerView
- (void)setHeaderView:(UITableView *)tableView
{
    _personInfoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenFrame_width, KPersonInfoImage_height)];
    _personInfoImage.userInteractionEnabled = YES;
    _personInfoImage.image = [UIImage imageNamed:@"myshop_prosonbottom"];
    _myCenterTableView.tableHeaderView = _personInfoImage;
}
- (void)loadInitXL
{
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = RGB(235, 235, 235, 1);
    self.title = @"个人中心";
    [self setHeaderView:_myCenterTableView];
    
    //  创建信息栏
    [self createWithPersonInfoView];
}


//  个人信息
- (void)createWithPersonInfoView
{
    for (UIView *view in _personInfoImage.subviews) {
        [view removeFromSuperview];
    }
    if ([XL_ShareHandle shareHandle].isLogin) {
        _headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenFrame_width / 2 - 25, 32, 50, 50)];
        _headerImage.layer.cornerRadius = _headerImage.frame.size.width / 2;
        _headerImage.backgroundColor = [UIColor purpleColor];
        _headerImage.layer.masksToBounds = YES;
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenFrame_width / 2 - 50, 92, 100, 30)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = KFont(13);
        _nameLabel.text = _nameStr;
        //  添加到_personImage上
        [_personInfoImage addSubview:_headerImage];
        [_personInfoImage addSubview:_nameLabel];
    } else {
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenFrame_width / 2 - 80, 36, 160, 30)];
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.font = KFont(14);
        _infoLabel.textColor = [UIColor whiteColor];
        _infoLabel.text = @"欢迎来到ipoplarec商城";
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:[NSString stringWithFormat:@"登录/注册"] forState:UIControlStateNormal];
        _loginBtn.frame = CGRectMake(ScreenFrame_width / 2 - 40, 76, 80, 30);
        _loginBtn.titleLabel.font = KFont(13);
        _loginBtn.backgroundColor = [UIColor purpleColor];
        _loginBtn.layer.cornerRadius = 5.f;
        _loginBtn.layer.masksToBounds = YES;
        [_loginBtn addTarget:self action:@selector(goLoginVC) forControlEvents:UIControlEventTouchUpInside];
        [_personInfoImage addSubview:_infoLabel];
        [_personInfoImage addSubview:_loginBtn];
    }
}

- (void)getName:(ReturnBlcok)returnBlock
{
    XL_LoginVC *loginVC = [[XL_LoginVC alloc] init];
    loginVC.returnBlock = returnBlock;
    [self.navigationController pushViewController:loginVC animated:YES];
}
//  去登陆
- (void)goLoginVC
{
//    __block UILabel *lb = _nameLabel;
    [self getName:^(NSString *str) {
        if (str != nil && str.length) {
//            lb.text = str;
            _nameStr = str;
        }
    }];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _centerDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"centerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.imageView.image = [UIImage imageNamed:_centerDataArr[indexPath.row][@"image"]];
    cell.textLabel.text = _centerDataArr[indexPath.row][@"name"];
    return cell;
}
#pragma mark - delegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([XL_ShareHandle shareHandle].isLogin) {
        if (indexPath.row == _centerDataArr.count - 1) {
            [XL_ShareHandle shareHandle].isLogin = NO;
            [self setArray:[XL_ShareHandle shareHandle].isLogin];
            [self createWithPersonInfoView];
        }
    }
    return;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setArray:(BOOL)flag
{
    if (flag) {
        _centerDataArr = @[@{@"image":@"myshop_myorder.png", @"name":@"我的订单"},
                                        @{@"image":@"myshop_addmanage.png", @"name":@"地址管理"},
                                        @{@"image":@"myshop_clearhistory.png", @"name":@"清除浏览记录"},
                                        @{@"image":@"myshop_clearpicture.png", @"name":@"清除缓存"},
                                        @{@"image":@"myshop_helponline.png", @"name":@"在线帮助"},
                                        @{@"image":@"myshop_about.png", @"name":@"关于我们"},
                                        @{@"image":@"myshop_updata.png", @"name":@"版本更新(version:1.0)"},
                                        @{@"image":@"myshop_outlogin.png", @"name":@"退出登录"}];
    } else {
        _centerDataArr = @[@{@"image":@"myshop_myorder.png", @"name":@"我的订单"},
                           @{@"image":@"myshop_addmanage.png", @"name":@"地址管理"},
                           @{@"image":@"myshop_clearhistory.png", @"name":@"清除浏览记录"},
                           @{@"image":@"myshop_clearpicture.png", @"name":@"清除缓存"},
                           @{@"image":@"myshop_helponline.png", @"name":@"在线帮助"},
                           @{@"image":@"myshop_about.png", @"name":@"关于我们"},
                           @{@"image":@"myshop_updata.png", @"name":@"版本更新(version:1.0)"}];
    }
    [_myCenterTableView reloadData];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setArray:[XL_ShareHandle shareHandle].isLogin];
    [self createWithPersonInfoView];
}
@end

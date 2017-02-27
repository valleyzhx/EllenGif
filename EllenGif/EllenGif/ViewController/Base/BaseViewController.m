//
//  BaseViewController.m
//  MyDota
//
//  Created by Xiang on 15/8/6.
//  Copyright (c) 2015年 iGG. All rights reserved.
//

#import "BaseViewController.h"
#import "MyDefines.h"


#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

@interface BaseViewController ()

@end

@implementation BaseViewController{
    BOOL isLoading;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = viewBGColor;
    if (_noTable == NO) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        self.tableView.separatorColor = viewBGColor;
        self.tableView.backgroundColor = viewBGColor;
        self.tableView.showsVerticalScrollIndicator = NO;
        [self.tableView setHiddenExtrLine:YES];
        
        [self.view addSubview:_tableView];
    }
    _naviBar = [self setUpNaviViewWithType:GGNavigationBarTypeNormal];
    _naviBar.title = @"EllenGIF";
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(GGNavigationBar *)setUpNaviViewWithType:(GGNavigationBarType)type{
    
    if (type == GGNavigationBarTypeNone) {
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        return nil;
    }
    
    if (_naviBar) {
        [_naviBar removeFromSuperview];
        _naviBar = nil;
    }
    GGNavigationBar *view = [[GGNavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    view.title = self.title;
    view.backgroundView.backgroundColor = Nav_Color;
    view.backgroundView.alpha = 1;
    
    if (type == GGNavigationBarTypeNormal) {
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        [backBtn setImage:[UIImage imageNamed:@"backIcon"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(clickedBackAction:) forControlEvents:UIControlEventTouchUpInside];
        view.leftView = backBtn;
    }
    [self.view addSubview:view];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.right.equalTo(self.view);
        make.top.equalTo(view.mas_bottom);
    }];
    return view;
}

-(void)setNaviType:(GGNavigationBarType)naviType{
    
    _naviBar = [self setUpNaviViewWithType:naviType];
    
}

-(void)clickedBackAction:(UIButton*)btn{
    [self.navigationController popViewControllerAnimated:YES];
}




-(void)setTitle:(NSString *)title{
    [super setTitle:title];
    _naviBar.title = title;
}

-(void)showHudView{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.view bringSubviewToFront:_naviBar];
}

-(void)hideHudView{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)showMessage:(NSString *)message{
    [MBProgressHUD showString:message inView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 10)];
    view.backgroundColor = viewBGColor;
    return view;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.textLabel.textColor = TextDarkColor;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.numberOfLines = 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)dealloc{
    _tableView = nil;
}

@end

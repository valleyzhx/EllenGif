//
//  VideoListController.m
//  MyDota
//
//  Created by Xiang on 15/10/18.
//  Copyright © 2015年 iOGG. All rights reserved.
//

#import "VideoListController.h"
#import "MyDefines.h"
#import "VideoListModel.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "SearchViewController.h"


@implementation VideoListController{
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNaviType:GGNavigationBarTypeCustom];
    _naviBar.title = @"搞笑视频";
    currentPage = 1;
    [self loadVideoList:currentPage];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadTheDataAction)];
    [self setSearchButton];
}
-(void)setSearchButton{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn setImage:[UIImage imageNamed:@"searchBarBtn"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    _naviBar.rightView = btn;
    btn.center = CGPointMake(btn.center.x-10, btn.center.y);
}

-(void)reloadTheDataAction{
    currentPage = 1;
    [self.listArr removeAllObjects];
    [self loadVideoList:currentPage];
}

-(void)loadMoreData{
    currentPage++;
    [self loadVideoList:currentPage];
}

-(void)loadVideoList:(int)page{
    
    NSString *url = [NSString stringWithFormat:@"https://openapi.youku.com/v2/searches/video/by_tag.json?client_id=e2306ead120d2e34&tag=综艺&orderby=published&count=10&page=%d",currentPage];
    [self showHudView];
    
    [VideoListModel getVideoListBy:url complish:^(id objc) {
        [self hideHudView];
        VideoListModel *model = objc;
        if (model.videos) {
            [self.listArr addObjectsFromArray:model.videos];
            total = model.total;
            [self.tableView reloadData];
        }
        if (total==self.listArr.count) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    }];
    
}

#pragma mark Search Action
-(void)searchAction:(UIButton*)btn{
    SearchViewController *serchVC = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:serchVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
}


@end

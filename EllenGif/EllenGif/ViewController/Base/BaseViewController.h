//
//  BaseViewController.h
//  MyDota
//
//  Created by Xiang on 15/8/6.
//  Copyright (c) 2015年 iGG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GGNavigationBar.h"
#import "MJRefresh.h"
#import <UMMobClick/MobClick.h>
#import "MBProgressHUD+string.h"

#define orgX 16

@interface BaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    int currentPage;
    int total;
    GGNavigationBar *_naviBar;
    
}

@property (nonatomic,assign) BOOL noTable;
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,assign) BOOL showGDTADView;

@property (nonatomic,assign) GGNavigationBarType naviType;


-(void)showHudView;
-(void)hideHudView;

@end

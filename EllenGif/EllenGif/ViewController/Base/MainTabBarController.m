//
//  MainTabBarController.m
//  MyDota
//
//  Created by Xiang on 15/8/5.
//  Copyright (c) 2015年 iGG. All rights reserved.
//

#import "MainTabBarController.h"
#import "MyDefines.h"

@interface MainTabBarController () 

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAppearanceUI];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    UITabBarItem *tabBarHome = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarVideo = [self.tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarUser = [self.tabBar.items objectAtIndex:2];

    
    tabBarHome.selectedImage = [[UIImage imageNamed:@"home_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarHome.image = [[UIImage imageNamed:@"home_unselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [tabBarHome setTitle:@"首页"];
    tabBarHome.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    tabBarHome.titlePositionAdjustment = UIOffsetMake(0, -2);
    
    tabBarVideo.selectedImage = [[UIImage imageNamed:@"live_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarVideo.image = [[UIImage imageNamed:@"live_unselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [tabBarVideo setTitle:@"视频"];
    
    tabBarUser.selectedImage = [[UIImage imageNamed:@"profile_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarUser.image = [[UIImage imageNamed:@"profile_unselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [tabBarUser setTitle:@"我的"];
    tabBarUser.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    tabBarUser.titlePositionAdjustment = UIOffsetMake(0, -2);
}

-(void)setAppearanceUI{
    [[UITabBar appearance] setTintColor:RGBA_COLOR(17,73,156,1)];
    [self setNeedsStatusBarAppearanceUpdate];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

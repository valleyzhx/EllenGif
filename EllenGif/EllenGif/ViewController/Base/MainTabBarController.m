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
    UITabBarItem *tabBarItem0 = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [self.tabBar.items objectAtIndex:1];

    
    tabBarItem0.selectedImage = [[UIImage imageNamed:@"home_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem0.image = [[UIImage imageNamed:@"home_unselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [tabBarItem0 setTitle:@"首页"];
    tabBarItem0.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    tabBarItem0.titlePositionAdjustment = UIOffsetMake(0, -2);
    
    
    
    tabBarItem2.selectedImage = [[UIImage imageNamed:@"profile_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem2.image = [[UIImage imageNamed:@"profile_unselected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [tabBarItem2 setTitle:@"我的"];
    tabBarItem2.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    tabBarItem2.titlePositionAdjustment = UIOffsetMake(0, -2);
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
//
//  FavorViewController.m
//  EllenGif
//
//  Created by Xiang on 16/12/16.
//  Copyright © 2016年 idreams.club. All rights reserved.
//

#import "FavorViewController.h"

@interface FavorViewController ()

@end

@implementation FavorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNaviType:GGNavigationBarTypeNormal];
    _naviBar.rightView.hidden = YES;
    _field.hidden = YES;
    _naviBar.title = @"我的收藏";
    [_collectionView.mj_footer removeFromSuperview];
    [_collectionView.mj_header removeFromSuperview];
}

-(void)requestData{
    
     _dataArr = [[[NSUserDefaults standardUserDefaults]arrayForKey:kFavorite]mutableCopy];
    [_collectionView reloadData];
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

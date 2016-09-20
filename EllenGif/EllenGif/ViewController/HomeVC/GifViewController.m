//
//  GifViewController.m
//  EllenGif
//
//  Created by Xiang on 16/9/20.
//  Copyright © 2016年 idreams.club. All rights reserved.
//

#import "GifViewController.h"

@interface GifViewController (){
    UIImageView *_imageView;
}

@end

@implementation GifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    float wid = 120*timesOf320;
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, wid, wid)];
    
    _imageView.center = self.view.center;
    [self.view addSubview:_imageView];
    
    [self setShowPage:_currentPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setShowPage:(NSInteger)page{
    _currentPage = page;
    if (page < _dataArr.count) {
        NSDictionary *dic = _dataArr[page];
        NSString *url = dic[@"thumb"];
        [_imageView yy_setImageWithURL:[NSURL URLWithString:url] placeholder:nil options:YYWebImageOptionProgressive|YYWebImageOptionRefreshImageCache completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            if (stage == YYWebImageStageFinished) {
                
            }
        }];
    }
    
}

@end

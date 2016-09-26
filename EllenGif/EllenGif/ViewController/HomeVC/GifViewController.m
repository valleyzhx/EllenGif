//
//  GifViewController.m
//  EllenGif
//
//  Created by Xiang on 16/9/20.
//  Copyright © 2016年 idreams.club. All rights reserved.
//

#import "GifViewController.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"

@interface GifViewController (){
    YYAnimatedImageView *_imageView;
    GADBannerView *_adView;
}
@end


@implementation GifViewController
@synthesize currentPage = _currentPage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    float wid = 200*timesOf320;
    _imageView = [[YYAnimatedImageView alloc]initWithFrame:CGRectMake(0, 0, wid, wid)];
    
    _imageView.center = CGPointMake(self.view.center.x, self.view.center.y-70);
    [self.view addSubview:_imageView];
    
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 46, 46)];
    [shareBtn setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(clickTheShareButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_imageView.mas_bottom).offset(20);
        make.width.height.mas_equalTo(46);
        make.centerX.equalTo(_imageView);
        
    }];
    
    [self setShowPage:_currentPage];
    [self loadAdView];
}

-(void)setShowPage:(NSInteger)page{
    [self showHudView];
    _currentPage = page;
    if (page < _dataArr.count) {
        NSDictionary *dic = _dataArr[page];
        NSString *url = dic[@"_thumb"];
        [_imageView yy_setImageWithURL:[NSURL URLWithString:url] placeholder:nil options:YYWebImageOptionProgressive|YYWebImageOptionAllowBackgroundTask|YYWebImageOptionShowNetworkActivity completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            if (stage != YYWebImageStageProgress || error
                ) {
                [self hideHudView];
            }
        }];
        
    }
}



-(void)loadAdView{
    _adView = [[GADBannerView alloc]
               initWithFrame:CGRectMake((SCREEN_WIDTH-320)/2,_imageView.bottom+100,320,100)];
    _adView.adUnitID = @"ca-app-pub-7534063156170955/9242353223";
    
    _adView.rootViewController = self;
    
    [self.view addSubview:_adView];
    GADRequest *req = [GADRequest request];
#if DEBUG
    req.testDevices = @[@"5610fbd8aa463fcd021f9f235d9f6ba1"];
#endif
    [_adView loadRequest:req];
}



#pragma mark- action

-(void)clickTheShareButton:(UIButton*)btn{
    NSDictionary *dic = _dataArr[_currentPage];
    NSString *url = dic[@"_thumb"];
    YYImageCache *cache = [YYImageCache sharedCache];
    YYImage *thumbImage = (YYImage*)[cache getImageForKey:url];
    
    [WXApiRequestHandler sendEmotionData:thumbImage.animatedImageData
                              ThumbImage:thumbImage
                                 InScene:WXSceneSession];
}


@end

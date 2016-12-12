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
#import <AssetsLibrary/AssetsLibrary.h>

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
    
    
    if (_dataArr) {
        [self setShowPage:_currentPage];
        
        UIButton *saveBtn = [[UIButton alloc]init];
        [saveBtn setImage:[UIImage imageNamed:@"downloadIcon"] forState:UIControlStateNormal];
        [saveBtn addTarget:self action:@selector(clickTheSaveButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:saveBtn];
        [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(42);
            make.centerY.equalTo(shareBtn);
            make.left.equalTo(shareBtn.mas_right).offset(30);
        }];
        [shareBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_imageView).offset(-55);
        }];
        
        
    }else{
        [self loadImageViewWithGifData];
    }
    
    [self loadAdView];
}

-(void)setShowPage:(NSInteger)page{
    [self showHudView];
    _currentPage = page;
    if (page < _dataArr.count) {
        NSDictionary *dic = _dataArr[page];
        NSString *url = dic[@"_thumb"];
        __weak YYAnimatedImageView *imgView = _imageView;
        [_imageView yy_setImageWithURL:[NSURL URLWithString:url] placeholder:nil options:YYWebImageOptionProgressive|YYWebImageOptionAllowBackgroundTask|YYWebImageOptionShowNetworkActivity completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            if (stage != YYWebImageStageProgress || error
                ) {
                [self hideHudView];
                if (image) {
                    float ratio = image.size.height/image.size.width;
                    imgView.height = imgView.width*ratio;
                }
            }
            
        }];
        
    }
}

-(void)loadImageViewWithGifData{
    if (!_gifData) {
        return;
    }
    YYImage *image =  [YYImage imageWithData:_gifData];
    
    float ratio = image.size.height/image.size.width;
    _imageView.height = _imageView.width*ratio;
    
    _imageView.image = image;
}


-(void)loadAdView{
    _adView = [[GADBannerView alloc]
               initWithFrame:CGRectMake((SCREEN_WIDTH-320)/2,self.view.height-120,320,100)];
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
    
    
    YYImage *thumbImage;
    if (_gifData) {
        thumbImage = (YYImage*)_imageView.image;
    }else{
        NSDictionary *dic = _dataArr[_currentPage];
        NSString *url = dic[@"_thumb"];
        YYImageCache *cache = [YYImageCache sharedCache];
        thumbImage = (YYImage*)[cache getImageForKey:url];
    }
    
    if (thumbImage == nil) {
        return;
    }
    
    NSData *data = thumbImage.animatedImageData?:_gifData;
    [WXApiRequestHandler sendEmotionData:data
                              ThumbImage:thumbImage
                                 InScene:WXSceneSession];
}

-(void)clickTheSaveButton:(UIButton*)btn{
    [self showHudView];
    NSDictionary *dic = _dataArr[_currentPage];
    NSString *url = dic[@"_thumb"];
    YYImageCache *cache = [YYImageCache sharedCache];
    YYImage *thumbImage = (YYImage*)[cache getImageForKey:url];
    NSData *data = thumbImage.animatedImageData;

    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library writeImageDataToSavedPhotosAlbum:data metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
        [self hideHudView];
        if (error) {
            [self showMessage:error.localizedDescription];
        }else{
            [self showMessage:@"保存成功"];
        }
    }];
}


@end

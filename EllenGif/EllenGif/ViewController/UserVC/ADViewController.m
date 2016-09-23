//
//  ADViewController.m
//  MyDota
//
//  Created by Xiang on 15/11/14.
//  Copyright © 2015年 iOGG. All rights reserved.
//

#import "ADViewController.h"
#import "MyDefines.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "UIImageView+AFNetworking.h"


@interface ADViewController ()<GADInterstitialDelegate,UIActionSheetDelegate>

@end

@implementation ADViewController{
    GADInterstitial *_interstitial;
    UIImageView *_imgView;
    UILabel *_lab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"每日一句";
    self.view.backgroundColor = viewBGColor;
    _naviBar.backgroundView.alpha = 0;
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*3/5)];
    _imgView.userInteractionEnabled = YES;
    [self.view addSubview:_imgView];
    [self.view bringSubviewToFront:_naviBar];
    
    UILongPressGestureRecognizer *longPressGr = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(panTheImageAction:)];
    [_imgView addGestureRecognizer:longPressGr];
    
    
    _lab = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_imgView.frame)+10, SCREEN_WIDTH-20, 240)];
    _lab.numberOfLines = 0;
    [self.view addSubview:_lab];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTheAction:)];
    [_lab addGestureRecognizer:tap];
    _lab.userInteractionEnabled = YES;
    
    
    [self loadHttpData];
    
    [MobClick event:@"ADViewController"];
}

-(void)loadHttpData{
    
    NSString *url = @"http://open.iciba.com/dsapi/";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSData class]]) {
            
            NSDictionary *dic = [responseObject jsonObject];
            if (dic) {
                NSString *content = dic[@"content"];
                NSString *note = dic[@"note"];
                NSString *dateline = dic[@"dateline"];
                NSString *url = dic[@"picture2"];
                if (note && content) {
                    _lab.text = [NSString stringWithFormat:@"%@\n\n%@\n\n%@",content,note,dateline];
                }
                if (url.length) {
                    [_imgView setImageWithURL:[NSURL URLWithString:url]];
                }
            }
            
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
    
    
}



-(void)tapTheAction:(UITapGestureRecognizer*)tap{
    if (_interstitial) {
        _interstitial.delegate = nil;
        _interstitial = nil;
    }
    _interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-7534063156170955/1007736023"];
    _interstitial.delegate = self;
    GADRequest *request = [GADRequest request];
#if DEBUG
    request.testDevices = @[ @"5610fbd8aa463fcd021f9f235d9f6ba1" ];
#endif
    [_interstitial loadRequest:request];
    [MobClick event:@"GoogleLargeAd"];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UIViewController *)viewControllerForPresentingInterstitialModalView{
    
    return self;
}


-(void)dealloc{
    _interstitial.delegate = nil;
}

#pragma mark ---- Action

-(void)panTheImageAction:(UILongPressGestureRecognizer*)gesture{
    
    UIGestureRecognizerState state = gesture.state;
    if (state == UIGestureRecognizerStateBegan) {
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"保存到相册" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存", nil];
        [sheet showInView:self.view];
    }
    
}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self saveImageToAlbum];
    }
}


- (void)saveImageToAlbum{
    UIImageWriteToSavedPhotosAlbum(_imgView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"呵呵";
    if (!error) {
        message = @"保存成功";
    }else
    {
        message = [error description];
    }
    [MBProgressHUD showString:message inView:self.view];

}

#pragma mark -
#pragma mark AdMoGoDelegate delegate

- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
    [interstitial presentFromRootViewController:self];
}

@end

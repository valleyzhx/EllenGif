//
//  LaunchView.m
//  EllenGif
//
//  Created by Xiang on 16/9/21.
//  Copyright © 2016年 idreams.club. All rights reserved.
//

#import "LaunchView.h"

@implementation LaunchView{
    UIImageView *_imageView;
}
static LaunchView *_launchView;
+(id)defultVIew{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *name = @"LaunchImage";
        if ([[UIScreen mainScreen] bounds].size.height >= 568.0f) {
            name = @"LaunchImage-568h";
        }
        _launchView = [[LaunchView alloc]initWithImage:name];
    });
    return _launchView;
}


-(id)initWithImage:(NSString *)imageName{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)]) {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.image = [UIImage imageNamed:imageName];
        [self addSubview:_imageView];
        
    }
    return self;
}


-(void)showInView:(UIView *)view{
    [view addSubview:self];
    
    [UIView animateWithDuration:2.0 delay:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0;
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end

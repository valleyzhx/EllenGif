//
//  SerchSetingView.m
//  EllenGif
//
//  Created by Xiang on 16/9/22.
//  Copyright © 2016年 idreams.club. All rights reserved.
//

#import "SerchSetingView.h"

@implementation SerchSetingView{
    UILabel *_titleLab;
    UIButton *_checkBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.height = 44;
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, self.height)];
        _titleLab.textColor = TextDarkColor;
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.text = @"设为默认";
        [self addSubview:_titleLab];
        
        _checkBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, self.height)];
        _checkBtn.right = SCREEN_WIDTH-10;
        [_checkBtn setImage:[UIImage imageNamed:@"searchCheck"] forState:UIControlStateSelected];
        [_checkBtn setImage:[UIImage imageNamed:@"searchUncheck"] forState:UIControlStateNormal];
        _checkBtn.selected = YES;
        [self addSubview:_checkBtn];
        [_checkBtn addTarget:self action:@selector(clickTheCheckButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


-(void)showInView:(UIView *)view{
    [view addSubview:self];
    float top = self.top;
    self.top -= self.height;
    [UIView animateWithDuration:0.7 animations:^{
        self.top = top;
    }];
    
}

-(void)hideView{
    [UIView animateWithDuration:0.7 animations:^{
        self.top -= self.height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.top += self.height;
    }];
}





-(void)clickTheCheckButton:(UIButton*)btn{
    btn.selected = !btn.isSelected;
}

-(BOOL)isChecked{
    return _checkBtn.isSelected;
}

@end

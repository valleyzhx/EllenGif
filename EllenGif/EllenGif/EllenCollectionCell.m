//
//  EllenCollectionCell.m
//  EllenGif
//
//  Created by Xiang on 16/8/31.
//  Copyright © 2016年 idreams.club. All rights reserved.
//

#import "EllenCollectionCell.h"

@implementation EllenCollectionCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    _animatedView = [[FLAnimatedImageView alloc] init];
    [self.contentView addSubview:_animatedView];
    [_animatedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}


@end

//
//  GifViewController.h
//  EllenGif
//
//  Created by Xiang on 16/9/20.
//  Copyright © 2016年 idreams.club. All rights reserved.
//

#import "BaseViewController.h"

@interface GifViewController : BaseViewController

@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic,strong) NSData *gifData;

@end

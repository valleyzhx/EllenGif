//
//  ViewController.m
//  EllenGif
//
//  Created by Xiang on 16/8/31.
//  Copyright © 2016年 idreams.club. All rights reserved.
//

#import "ViewController.h"
#import "EllenCollectionCell.h"
#import "SDWebImageDownloader.h"

#import "WXApiRequestHandler.h"
#import "WXApiManager.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate> {
    UITextField *_field;
    UICollectionView *_collectionView;
    NSMutableArray *_dataArr;
    
    UITapGestureRecognizer *_tapGesture;
    
    NSIndexPath *_selectedIndex;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    headView.backgroundColor = Nav_Color;
    [self.view addSubview:headView];
    
    _field = [[UITextField alloc]initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH-60, 27)];
    _field.layer.borderColor = [UIColor whiteColor].CGColor;
    _field.layer.borderWidth = 0.5;
    _field.font = [UIFont systemFontOfSize:12];
    _field.textColor = [UIColor whiteColor];
    _field.text = @" 熊本熊表情包";
    _field.delegate = self;
    [headView addSubview:_field];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-45, 24, 40, 40)];
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [headView addSubview:btn];
    [btn addTarget:self action:@selector(clickTheBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerClass:[EllenCollectionCell class] forCellWithReuseIdentifier:@"EllenCollectionCell"];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64+5);
        make.left.bottom.right.equalTo(self.view);
    }];
    _dataArr = [NSMutableArray array];
    [self requestData];
    __weak typeof(self) weakSelf = self;
    _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
    
    _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTheScreen:)];
    [_collectionView addGestureRecognizer:_tapGesture];
    _tapGesture.enabled = NO;
    
    
}

-(void)requestData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    int count = 30+(int)_dataArr.count;
    NSString *url = [NSString stringWithFormat:@"http://images.so.com/j?src=filter_noresult&q=%@&t=d&sn=%d&pn=30&zoom=3",_field.text,count];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *list = responseObject[@"list"];
        if (list) {
            [_dataArr addObjectsFromArray:list];
        }
        [_collectionView reloadData];
        [_collectionView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}



-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   return _dataArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float wid = (SCREEN_WIDTH-40)/2;
    return CGSizeMake(wid, wid);
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    EllenCollectionCell *cell = (EllenCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"EllenCollectionCell" forIndexPath:indexPath];
    NSDictionary *dic = _dataArr[indexPath.item];
    NSString *url = dic[@"thumb"];
    cell.animatedView.image = nil;
    [cell.animatedView yy_setImageWithURL:[NSURL URLWithString:url] options:YYWebImageOptionProgressive|YYWebImageOptionIgnoreAnimatedImage];
    
//    [cell.animatedView setGIFImageWithURL:[NSURL URLWithString:url]];
    
    
//    NSData *data = [[SDImageCache sharedImageCache]imageDataFromDiskForKey:url];
//    if (data) {
//        cell.animatedView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//    }else{
//        
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//            
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            
//            if ([responseObject isKindOfClass:[NSData class]]) {
//                NSData *data = responseObject;
//                cell.animatedView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
//                [[SDImageCache sharedImageCache]storeImage:cell.animatedView.animatedImage.posterImage recalculateFromImage:NO imageData:data forKey:url toDisk:YES];
//            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//        }];
    

//    }


    
    
//    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:]];
//    cell.animatedView.animatedImage = image;

    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

    NSDictionary *dic = _dataArr[indexPath.item];
    NSString *url = dic[@"thumb"];
    
    NSData *emoticonData = [[SDImageCache sharedImageCache]imageDataFromDiskForKey:url];
    
   EllenCollectionCell *cell = (EllenCollectionCell*)[collectionView cellForItemAtIndexPath:indexPath];
    UIImage *thumbImage = cell.animatedView.image;
    [WXApiRequestHandler sendEmotionData:emoticonData
                              ThumbImage:thumbImage
                                 InScene:WXSceneSession];
    
}

#pragma mark- action

-(void)clickTheBtn:(UIButton*)btn{
    if (!_field.text.length) {
        _field.text = @" 熊本熊表情包";
    }
    [_dataArr removeAllObjects];
    [self requestData];
    [_field resignFirstResponder];
    _tapGesture.enabled = NO;
}

-(void)tapTheScreen:(UITapGestureRecognizer*)tap{
    [_field resignFirstResponder];
    _tapGesture.enabled = NO;
}


#pragma mark- UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _tapGesture.enabled = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self clickTheBtn:nil];
    return YES;
}




@end

//
//  HomeViewController.m
//  EllenGif
//
//  Created by Xiang on 16/9/20.
//  Copyright © 2016年 idreams.club. All rights reserved.
//

#import "HomeViewController.h"
#import "EllenCollectionCell.h"

#import "GifViewController.h"

#define kCount 18

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>{
    UITextField *_field;
    UICollectionView *_collectionView;
    NSMutableArray *_dataArr;
    
    UITapGestureRecognizer *_tapGesture;
    
    NSIndexPath *_selectedIndex;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    self.noTable = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _field = [[UITextField alloc]init];
    _field.layer.borderColor = [UIColor whiteColor].CGColor;
    _field.layer.borderWidth = 0.5;
    _field.font = [UIFont systemFontOfSize:12];
    _field.backgroundColor = [UIColor whiteColor];
    _field.textColor = TextDarkColor;
    _field.text = @"熊本熊表情包";
    _field.delegate = self;
    
    [_naviBar addSubview:_field];
    
    [_field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH-2*54);
        make.height.mas_equalTo(27);
        make.centerX.equalTo(_naviBar);
        make.bottom.mas_equalTo(-10);
    }];
    
    _field.layer.cornerRadius = 5;
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    lab.textColor = [UIColor whiteColor];
    lab.text = @"Ellen";
    lab.font = [UIFont fontWithName:@"Chalkduster" size:13];
    _naviBar.leftView = lab;
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-29, 20, 44, 44)];
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(clickTheBtn:) forControlEvents:UIControlEventTouchUpInside];
    _naviBar.rightView = btn;
    
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = viewBGColor;
    _collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerClass:[EllenCollectionCell class] forCellWithReuseIdentifier:@"EllenCollectionCell"];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64+5);
        make.bottom.equalTo(self.view);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
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
    [self showHudView];
    int count = kCount+((int)_dataArr.count?:-kCount);
    NSString *url = [NSString stringWithFormat:@"http://images.so.com/j?src=filter_noresult&q=%@&t=d&sn=%d&pn=%d&zoom=3",_field.text,count,kCount];
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
        [self hideHudView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showString:error.localizedDescription inView:self.view];
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
    float wid = (SCREEN_WIDTH-40)/3;
    return CGSizeMake(wid, wid);
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    EllenCollectionCell *cell = (EllenCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"EllenCollectionCell" forIndexPath:indexPath];
    NSDictionary *dic = _dataArr[indexPath.item];
    NSString *url = dic[@"_thumb"];

    [cell.imageView yy_setImageWithURL:[NSURL URLWithString:url] options:YYWebImageOptionProgressive|YYWebImageOptionAllowBackgroundTask|YYWebImageOptionShowNetworkActivity];
    
    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    GifViewController *gifVC = [[GifViewController alloc]init];
    gifVC.dataArr = _dataArr;
    gifVC.currentPage = indexPath.item;
    [self.navigationController pushViewController:gifVC animated:YES];
    
    
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

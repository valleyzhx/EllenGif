//
//  UserCenterController.m
//  MyDota
//
//  Created by Xiang on 15/10/14.
//  Copyright © 2015年 iOGG. All rights reserved.
//

#import "UserCenterController.h"
#import "MyDefines.h"
#import "WXApiRequestHandler.h"
#import "UMFeedback.h"
#import "ADViewController.h"
#import "UzysAssetsPickerController.h"
#import "WXApiRequestHandler.h"
#import "GifViewController.h"
#import "FavorViewController.h"


#define imageHeight 230

@interface UserCenterController ()<UITableViewDataSource,UITableViewDelegate,UzysAssetsPickerControllerDelegate>
@property (strong, nonatomic) UIImageView *imagView;

@end

@implementation UserCenterController{
    NSArray *_titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = viewBGColor;
    self.naviType = GGNavigationBarTypeNone;

    [self setHeaderImage];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setHiddenExtrLine:YES];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, imageHeight+5)];
        view.backgroundColor = [UIColor clearColor];
        view;
    });
    
    self.tableView.tableFooterView = ({
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
        lab.textColor = TextDarkColor;
        lab.backgroundColor = viewBGColor;
        lab.font = [UIFont systemFontOfSize:14];
        lab.text = [NSString stringWithFormat:@"EllenGif   V.%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
        lab.textAlignment = NSTextAlignmentCenter;
        lab;
    });
    
    _titleArr = @[@[@"我的收藏",@"打开相册照片"],@[@"给个好评",@"分享APP"],@[@"每日一句"],@[@"清除缓存"]];
}

-(void)setHeaderImage{
    if (_imagView == nil) {
        _imagView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, imageHeight)];
        [self.view addSubview:_imagView];
    }
    NSString *path = [self getImagePath];
    NSData *imgData = [NSData dataWithContentsOfFile:path];
    if (imgData) {
      self.imagView.image = [[UIImage alloc]initWithData:imgData];
    }else{
        self.imagView.image = [UIImage imageNamed:@"user_Header.jpg"];
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addTheExtraView{
//    _tableView.
}



#pragma mark ---- scrolldelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    float y = scrollView.contentOffset.y;
    y = MIN(0, y);
    _imagView.transform = CGAffineTransformMakeScale(1.0-y/150, 1.0-y/150);
}


#pragma mark --- tableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = _titleArr[section];
    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section?10:0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 10)];
    view.backgroundColor = viewBGColor;
    return view;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.textLabel.textColor = TextDarkColor;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSString *title = _titleArr[indexPath.section][indexPath.row];
    
    if ([title isEqualToString:@"每日一句"]||[title isEqualToString:@"我的收藏"]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = title;
    if ([cell.textLabel.text isEqualToString:@"清除缓存"]) {
        float sizeM = [[YYImageCache sharedCache].diskCache totalCost]/(1024.0*1024.0);
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
        lab.font = [UIFont systemFontOfSize:14];
        lab.textColor = TextDarkColor;
        lab.text = [NSString stringWithFormat:@"%.2fM",sizeM];
        cell.accessoryView = lab;
    }
    return cell;
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *title = _titleArr[indexPath.section][indexPath.row];
    
    if ([title isEqualToString:@"我的收藏"]) {
        FavorViewController *controller = [[FavorViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }

    if ([title isEqualToString:@"意见反馈"]) {
        [self presentViewController:[UMFeedback feedbackModalViewController] animated:YES completion:nil];
    }
    if ([title isEqualToString:@"给个好评"]) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:kAppStoreComendUrl]];
    }
    
    if ([title isEqualToString:@"分享APP"]) {
        [WXApiRequestHandler sendAppContentData:nil
                                        ExtInfo:@""
                                         ExtURL:kAppStoreUrl
                                          Title:@"EllenGif"
                                    Description:@"分享你的gif给你的微信好友"
                                     MessageExt:nil
                                  MessageAction:nil
                                     ThumbImage:nil
                                        InScene:WXSceneSession];
    }
    if ([title isEqualToString:@"每日一句"]) {
        ADViewController *controller = [[ADViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if ([title isEqualToString:@"打开相册照片"]) {
        [self choosePictures];
    }
    if ([title isEqualToString:@"清除缓存"]) {
        [self showHudView];
        [[YYImageCache sharedCache].diskCache removeAllObjectsWithProgressBlock:^(int removedCount, int totalCount) {
            
        } endBlock:^(BOOL error) {
            GetMainQueue([self.tableView reloadData];[self hideHudView];);
        }];
    }
    
}



- (void)choosePictures {
    UzysAssetsPickerController *picker = [[UzysAssetsPickerController alloc] init];
    picker.delegate = self;
    picker.maximumNumberOfSelectionPhoto = 1;
    picker.maximumNumberOfSelectionVideo = 0;
    
    [self presentViewController:picker animated:YES completion:^{
        
    }];
    
}



#pragma mark --- UzysAssetsPickerControllerDelegate

- (void)uzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    if([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) //Photo
    {
        
        [assets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALAsset *representation = obj;
            NSData *data;
            ALAssetRepresentation *re = [representation representationForUTI: (__bridge NSString *)kUTTypeGIF];
            if (re) {
                long long size = re.size;
                uint8_t *buffer = malloc(size);
                NSError *error;
                NSUInteger bytes = [re getBytes:buffer fromOffset:0 length:size error:&error];
                data = [NSData dataWithBytes:buffer length:bytes];
                free(buffer);
                
                
                
            }else{
                UIImage *img = [UIImage imageWithCGImage:representation.defaultRepresentation.fullResolutionImage scale:representation.defaultRepresentation.scale
                                             orientation:(UIImageOrientation)representation.defaultRepresentation.orientation];
                data = UIImageJPEGRepresentation(img, 0.8);
            }
            if (data) {
                GifViewController *gifViewVC = [[GifViewController alloc]init];
                gifViewVC.gifData = data;
                [self.navigationController pushViewController:gifViewVC animated:YES];
            }
            
        }];
        
        
    }
}



-(NSString*)getImagePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *DOCPath = [paths objectAtIndex:0];
    NSString *fn = [DOCPath stringByAppendingPathComponent:@"image.png"];
    return fn;
}

@end

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

#define imageHeight 230

@interface UserCenterController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UIImageView *imagView;

@end

@implementation UserCenterController{
    NSArray *_titleArr;
}

- (void)viewDidLoad {
    self.naviType = GGNavigationBarTypeNone;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = viewBGColor;
    
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
    
    _titleArr = @[@[@"给个好评",@"分享APP"],@[@"每日一句"],@[@"清除缓存"]];
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
    
    if ([title isEqualToString:@"每日一句"]) {
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
    if ([title isEqualToString:@"清除缓存"]) {
        [self showHudView];
        [[YYImageCache sharedCache].diskCache removeAllObjectsWithProgressBlock:^(int removedCount, int totalCount) {
            
        } endBlock:^(BOOL error) {
            GetMainQueue([self.tableView reloadData];[self hideHudView];);
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

//
//  SerchSetingView.h
//  EllenGif
//
//  Created by Xiang on 16/9/22.
//  Copyright © 2016年 idreams.club. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SerchSetingView : UIView

@property (nonatomic,assign,readonly) BOOL isChecked;

-(void)showInView:(UIView*)view;
-(void)hideView;



@end

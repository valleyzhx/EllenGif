//
//  LaunchView.h
//  EllenGif
//
//  Created by Xiang on 16/9/21.
//  Copyright © 2016年 idreams.club. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LaunchView : UIView

+(id)defultVIew;
-(id)initWithImage:(NSString*)imageName;



-(void)showInView:(UIView*)view;

@end

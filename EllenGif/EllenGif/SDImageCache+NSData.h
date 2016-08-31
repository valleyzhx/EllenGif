//
//  SDImageCache+NSData.h
//  cmsDemo
//
//  Created by Xiang on 16/7/27.
//  Copyright © 2016年 jd.com. All rights reserved.
//

#import "SDImageCache.h"

@interface SDImageCache (NSData)
-(NSData*)imageDataFromDiskForKey:(NSString*)key;
@end

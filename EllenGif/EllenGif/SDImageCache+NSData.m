//
//  SDImageCache+NSData.m
//  cmsDemo
//
//  Created by Xiang on 16/7/27.
//  Copyright © 2016年 jd.com. All rights reserved.
//

#import "SDImageCache+NSData.h"

@implementation SDImageCache (NSData)

-(NSData*)imageDataFromDiskForKey:(NSString*)key{
    NSString *defaultPath = [self defaultCachePathForKey:key];
    NSData *data = [NSData dataWithContentsOfFile:defaultPath];
    if (data) {
        return data;
    }
    return nil;
}


@end

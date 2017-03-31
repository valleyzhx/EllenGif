//
//  VideoModel.m
//  MyDota
//
//  Created by Xiang on 15/10/18.
//  Copyright © 2015年 iOGG. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel{
    
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *keyPaths = [super JSONKeyPathsByPropertyKey].mutableCopy;
    
    [keyPaths addEntriesFromDictionary:@{
                                         @"userid": @"user.user_id",
                                         @"userName":@"user.user_name",
                                        
                                         @"userDicId": @"user.id",
                                         @"userDicName":@"user.name"
                                         }];
    
    return keyPaths;
}


@end

//
//  GGRequest.h
//  MyDota
//
//  Created by Xiang on 15/10/15.
//  Copyright © 2015年 iOGG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>


@interface GGRequest : NSObject


+(void)requestWithUrl:(NSString*)url success:(void (^)(NSURLSessionDataTask *task,id responseObject))success
              failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failure;






@end

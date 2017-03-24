//
//  GGRequest.m
//  MyDota
//
//  Created by Xiang on 15/10/15.
//  Copyright © 2015年 iOGG. All rights reserved.
//

#import "GGRequest.h"

@implementation GGRequest

+(void)requestWithUrl:(NSString *)url success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
   [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
       
   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       if (success) {
           success(task,responseObject);
       }
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       if (failure) {
           failure(task,error);
       }
   }];
}





@end

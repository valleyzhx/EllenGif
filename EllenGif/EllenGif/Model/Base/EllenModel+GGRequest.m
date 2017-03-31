//
//  EllenModel+GGRequest.m
//  EllenGif
//
//  Created by Xiang on 17/3/23.
//  Copyright © 2017年 idreams.club. All rights reserved.
//

#import "EllenModel+GGRequest.h"

@implementation EllenModel (GGRequest)

+(void)startRequestWithUrl:(NSString *)url complish:(void (^)(id))finished{
    [GGRequest requestWithUrl:url success:^(NSURLSessionDataTask *task, id responseObject) {
        if (finished) {
            if ([NSJSONSerialization isValidJSONObject:responseObject]) {
                NSString *result = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
                NSLog(@"Success:----- %@",result);

                id objc = [self managerThereReponseObject:responseObject];
                finished(objc);
            }else{
                finished(nil);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (finished) {
            finished(nil);
        }
    }];
    
}


+(id)managerThereReponseObject:(id)responseObject{
    NSError *error = [[NSError alloc]init];
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        EllenModel *objc = [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:responseObject error:&error];
        return objc;
    }else if ([responseObject isKindOfClass:[NSArray class]]){
        NSArray *objc = [MTLJSONAdapter modelsOfClass:[self class] fromJSONArray:responseObject error:&error];
        return objc;
    }
    return nil;
}


@end

//
//  EllenModel+GGRequest.h
//  EllenGif
//
//  Created by Xiang on 17/3/23.
//  Copyright © 2017年 idreams.club. All rights reserved.
//

#import "EllenModel.h"

@interface EllenModel (GGRequest)
+(id)managerThereReponseObject:(id)responseObject;

+(void)startRequestWithUrl:(NSString *)url complish:(void (^)(id))finished;
@end

//
//  NetWork.h
//  AFNetworking_Demo
//
//  Created by 商帮 on 29/4/15.
//  Copyright (c) 2015年 周晓路. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWork : NSObject
+ (void)getUrl:(NSString *)urlString parameter:(NSDictionary *)parameter success:(void (^)(id responseObject))success failed:(void(^)(NSError *error))failed;
+ (void)postUrl:(NSString *)urlString parameter:(NSDictionary *)parameter success:(void (^)(id responseObject))success failed:(void(^)(NSError *error))failed;
@end

//
//  NetWork.m
//  AFNetworking_Demo
//
//  Created by 商帮 on 29/4/15.
//  Copyright (c) 2015年 周晓路. All rights reserved.
//

#import "NetWork.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"

@implementation NetWork

+ (void)getUrl:(NSString *)urlString parameter:(NSDictionary *)parameter success:(void (^)(id responseObject))success failed:(void(^)(NSError *error))failed{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"application/json", nil];
    //  设置网络超时
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager GET:urlString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failed(error);
    }];
}

+ (void)postUrl:(NSString *)urlString parameter:(NSDictionary *)parameter success:(void (^)(id responseObject))success failed:(void(^)(NSError *error))failed{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"application/json", nil];
    
    //  设置网络超时
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager POST:urlString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failed(error);
    }];
}
@end

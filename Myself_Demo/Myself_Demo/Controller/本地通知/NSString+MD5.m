//
//  NSString+MD5.m
//  Myself_Demo
//
//  Created by 商帮 on 26/5/15.
//  Copyright (c) 2015年 北京蓝海互联有限公司. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (MD5)
+ (NSString *)MD5:(NSString *)string{
    const char *original_str = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, sizeof(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString *mdfiveString = [hash lowercaseString];
    return mdfiveString;
}
@end

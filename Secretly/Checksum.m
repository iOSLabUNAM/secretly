//
//  Checksum.m
//  Secretly
//
//  Created by LuisE on 10/22/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

#import "Checksum.h"

@implementation Checksum
- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

+(NSString *) sha256String: (NSString *)input{
    const char* str = [input UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(str, strlen(str), result);

    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_SHA256_DIGEST_LENGTH; i++)
    {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

@end

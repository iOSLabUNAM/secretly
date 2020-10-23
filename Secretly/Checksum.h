//
//  Checksum.h
//  Secretly
//
//  Created by LuisE on 10/22/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

#ifndef Checksum_h
#define Checksum_h
#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>

@interface Checksum : NSObject
+(NSString *) sha256String: (NSString *)input;
@end

#endif /* Checksum_h */

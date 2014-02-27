//
//  Constants.m
//  B&J
//
//  Created by Bastiaan Andriessen on 22/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "Constants.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Constants

//NSString * const ApiUrl = @"http://localhost/CREAM/api/";
NSString * const ApiUrl = @"http://student.howest.be/bastiaan.andriessen/20122013/MAIV/CREAM/api/";
NSString * const MainSiteUrl = @"http://www.benjerry.com/";

int const TopLogoOffsetTop = 16;
int const TopButtonFontSize = 18;
int const TopButtonOffsetTop = 87;
int const TopButtonLeftOffsetLeft = 12;
int const TopButtonRightOffsetLeft = 173;
int const BackFrameOffsetTop = 43;

int const Ingredient1OffsetTop = 396;
int const Ingredient2OffsetTop = 346;
int const Ingredient3OffsetTop = 297;
int const Ingredient4OffsetTop = 247;
int const Ingredient5OffsetTop = 197;

+(BOOL)NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

+ (NSString *)sha1:(NSString *)encryptedString
{
    NSData *data = [encryptedString dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

@end

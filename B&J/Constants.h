//
//  Constants.h
//  B&J
//
//  Created by Bastiaan Andriessen on 22/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

extern NSString * const ApiUrl;
extern NSString * const MainSiteUrl;

extern int const TopLogoOffsetTop;
extern int const TopButtonFontSize;
extern int const TopButtonOffsetTop;
extern int const TopButtonLeftOffsetLeft;
extern int const TopButtonRightOffsetLeft;
extern int const BackFrameOffsetTop;

extern int const Ingredient1OffsetTop;
extern int const Ingredient2OffsetTop;
extern int const Ingredient3OffsetTop;
extern int const Ingredient4OffsetTop;
extern int const Ingredient5OffsetTop;

+(BOOL)NSStringIsValidEmail:(NSString *)checkString;

@end

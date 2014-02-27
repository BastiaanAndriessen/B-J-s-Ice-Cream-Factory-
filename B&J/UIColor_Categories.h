//
//  UIColor_Categories.h
//  B&J
//
//  Created by Bastiaan Andriessen on 23/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIColor(MBCategory)

+ (UIColor *)colorWithHex:(UInt32)col;
+ (UIColor *)colorWithHexString:(NSString *)str;

@end

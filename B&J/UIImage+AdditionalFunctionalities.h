//
//  UIImage+AdditionalFunctionalities.h
//  B&J
//
//  Created by Bastiaan Andriessen on 22/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AddtionalFunctionalities)

//TintColor...
- (UIImage *)imageWithTint:(UIColor *)tintColor;
//TintGradient...
- (UIImage *)imageWithGradient:(NSArray *)colorsArr;
//scale and resize...
-(UIImage*)scaleToSize:(CGSize)size;

@end
//
//  MixIngredientViewController.h
//  B&J
//
//  Created by Bastiaan Andriessen on 25/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MixIngredientScrollView.h"

@interface MixIngredientViewController : UIViewController

@property(strong, nonatomic) MixIngredientScrollView *mixIngredientScrollV;
@property(strong, nonatomic) NSString *mixedColorCode;
@property(nonatomic) BOOL isRotating;
@property(nonatomic) BOOL allowEndAnimation;
@property(nonatomic) BOOL allowShakeDetection;
@property(strong, nonatomic) NSTimer *timer;
@property(strong, nonatomic) NSTimer *timer2;
@property(nonatomic) float currentRotation;
@property(nonatomic) int progress;

@end

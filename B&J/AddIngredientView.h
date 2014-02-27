//
//  AddIngredientView.h
//  B&J
//
//  Created by Bastiaan Andriessen on 22/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddIngredientScrollView.h"

@interface AddIngredientView : UIView

@property(strong, nonatomic) UIImageView *background;
@property(strong, nonatomic) UIImageView *cloud;
@property(strong, nonatomic) UIImageView *cloud2;
@property(strong, nonatomic) NSTimer *timer;
@property(strong, nonatomic) UIImageView *colorFrame;
@property(strong, nonatomic) UIButton *btnLogo;
@property(strong, nonatomic) UIButton *btnBack;
@property(strong, nonatomic) UIImage *imageIngredient;
@property(strong, nonatomic) UIButton *btnIceCream;
@property(strong, nonatomic) UIButton *btnChunks;
@property(strong, nonatomic) NSString *currentSelectedIngredientKind;

@property(strong, nonatomic) AddIngredientScrollView *addIngredientScrollV;
@property(strong, nonatomic) UIView *mainView;

@end

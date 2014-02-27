//
//  AddMixIngredientView.h
//  B&J
//
//  Created by Bastiaan Andriessen on 25/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddMixIngredientScrollView.h"

@interface AddMixIngredientView : UIView

@property(strong, nonatomic) UIImageView *background;
@property(strong, nonatomic) UIImageView *cloud;
@property(strong, nonatomic) UIImageView *cloud2;
@property(strong, nonatomic) NSTimer *timer;
@property(strong, nonatomic) UIImageView *colorFrame;
@property(strong, nonatomic) UIButton *btnLogo;
@property(strong, nonatomic) UIButton *btnBack;
@property(strong, nonatomic) UIImage *imageIngredient;
@property(strong, nonatomic) UILabel *lblInfo;

@property(strong, nonatomic) AddMixIngredientScrollView *addMixIngredientScrollV;
@property(strong, nonatomic) UIView *mainView;

@end

//
//  TasteMixerScrollView.h
//  B&J
//
//  Created by Bastiaan Andriessen on 22/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ingredient.h"

@interface TasteMixerScrollView : UIScrollView <UIScrollViewDelegate>

@property(strong, nonatomic) UIImageView *background;
@property(strong, nonatomic) UIImageView *cloud;
@property(strong, nonatomic) UIImageView *cloud2;
@property(strong, nonatomic) UIImageView *colorFrame;
@property(strong, nonatomic) UIButton *btnLogo;
@property(strong, nonatomic) UIButton *btnBack;
@property(strong, nonatomic) UIButton *btnSubmit;
@property(strong, nonatomic) UILabel *lblInfo;

@property(strong, nonatomic) UIButton *btnAddIngredient;
@property(strong, nonatomic) UIButton *btnMixIngredient;

@property(nonatomic) int numAddedIngredients;
@property(strong, nonatomic) NSMutableArray *arrIngredientPieces;
@property(strong, nonatomic) NSMutableArray *arrIngredientDataObjects;
@property(strong, nonatomic) Ingredient *currentSelectedDataObject;

@property(strong, nonatomic) NSTimer *timer;
@property(strong, nonatomic) NSArray *arrTips;

-(void)resetAnimations;
-(void)addIngredient:(Ingredient*)ingredientDataObject;

@end

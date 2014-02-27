//
//  MixIngredientScrollView.h
//  B&J
//
//  Created by Bastiaan Andriessen on 25/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ingredient.h"
#import "ProgressBarView.h"

@interface MixIngredientScrollView : UIScrollView <UIScrollViewDelegate>

@property(strong, nonatomic) UIImageView *background;
@property(strong, nonatomic) UIImageView *cloud;
@property(strong, nonatomic) UIImageView *cloud2;
@property(strong, nonatomic) UIImageView *colorFrame;
@property(strong, nonatomic) UIButton *btnLogo;
@property(strong, nonatomic) UIButton *btnBack;
@property(strong, nonatomic) UITextView *txtInfo;

@property(strong, nonatomic) NSString *currentSelectingIngredient;
@property(strong, nonatomic) UIButton *selectedIngredient1Btn;
@property(strong, nonatomic) Ingredient *selectedIngredient1;
@property(strong, nonatomic) UIButton *selectedIngredient2Btn;
@property(strong, nonatomic) Ingredient *selectedIngredient2;

@property(strong, nonatomic) UIImageView *mixBoard;
@property(strong, nonatomic) UIImageView *mixBoardOverlay;
@property(strong, nonatomic) UIImageView *blade;
@property(strong, nonatomic) ProgressBarView *progressBarV;

-(void)updateSelectedIngredient:(Ingredient*)ingredientDataObject;
-(void)enableMixboard;
-(void)disableMixboard;
-(void)setError:(NSString*)error andChangeTextColor:(BOOL)changeTextColor;
-(void)setMixBoardOverlayColor:(NSString*)colorCode;
-(void)resetAnimations;

@end

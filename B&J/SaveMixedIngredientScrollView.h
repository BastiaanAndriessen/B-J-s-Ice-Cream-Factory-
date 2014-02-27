//
//  SaveMixedIngredientScrollView.h
//  B&J
//
//  Created by Bastiaan Andriessen on 27/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IngredientView.h"

@interface SaveMixedIngredientScrollView : UIScrollView <UIScrollViewDelegate, UITextFieldDelegate>

@property(nonatomic) BOOL allowScrollControl;

@property(strong, nonatomic) UIImageView *background;
@property(strong, nonatomic) UIImageView *cloud;
@property(strong, nonatomic) UIImageView *cloud2;
@property(strong, nonatomic) UIImageView *colorFrame;
@property(strong, nonatomic) UIButton *btnLogo;
@property(strong, nonatomic) UIButton *btnBack;
@property(strong, nonatomic) UILabel *lblCongrats;
@property(strong, nonatomic) UITextView *txtInfo;

@property(strong, nonatomic) UILabel *lblIngredientName;
@property(strong, nonatomic) UITextField *txtIngredientName;
@property(strong, nonatomic) UILabel *lblFeedback;

@property(strong, nonatomic) UILabel *lblCreation;
@property(strong, nonatomic) IngredientView *ingredient1V;
@property(strong, nonatomic) IngredientView *ingredient2V;

@property(strong, nonatomic) UIButton *btnSave;

-(void)setupIngredientView:(Ingredient*)ingredientDataObject;

@end

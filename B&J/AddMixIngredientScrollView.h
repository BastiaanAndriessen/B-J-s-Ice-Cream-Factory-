//
//  AddMixIngredientScrollView.h
//  B&J
//
//  Created by Bastiaan Andriessen on 25/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ingredient.h"

@interface AddMixIngredientScrollView : UIScrollView <UIScrollViewDelegate>

@property(nonatomic) int totalHeight;
@property(strong, nonatomic) Ingredient *selectedIngredient;
@property(strong, nonatomic) NSMutableArray *arrIngredients;
@property(strong, nonatomic) NSMutableArray *arrIngredientDataObjects;
@property(strong, nonatomic) NSMutableArray *arrIngredientButtons;
@property(strong, nonatomic) UIImageView *loading;

-(void)loadIngredients:(NSMutableArray*)arrIngredients;

@end

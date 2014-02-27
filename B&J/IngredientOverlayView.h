//
//  IngredientOverlayView.h
//  B&J
//
//  Created by Bastiaan Andriessen on 24/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ingredient.h"
#import "IngredientView.h"

@interface IngredientOverlayView : UIView

@property(strong, nonatomic) Ingredient *ingredientDataObject;
@property(strong, nonatomic) UIButton *btnReturn;
@property(strong, nonatomic) IngredientView *ingredientV;

- (id)initWithFrame:(CGRect)frame ingredientDataObject:(Ingredient*)ingredientDataObject;
 
@end

//
//  IngredientView.h
//  B&J
//
//  Created by Bastiaan Andriessen on 24/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ingredient.h"

@interface IngredientView : UIView

@property(strong, nonatomic) Ingredient *ingredientDataObject;

- (id)initWithFrame:(CGRect)frame andIngredientDataObject:(Ingredient*)ingredientDataObject;

@end

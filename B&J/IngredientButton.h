//
//  IngredientButton.h
//  B&J
//
//  Created by Bastiaan Andriessen on 23/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ingredient.h"

@interface IngredientButton : UIButton

@property(strong, nonatomic) Ingredient *ingredientDataObject;

- (id)initWithFrame:(CGRect)frame andIngredientDataObject:(Ingredient*)ingredientDataObject;

@end

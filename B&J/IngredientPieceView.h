//
//  IngredientPieceView.h
//  B&J
//
//  Created by Bastiaan Andriessen on 23/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ingredient.h"

@interface IngredientPieceView : UIView

@property(nonatomic) int pieceId;
@property(strong, nonatomic) Ingredient *ingredientDataObject;
@property(strong, nonatomic) UIButton *btnBackground;
@property(strong, nonatomic) UIButton *btnDelete;

- (id)initWithFrame:(CGRect)frame ingredientDataObject:(Ingredient*)ingredientDataObject pieceId:(int)pieceId;

@end

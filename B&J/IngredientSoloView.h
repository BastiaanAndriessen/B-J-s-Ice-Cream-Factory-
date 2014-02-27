//
//  IngredientSoloView.h
//  B&J
//
//  Created by Bastiaan Andriessen on 30/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IngredientSoloView : UIView

@property(strong, nonatomic) UIImageView *background;
@property(strong, nonatomic) UILabel *lblTitle;

@property(strong, nonatomic) UIImageView *imgIngredient1;
@property(strong, nonatomic) UILabel *lblIngredient1;

@property(strong, nonatomic) UIImageView *imgIngredient2;
@property(strong, nonatomic) UILabel *lblIngredient2;

- (id)initWithFrame:(CGRect)frame ingredientData:(NSDictionary*)ingredientData;
- (id)initWithFrame:(CGRect)frame ingredientData:(NSDictionary*)ingredientData component1Data:(NSDictionary*)component1Data component2Data:(NSDictionary*)component2Data;

@end

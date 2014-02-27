//
//  SaveMixedIngredientViewController.h
//  B&J
//
//  Created by Bastiaan Andriessen on 27/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveMixedIngredientScrollView.h"
#import "Ingredient.h"

@interface SaveMixedIngredientViewController : UIViewController

@property(strong, nonatomic) SaveMixedIngredientScrollView *saveMixedIngredientScrollV;
@property(strong, nonatomic) Ingredient *ingredientDataObject1;
@property(strong, nonatomic) Ingredient *ingredientDataObject2;
@property(strong, nonatomic) NSString *colorCode;
@property(strong, nonatomic) NSString *ingredientIds;
@property(strong, nonatomic) NSString *ingredientName;
@property(strong, nonatomic) NSString *ingredientId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil ingredientDataObject1:(Ingredient*)ingredientDataObject1 ingredientDataObject2:(Ingredient*)ingredientDataObject2 colorCode:(NSString*)colorCode;

@end

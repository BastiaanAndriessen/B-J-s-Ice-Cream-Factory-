//
//  TasteMixerViewController.h
//  B&J
//
//  Created by Bastiaan Andriessen on 22/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TasteMixerScrollView.h"
#import "Ingredient.h"

@interface TasteMixerViewController : UIViewController

@property(strong, nonatomic) TasteMixerScrollView *tasteMixerScrollV;
@property(strong, nonatomic) NSMutableArray *arrAddedIngredientDataObjects;

-(void)addIngredient:(Ingredient*)ingredientDataObject;
-(void)addLatestIngredientWithName:(NSString*)name colorCode:(NSString *)colorCode ingredientIds:(NSString*)ingredientIds ingredientDataObject1:(Ingredient*)ingredientDataObject1 ingredientDataObject2:(Ingredient*)ingredientDataObject2 ingredientId:(NSString*)ingredientId;
-(void)resetPreviousStateWithArrIngredientObjects:(NSArray*)arrIngredientObjects;

@end

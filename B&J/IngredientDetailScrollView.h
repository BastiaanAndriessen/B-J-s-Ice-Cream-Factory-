//
//  IngredientDetailScrollView.h
//  B&J
//
//  Created by Bastiaan Andriessen on 30/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IngredientDetailScrollView : UIScrollView <UIScrollViewDelegate>

@property(strong, nonatomic) UIImageView *loading;
@property(nonatomic) int totalHeight;

-(void)loadIngredientsWithIds:(NSString*)ids ingredients:(NSArray*)ingredients newIngredients:(NSArray*)newIngredients;

@end

//
//  IngredientDetailViewController.h
//  B&J
//
//  Created by Bastiaan Andriessen on 30/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IngredientDetailView.h"

@interface IngredientDetailViewController : UIViewController

@property(strong, nonatomic) IngredientDetailView *ingredientDetailV;
@property(strong, nonatomic) NSString *iceCreamName;
@property(strong, nonatomic) NSString *ingredientIds;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil iceCreamName:(NSString*)iceCreamName ingredientIds:(NSString*)ingredientIds;

@end

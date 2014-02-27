//
//  AddMixIngredientViewController.h
//  B&J
//
//  Created by Bastiaan Andriessen on 25/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddMixIngredientView.h"

@interface AddMixIngredientViewController : UIViewController

@property(strong, nonatomic) AddMixIngredientView *addMixIngredientV;
@property(strong, nonatomic) NSString *ingredientNameNotToShow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil ingredientNameNotToShow:(NSString*)ingredientNameNotToShow;

@end

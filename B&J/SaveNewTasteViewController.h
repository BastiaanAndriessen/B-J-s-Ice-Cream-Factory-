//
//  SaveNewTasteViewController.h
//  B&J
//
//  Created by Bastiaan Andriessen on 27/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveNewTasteScrollView.h"

@interface SaveNewTasteViewController : UIViewController

@property(strong, nonatomic) SaveNewTasteScrollView *saveNewTasteScrollV;
@property(strong, nonatomic) NSArray *arrAddedIngredientDataObjects;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil arrAddedIngredientDataObjects:(NSArray*)arrAddedIngredientDataObjects;

@end

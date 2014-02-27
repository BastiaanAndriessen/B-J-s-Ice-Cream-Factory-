//
//  AppDelegate.h
//  B&J
//
//  Created by Bastiaan Andriessen on 21/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "MeuhViewController.h"
#import "TasteMixerViewController.h"
#import "AddIngredientViewController.h"
#import "MixIngredientViewController.h"
#import "AddMixIngredientViewController.h"
#import "SaveMixedIngredientViewController.h"
#import "SaveNewTasteViewController.h"
#import "RateTastesViewController.h"
#import "EmailOverlayViewController.h"
#import "SettingsOverlayViewController.h"
#import "IngredientDetailViewController.h"
#import "SocialShareViewController.h"
#import "Ingredient.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//NAVIGATION VARS
@property(strong, nonatomic) UINavigationController *navCont;
@property(strong, nonatomic) HomeViewController *homeVC;
@property(strong, nonatomic) MeuhViewController *meuhVC;
@property(strong, nonatomic) TasteMixerViewController *tasteMixerVC;
@property(strong, nonatomic) AddIngredientViewController *addIngredientVC;
@property(strong, nonatomic) MixIngredientViewController *mixIngredientVC;
@property(strong, nonatomic) AddMixIngredientViewController *addMixIngredientVC;
@property(strong, nonatomic) SaveMixedIngredientViewController *saveMixedIngredientVC;
@property(strong, nonatomic) SaveNewTasteViewController *saveNewTasteVC;
@property(strong, nonatomic) RateTastesViewController *rateTastesVC;
@property(strong, nonatomic) EmailOverlayViewController *emailOverlayVC;
@property(strong, nonatomic) SettingsOverlayViewController *settingsOverlayVC;
@property(strong, nonatomic) IngredientDetailViewController *ingredientDetailVC;
@property(strong, nonatomic) SocialShareViewController *socialShareVC;

//DATA
@property(strong, nonatomic) Ingredient *selectedIngredient;
@property(strong, nonatomic) NSArray *currentTasteMixerAddedIngredients;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

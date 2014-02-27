//
//  AppDelegate.m
//  B&J
//
//  Created by Bastiaan Andriessen on 21/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "AppDelegate.h"
#import <Social/Social.h>

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

//NAVIGATION VARS
@synthesize navCont = _navCont;
@synthesize homeVC = _homeVC;
@synthesize meuhVC = _meuhVC;
@synthesize tasteMixerVC = _tasteMixerVC;
@synthesize addIngredientVC = _addIngredientVC;
@synthesize mixIngredientVC = _mixIngredientVC;
@synthesize addMixIngredientVC = _addMixIngredientVC;
@synthesize saveMixedIngredientVC = _saveMixedIngredientVC;
@synthesize saveNewTasteVC = _saveNewTasteVC;
@synthesize rateTastesVC = _rateTastesVC;
@synthesize emailOverlayVC = _emailOverlayVC;
@synthesize settingsOverlayVC = _settingsOverlayVC;
@synthesize ingredientDetailVC = _ingredientDetailVC;
@synthesize socialShareVC = _socialShareVC;

//DATA
@synthesize selectedIngredient = _selectedIngredient;
@synthesize currentTasteMixerAddedIngredients = _currentTasteMixerAddedIngredients;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.homeVC = [[HomeViewController alloc] initWithNibName:nil bundle:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showInfo:) name:@"SHOW_INFO" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMixer:) name:@"SHOW_MIXER" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRates:) name:@"SHOW_RATES" object:nil];
    self.navCont = [[UINavigationController alloc] init];
    [self.navCont pushViewController:self.homeVC animated:YES];
    [self.navCont setNavigationBarHidden:YES animated:NO];
    
    //Delete all userdefaults
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
    
    [self.window setRootViewController:self.navCont];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

//NAVIGATION
-(void)showInfo:(id)sender{
    self.meuhVC = [[MeuhViewController alloc] initWithNibName:nil bundle:nil];
    [self.navCont pushViewController:self.meuhVC animated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHOW_INFO" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHOW_MIXER" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToMain:) name:@"BACK_TO_MAIN" object:nil];
}

-(void)showMixer:(id)sender{
    self.tasteMixerVC = [[TasteMixerViewController alloc] initWithNibName:nil bundle:nil];
    [self.navCont pushViewController:self.tasteMixerVC animated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHOW_INFO" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHOW_MIXER" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAddIngredient:) name:@"SHOW_ADD_INGREDIENT" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMixIngredient:) name:@"SHOW_MIX_INGREDIENT" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToMain:) name:@"BACK_TO_MAIN" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSaveNewTaste:) name:@"SAVE_NEW_TASTE" object:nil];
    if([self.currentTasteMixerAddedIngredients count]>0){
        [self.tasteMixerVC resetPreviousStateWithArrIngredientObjects:self.currentTasteMixerAddedIngredients];
    }
}

-(void)showRates:(id)sender{
    self.rateTastesVC = [[RateTastesViewController alloc] initWithNibName:nil bundle:nil];
    [self.navCont pushViewController:self.rateTastesVC animated:YES];
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"email"]){
        self.emailOverlayVC = [[EmailOverlayViewController alloc] initWithNibName:nil bundle:nil];
        [self.navCont presentViewController:self.emailOverlayVC animated:YES completion:NULL];
    }else{
        [self.rateTastesVC.rateTastesV.rateTastesScrollV updateVoteButtons];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHOW_RATES" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToMainFromRateEmail:) name:@"BACK_TO_MAIN_FROM_RATE_EMAIL" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToRateTastesFromRateEmail:) name:@"BACK_TO_RATETASTES_FROM_RATE_EMAIL" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSettings:) name:@"SHOW_SETTINGS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToMain:) name:@"BACK_TO_MAIN" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showIngredients:) name:@"SHOW_INGREDIENTS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showShare:) name:@"SHOW_SHARE" object:nil];
}

-(void)showShare:(id)sender{
    self.socialShareVC = [[SocialShareViewController alloc] initWithNibName:nil bundle:nil];
    [self.navCont pushViewController:self.socialShareVC animated:YES];
    [self.socialShareVC.socialShareScrollV fillInVotedIceCreamName:self.rateTastesVC.iceCreamName voteKind:self.rateTastesVC.votingKind];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToRateTastesFromIngredients:) name:@"BACK_TO_RATE_TASTES_FROM_INGREDIENTS_OR_SHARE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareTapped:) name:@"SHARE" object:nil];
}

-(void)shareTapped:(id)sender{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHARE" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BACK_TO_RATE_TASTES_FROM_INGREDIENTS_OR_SHARE" object:nil];
    NSString *votingKind = [self.rateTastesVC.votingKind lowercaseString];
    NSString *iceCreamName = [[self.rateTastesVC.iceCreamName lowercaseString] capitalizedString];
    [self.navCont popViewControllerAnimated:YES];
    if( [SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook] ){
        SLComposeViewController *composeVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [composeVC setInitialText:[NSString stringWithFormat:@"I just gave some %@ to the %@ ice cream. Download the Ben & Jerry's app, make your own ice cream and spread the Peace, Love & Ice Cream!",votingKind,iceCreamName]];
        [self.navCont presentViewController:composeVC animated:YES completion:^{}];
    }
}

-(void)showIngredients:(id)sender{
    self.ingredientDetailVC = [[IngredientDetailViewController alloc] initWithNibName:nil bundle:nil iceCreamName:self.rateTastesVC.iceCreamName ingredientIds:self.rateTastesVC.ingredientIds];
    [self.navCont pushViewController:self.ingredientDetailVC animated:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToRateTastesFromIngredients:) name:@"BACK_TO_RATE_TASTES_FROM_INGREDIENTS_OR_SHARE" object:nil];
}

-(void)backToRateTastesFromIngredients:(id)sender{
    [self.navCont popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHARE" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BACK_TO_RATE_TASTES_FROM_INGREDIENTS_OR_SHARE" object:nil];
    [self.rateTastesVC.rateTastesV resetAnimations];
}

-(void)showSettings:(id)sender{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHOW_SETTINGS" object:nil];
    self.settingsOverlayVC = [[SettingsOverlayViewController alloc] initWithNibName:nil bundle:nil];
    [self.navCont presentViewController:self.settingsOverlayVC animated:YES completion:NULL];
}

-(void)backToRateTastesFromRateEmail:(id)sender{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSettings:) name:@"SHOW_SETTINGS" object:nil];
    [self.navCont dismissViewControllerAnimated:YES completion:NULL];
    [self.rateTastesVC.rateTastesV.rateTastesScrollV updateVoteButtons];
    [self.rateTastesVC readdObservers];
    [self.rateTastesVC.rateTastesV resetAnimations];
}

-(void)showAddIngredient:(id)sender{
    self.addIngredientVC = [[AddIngredientViewController alloc] initWithNibName:nil bundle:nil];
    [self.navCont pushViewController:self.addIngredientVC animated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHOW_ADD_INGREDIENT" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToMixer:) name:@"BACK_TO_MIXER" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToTasteMixerWithSelectedIngredient:) name:@"INGREDIENT_SELECTED" object:nil];
}

-(void)showMixIngredient:(id)sender{
    self.mixIngredientVC = [[MixIngredientViewController alloc] initWithNibName:nil bundle:nil];
    [self.navCont pushViewController:self.mixIngredientVC animated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHOW_MIX_INGREDIENT" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToMixer:) name:@"BACK_TO_MIXER" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAddMixIngredient:) name:@"SHOW_ADD_MIX_INGREDIENT" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSaveMixedIngredient:) name:@"SHOW_SAVE_MIXED_INGREDIENT" object:nil];
}

-(void)showAddMixIngredient:(id)sender{
    NSString *nameIngredientToNotShow = @"";
    if([self.mixIngredientVC.mixIngredientScrollV.currentSelectingIngredient isEqualToString:@"ingredient1"] && self.mixIngredientVC.mixIngredientScrollV.selectedIngredient2){
        nameIngredientToNotShow = self.mixIngredientVC.mixIngredientScrollV.selectedIngredient2.name;
    }else if([self.mixIngredientVC.mixIngredientScrollV.currentSelectingIngredient isEqualToString:@"ingredient2"] && self.mixIngredientVC.mixIngredientScrollV.selectedIngredient1){
        nameIngredientToNotShow = self.mixIngredientVC.mixIngredientScrollV.selectedIngredient1.name;
    }
    self.addMixIngredientVC = [[AddMixIngredientViewController alloc] initWithNibName:nil bundle:nil ingredientNameNotToShow:nameIngredientToNotShow];
    [self.navCont pushViewController:self.addMixIngredientVC animated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BACK_TO_MIXER" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHOW_ADD_MIX_INGREDIENT" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToIngredientMixer:) name:@"BACK_TO_INGREDIENT_MIXER" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToIngredientMixerWithSelectedIngredient:) name:@"INGREDIENT_SELECTED_TO_MIX" object:nil];
}

-(void)showSaveMixedIngredient:(id)sender{
    self.saveMixedIngredientVC = [[SaveMixedIngredientViewController alloc] initWithNibName:nil bundle:nil ingredientDataObject1:self.mixIngredientVC.mixIngredientScrollV.selectedIngredient1 ingredientDataObject2:self.mixIngredientVC.mixIngredientScrollV.selectedIngredient2 colorCode:self.mixIngredientVC.mixedColorCode];
    [self.navCont presentViewController:self.saveMixedIngredientVC animated:YES completion:NULL];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToTasteMixerFromSaveMix:) name:@"BACK_TO_MIXER_FROM_SAVE_MIX" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToTasteMixerFromSaveSetNewMix:) name:@"BACK_TO_MIXER_FROM_SAVE_SET_NEW_MIX" object:nil];
}

-(void)showSaveNewTaste:(id)sender{
    self.saveNewTasteVC = [[SaveNewTasteViewController alloc] initWithNibName:nil bundle:nil arrAddedIngredientDataObjects:self.tasteMixerVC.arrAddedIngredientDataObjects];
    [self.navCont presentViewController:self.saveNewTasteVC animated:YES completion:NULL];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToMainMenuWithoutSave:) name:@"BACK_TO_MAIN_MENU" object:nil];
}

-(void)backToMainFromRateEmail:(id)sender{
    [self.navCont dismissViewControllerAnimated:YES completion:^(void){
        [self backToMain:@""];
    }];
}

-(void)backToMainMenuWithoutSave:(id)sender{
    [self.navCont dismissViewControllerAnimated:YES completion:^{
        [self backToMain:@""];
    }];
}

-(void)backToTasteMixerFromSaveMix:(id)sender{
    [self.navCont dismissViewControllerAnimated:YES completion:^{
        [self backToMixer:@""];
    }];
}

-(void)backToTasteMixerFromSaveSetNewMix:(id)sender{
    [self.navCont dismissViewControllerAnimated:YES completion:^{
        [self backToMixer:@""];
    }];
    [self.tasteMixerVC addLatestIngredientWithName:self.saveMixedIngredientVC.ingredientName colorCode:self.saveMixedIngredientVC.colorCode ingredientIds:self.saveMixedIngredientVC.ingredientIds ingredientDataObject1:self.saveMixedIngredientVC.ingredientDataObject1 ingredientDataObject2:self.saveMixedIngredientVC.ingredientDataObject2 ingredientId:self.saveMixedIngredientVC.ingredientId];
}

-(void)backToIngredientMixer:(id)sender{
    [self.navCont popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHOW_MIX_INGREDIENT" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BACK_TO_INGREDIENT_MIXER" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToMixer:) name:@"BACK_TO_MIXER" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAddMixIngredient:) name:@"SHOW_ADD_MIX_INGREDIENT" object:nil];
    [self.mixIngredientVC.mixIngredientScrollV resetAnimations];
}

-(void)backToIngredientMixerWithSelectedIngredient:(id)sender{
    self.selectedIngredient = self.addMixIngredientVC.addMixIngredientV.addMixIngredientScrollV.selectedIngredient;
    [self.navCont popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"INGREDIENT_SELECTED_TO_MIX" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAddMixIngredient:) name:@"SHOW_ADD_MIX_INGREDIENT" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToMixer:) name:@"BACK_TO_MIXER" object:nil];
    [self.mixIngredientVC.mixIngredientScrollV updateSelectedIngredient:self.selectedIngredient];
    self.selectedIngredient = nil;
    [self.mixIngredientVC.mixIngredientScrollV resetAnimations];
}

-(void)backToMixer:(id)sender{
    [self.navCont popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BACK_TO_MIXER" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"INGREDIENT_SELECTED" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BACK_TO_RATETASTES_FROM_RATE_EMAIL" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHOW_SAVE_MIXED_INGREDIENT" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BACK_TO_MIXER_FROM_SAVE_MIX" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BACK_TO_MIXER_FROM_SAVE_SET_NEW_MIX" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAddIngredient:) name:@"SHOW_ADD_INGREDIENT" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMixIngredient:) name:@"SHOW_MIX_INGREDIENT" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToMain:) name:@"BACK_TO_MAIN" object:nil];
    [self.tasteMixerVC.tasteMixerScrollV resetAnimations];
}

-(void)backToTasteMixerWithSelectedIngredient:(id)sender{
    self.selectedIngredient = self.addIngredientVC.addIngredientV.addIngredientScrollV.selectedIngredient;
    [self.navCont popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BACK_TO_MIXER" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"INGREDIENT_SELECTED" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAddIngredient:) name:@"SHOW_ADD_INGREDIENT" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToMain:) name:@"BACK_TO_MAIN" object:nil];
    [self.tasteMixerVC.tasteMixerScrollV resetAnimations];
    [self.tasteMixerVC addIngredient:self.selectedIngredient];
    self.selectedIngredient = nil;
}

-(void)backToMain:(id)sender{
    self.currentTasteMixerAddedIngredients = self.tasteMixerVC.arrAddedIngredientDataObjects;
    [self.navCont popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BACK_TO_RATETASTES_FROM_RATE_EMAIL" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BACK_TO_MAIN_FROM_RATE_EMAIL" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BACK_TO_MAIN" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SAVE_NEW_TASTE" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BACK_TO_MAIN_MENU" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHOW_INGREDIENTS" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHOW_SHARE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showInfo:) name:@"SHOW_INFO" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMixer:) name:@"SHOW_MIXER" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRates:) name:@"SHOW_RATES" object:nil];
    [self.homeVC.homeScrollV resetAnimations];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"B_J" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"B_J.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end

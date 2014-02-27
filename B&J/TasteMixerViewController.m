//
//  TasteMixerViewController.m
//  B&J
//
//  Created by Bastiaan Andriessen on 22/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "TasteMixerViewController.h"
#import "Ingredient.h"

@interface TasteMixerViewController ()

@end

@implementation TasteMixerViewController

@synthesize tasteMixerScrollV = _tasteMixerScrollV;
@synthesize arrAddedIngredientDataObjects = _arrAddedIngredientDataObjects;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.arrAddedIngredientDataObjects = [NSMutableArray array];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteIngredient:) name:@"DELETE_INGREDIENT" object:nil];
    }
    return self;
}

-(void)deleteIngredient:(id)sender{
    self.arrAddedIngredientDataObjects = self.tasteMixerScrollV.arrIngredientDataObjects;
}

- (void)loadView
{
    UIView *mainView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setView:mainView];
    mainView.backgroundColor = [UIColor clearColor];
    
    self.tasteMixerScrollV = [[TasteMixerScrollView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.tasteMixerScrollV setClipsToBounds:YES];
    [self.tasteMixerScrollV setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [self.tasteMixerScrollV setUserInteractionEnabled:YES];
    [mainView addSubview:self.tasteMixerScrollV];
    
    mainView.userInteractionEnabled = YES;
    self.tasteMixerScrollV.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, self.tasteMixerScrollV.background.frame.size.height);
    self.tasteMixerScrollV.scrollEnabled = YES;
    self.tasteMixerScrollV.showsVerticalScrollIndicator = NO;
    self.tasteMixerScrollV.delaysContentTouches = YES;
    self.tasteMixerScrollV.canCancelContentTouches = NO;
    self.tasteMixerScrollV.delegate = self.tasteMixerScrollV;
}

-(void)resetPreviousStateWithArrIngredientObjects:(NSArray*)arrIngredientObjects{
    for(int i = 0; i<[arrIngredientObjects count]; i++){
        [self addIngredient:[arrIngredientObjects objectAtIndex:i]];
    }
}

-(void)addLatestIngredientWithName:(NSString*)name colorCode:(NSString *)colorCode ingredientIds:(NSString*)ingredientIds ingredientDataObject1:(Ingredient*)ingredientDataObject1 ingredientDataObject2:(Ingredient*)ingredientDataObject2 ingredientId:(NSString*)ingredientId{
    Ingredient *newIngredient = [[Ingredient alloc] initWithName:name ingredientKind:@"icecream" colorCode:colorCode ingredientIds:ingredientIds nameComponent1:ingredientDataObject1.name colorCodeComponent1:ingredientDataObject1.colorCode urlComponent1:ingredientDataObject1.url nameComponent2:ingredientDataObject2.name colorCodeComponent2:ingredientDataObject2.colorCode urlComponent2:ingredientDataObject2.url andIngredientId:ingredientId];
    [self.arrAddedIngredientDataObjects addObject:newIngredient];
    [self.tasteMixerScrollV addIngredient:newIngredient];
}

-(void)addIngredient:(Ingredient*)ingredientDataObject{
    [self.arrAddedIngredientDataObjects addObject:ingredientDataObject];
    [self.tasteMixerScrollV addIngredient:ingredientDataObject];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"DELETE_INGREDIENT" object:nil];
}

@end

//
//  AddMixIngredientScrollView.m
//  B&J
//
//  Created by Bastiaan Andriessen on 25/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "AddMixIngredientScrollView.h"
#import "Constants.h"
#import "IngredientButton.h"
#import "Ingredient.h"
#import <QuartzCore/QuartzCore.h>

@implementation AddMixIngredientScrollView

@synthesize totalHeight = _totalHeight;
@synthesize selectedIngredient = _selectedIngredient;
@synthesize arrIngredients = _arrIngredients;
@synthesize arrIngredientDataObjects = _arrIngredientDataObjects;
@synthesize arrIngredientButtons = _arrIngredientButtons;
@synthesize loading = _loading;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSString *pathLoading = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif" inDirectory:@"images"];
        UIImage *imgLoading = [[UIImage alloc] initWithContentsOfFile:pathLoading];
        self.loading = [[UIImageView alloc] initWithImage:imgLoading];
        self.loading.frame = CGRectMake(self.frame.size.width/2 - imgLoading.size.width/2, self.frame.size.height/2 - imgLoading.size.height/2, imgLoading.size.width, imgLoading.size.height);
        [self addSubview:self.loading];
        
        CABasicAnimation *rotation;
        rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        rotation.fromValue = [NSNumber numberWithFloat:0];
        rotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
        rotation.duration = 2;
        rotation.repeatCount = HUGE_VALF;
        [self.loading.layer addAnimation:rotation forKey:@"Spin"];
    }
    return self;
}

-(void)loadIngredients:(NSMutableArray*)arrIngredients{
    for(int i = 0; i<[self.arrIngredientButtons count]; i++){
        [[self.arrIngredientButtons objectAtIndex:i] removeFromSuperview];
    }
    
    self.arrIngredientDataObjects = [NSMutableArray array];
    for(int i = 0; i<[arrIngredients count]; i++){
        if([[arrIngredients objectAtIndex:i] count] == 5){
            //normal ingredient
            NSObject *ingredient = [[Ingredient alloc] initWithName:[[arrIngredients objectAtIndex:i] objectForKey:@"name"] ingredientKind:[[arrIngredients objectAtIndex:i] objectForKey:@"kind"] colorCode:[[arrIngredients objectAtIndex:i] objectForKey:@"color_code"] url:[[arrIngredients objectAtIndex:i] objectForKey:@"url"] andIngredientId:[[arrIngredients objectAtIndex:i] objectForKey:@"id"]];
            [self.arrIngredientDataObjects addObject:ingredient];
        }else{
            //mixed ingredient
            NSObject *ingredient = [[Ingredient alloc] initWithName:[[[arrIngredients objectAtIndex:i] objectAtIndex:0] objectForKey:@"name"] ingredientKind:@"icecream" colorCode:[[[arrIngredients objectAtIndex:i] objectAtIndex:0] objectForKey:@"color_code"] ingredientIds:[[[arrIngredients objectAtIndex:i] objectAtIndex:0] objectForKey:@"ingredient_ids"] nameComponent1:[[[[arrIngredients objectAtIndex:i] objectAtIndex:1] objectAtIndex:0] objectForKey:@"name"] colorCodeComponent1:[[[[arrIngredients objectAtIndex:i] objectAtIndex:1] objectAtIndex:0] objectForKey:@"color_code"] urlComponent1:[[[[arrIngredients objectAtIndex:i] objectAtIndex:1] objectAtIndex:0] objectForKey:@"url"] nameComponent2:[[[[arrIngredients objectAtIndex:i] objectAtIndex:1] objectAtIndex:1] objectForKey:@"name"] colorCodeComponent2:[[[[arrIngredients objectAtIndex:i] objectAtIndex:1] objectAtIndex:1] objectForKey:@"color_code"] urlComponent2:[[[[arrIngredients objectAtIndex:i] objectAtIndex:1] objectAtIndex:1] objectForKey:@"id"] andIngredientId:[[arrIngredients objectAtIndex:i] objectForKey:@"url"]];
            [self.arrIngredientDataObjects addObject:ingredient];
        }
    }
    
    int offsetLeft = 0;
    int offsetTopConstant = 140;
    int offsetTop = 0;
    self.totalHeight = 5;
    self.arrIngredientButtons = [NSMutableArray array];
    for(int j=0; j<[self.arrIngredientDataObjects count]; j++){
        if(j%2 == 0){
            offsetLeft = TopButtonLeftOffsetLeft;
            offsetTop = 5+(j/2)*offsetTopConstant;
            self.totalHeight += 140;
        }else{
            offsetLeft = TopButtonRightOffsetLeft;
            offsetTop = 5+((j-1)/2)*offsetTopConstant;
        }
        
        IngredientButton *ingredientB = [[IngredientButton alloc] initWithFrame:CGRectMake(offsetLeft, offsetTop, 140, 125) andIngredientDataObject:[self.arrIngredientDataObjects objectAtIndex:j]];
        [self.arrIngredientButtons addObject:ingredientB];
        [ingredientB addTarget:self action:@selector(selectIngredient:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:ingredientB];
    }
    
    [self.loading removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SET_CONTENT_SIZE" object:nil];
}

-(void)selectIngredient:(id)sender{
    for(int i = 0; i<[self.arrIngredientButtons count];i++){
        if([self.arrIngredientButtons objectAtIndex:i] == sender){
            IngredientButton *currentSelectedButton = ((IngredientButton*)[self.arrIngredientButtons objectAtIndex:i]);
            self.selectedIngredient = currentSelectedButton.ingredientDataObject;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"INGREDIENT_SELECTED_TO_MIX" object:nil];
        }
    }
}

//scroll control
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.contentOffset.y < 0){
        self.contentOffset = CGPointMake(0, 0);
    }
    if(self.totalHeight+192 > [[UIScreen mainScreen] bounds].size.height){
        if(self.contentOffset.y > self.totalHeight+192 - [[UIScreen mainScreen] bounds].size.height){
            self.contentOffset = CGPointMake(0, self.totalHeight+192 - [[UIScreen mainScreen] bounds].size.height);
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

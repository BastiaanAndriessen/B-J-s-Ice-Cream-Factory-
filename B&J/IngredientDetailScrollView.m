//
//  IngredientDetailScrollView.m
//  B&J
//
//  Created by Bastiaan Andriessen on 30/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "IngredientDetailScrollView.h"
#import <QuartzCore/QuartzCore.h>
#import "IngredientSoloView.h"

@implementation IngredientDetailScrollView

@synthesize loading = _loading;
@synthesize totalHeight = _totalHeight;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.totalHeight = 10;
        
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

-(void)loadIngredientsWithIds:(NSString*)ids ingredients:(NSArray*)ingredients newIngredients:(NSArray*)newIngredients{
    NSArray *arrIngredientIds = [ids componentsSeparatedByString: @","];
    //TODO OMGEKEERDE FOR (zodat ingredienten kloppen)
    for(int i = 0; i<[arrIngredientIds count]; i++){
        NSString *ingredientId = [arrIngredientIds objectAtIndex:i];
        NSString *firstCharIngredientId = [ingredientId substringToIndex:1];
        if([firstCharIngredientId isEqualToString:@"m"]){
            //mix ingredient
            NSString *editedIngredientId = [ingredientId stringByReplacingOccurrencesOfString:@"m" withString:@""];
            for(int j = 0; j<[newIngredients count]; j++){
                if([editedIngredientId isEqualToString:[[newIngredients objectAtIndex:j] objectForKey:@"id"]]){
                    NSString *concatenatedIngredientIds = [[newIngredients objectAtIndex:j] objectForKey:@"ingredient_ids"];
                    NSArray *ingredientIds = [concatenatedIngredientIds componentsSeparatedByString: @","];
                    NSDictionary *ingredientData = [newIngredients objectAtIndex:j];
                    NSDictionary *component1Data;
                    NSDictionary *component2Data;
                    for(int k = 0; k<[ingredients count]; k++){
                        if([[ingredientIds objectAtIndex:0] isEqualToString:[[ingredients objectAtIndex:k] objectForKey:@"id"]]){
                            component1Data = [ingredients objectAtIndex:k];
                        }else if([[ingredientIds objectAtIndex:1] isEqualToString:[[ingredients objectAtIndex:k] objectForKey:@"id"]]){
                            component2Data = [ingredients objectAtIndex:k];
                        }
                    }
                    IngredientSoloView *ingredientSoloV = [[IngredientSoloView alloc] initWithFrame:CGRectMake(12, 5+(i*162), 295, 197) ingredientData:ingredientData component1Data:component1Data component2Data:component2Data];
                    [self addSubview:ingredientSoloV];
                }
            }
        }else{
            //normal ingredient
            for(int j = 0; j<[ingredients count]; j++){
                if([ingredientId isEqualToString:[[ingredients objectAtIndex:j] objectForKey:@"id"]]){
                    IngredientSoloView *ingredientSoloV = [[IngredientSoloView alloc] initWithFrame:CGRectMake(12, 5+(i*162), 295, 197) ingredientData:[ingredients objectAtIndex:j]];
                    [self addSubview:ingredientSoloV];
                }
            }
        }
        self.totalHeight += 162;
    }
    self.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, self.totalHeight);
    [self.loading removeFromSuperview];
}

//scroll control
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.contentOffset.y < 0){
        self.contentOffset = CGPointMake(0, 0);
    }
    if(self.totalHeight+172 > [[UIScreen mainScreen] bounds].size.height){
        if(self.contentOffset.y > self.totalHeight+172 - [[UIScreen mainScreen] bounds].size.height){
            self.contentOffset = CGPointMake(0, self.totalHeight+172 - [[UIScreen mainScreen] bounds].size.height);
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

//
//  IngredientOverlayView.m
//  B&J
//
//  Created by Bastiaan Andriessen on 24/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "IngredientOverlayView.h"
#import "Ingredient.h"
#import "IngredientView.h"

@implementation IngredientOverlayView

@synthesize ingredientDataObject = _ingredientDataObject;
@synthesize btnReturn = _btnReturn;
@synthesize ingredientV = _ingredientV;

- (id)initWithFrame:(CGRect)frame ingredientDataObject:(Ingredient*)ingredientDataObject
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.ingredientDataObject = ingredientDataObject;
        NSString *pathOverlayBg = [[NSBundle mainBundle] pathForResource:@"overlay" ofType:@"png" inDirectory:@"images/views/tastemixer"];
        UIImage *overlayBg = [[UIImage alloc] initWithContentsOfFile:pathOverlayBg];
        UIImageView *imgOverlay = [[UIImageView alloc] initWithImage:overlayBg];
        [self addSubview:imgOverlay];
        
        self.ingredientV = [[IngredientView alloc] initWithFrame:CGRectMake(1, 1, 140, 125) andIngredientDataObject:self.ingredientDataObject];
        self.ingredientV.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - self.ingredientV.frame.size.width/2, [[UIScreen mainScreen] bounds].size.height/2 - self.ingredientV.frame.size.height/2 - 50, self.ingredientV.frame.size.width, self.ingredientV.frame.size.height);
        self.ingredientV.backgroundColor = [UIColor colorWithRed:0.83f green:0.18f blue:0.44f alpha:1.00f];
        [self addSubview:self.ingredientV];
        
        //BtnSubmit
        NSString *pathReturnBg = [[NSBundle mainBundle] pathForResource:@"return" ofType:@"png" inDirectory:@"images/views/tastemixer/buttons"];
        UIImage *returnBg = [[UIImage alloc] initWithContentsOfFile:pathReturnBg];
        self.btnReturn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnReturn.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - returnBg.size.width/2, self.ingredientV.frame.origin.y + self.ingredientV.frame.size.height + 7, returnBg.size.width, returnBg.size.height);
        [self.btnReturn setBackgroundImage:returnBg forState:UIControlStateNormal];
        [self.btnReturn setTitle:[@"return" uppercaseString] forState:UIControlStateNormal];
        [[self.btnReturn titleLabel] setFont:[UIFont fontWithName:@"ChunkFive-Roman" size:17]];
        [self.btnReturn setTitleColor:[UIColor colorWithRed:1.00f green:0.85f blue:0.27f alpha:1.00f] forState:UIControlStateNormal];
        [self.btnReturn setTitleColor:[UIColor colorWithRed:1.00f green:0.93f blue:0.58f alpha:1.00f] forState:UIControlStateHighlighted];
        [self addSubview:self.btnReturn];
        [self.btnReturn addTarget:self action:@selector(backToMixer:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)backToMixer:(id)sender{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished){
        if(finished){
            [self removeFromSuperview];
        }
    }];
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

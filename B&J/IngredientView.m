//
//  IngredientView.m
//  B&J
//
//  Created by Bastiaan Andriessen on 24/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "IngredientView.h"
#import "Ingredient.h"

@implementation IngredientView

@synthesize ingredientDataObject = _ingredientDataObject;

- (id)initWithFrame:(CGRect)frame andIngredientDataObject:(Ingredient*)ingredientDataObject
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.ingredientDataObject = ingredientDataObject;
        
        if(!self.ingredientDataObject.isIngredientMixed){
            //normal ingredient
            
            //imgIngredient
            NSString *pathIngredient = [[NSBundle mainBundle] pathForResource:self.ingredientDataObject.url ofType:@"png" inDirectory:@"images/views/ingredients/large"];
            UIImage *imageIngredient = [[UIImage alloc] initWithContentsOfFile:pathIngredient];
            UIImageView *imgIngredient = [[UIImageView alloc] initWithImage:imageIngredient];
            [imgIngredient setFrame:CGRectMake(self.frame.size.width/2 - imageIngredient.size.width/2, 12, imageIngredient.size.width, imageIngredient.size.height)];
            [self addSubview:imgIngredient];
        }else{
            //mixed ingredient
            
            //imgBgShape
            NSString *pathBgShape = [[NSBundle mainBundle] pathForResource:@"background" ofType:@"png" inDirectory:@"images/views/ingredients"];
            UIImage *imageBgShape = [[UIImage alloc] initWithContentsOfFile:pathBgShape];
            UIImageView *imgBgShape = [[UIImageView alloc] initWithImage:imageBgShape];
            [imgBgShape setFrame:CGRectMake(self.frame.size.width/2 - imageBgShape.size.width/2, 12, imageBgShape.size.width, imageBgShape.size.height)];
            [self addSubview:imgBgShape];
            //label component 1
            UILabel *lblComponent1 = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 118/2, 16, 118, 11)];
            lblComponent1.text = [self.ingredientDataObject.nameComponent1 uppercaseString];
            lblComponent1.backgroundColor = [UIColor clearColor];
            lblComponent1.textAlignment = NSTextAlignmentCenter;
            lblComponent1.textColor = [UIColor colorWithRed:0.83f green:0.18f blue:0.44f alpha:1.00f];
            lblComponent1.font = [UIFont fontWithName:@"Helvetica-Bold" size:9];
            [self addSubview:lblComponent1];
            //img component 1
            NSString *pathComponent1 = [[NSBundle mainBundle] pathForResource:self.ingredientDataObject.urlComponent1 ofType:@"png" inDirectory:@"images/views/ingredients/small"];
            UIImage *imageComponent1 = [[UIImage alloc] initWithContentsOfFile:pathComponent1];
            UIImageView *imgComponent1 = [[UIImageView alloc] initWithImage:imageComponent1];
            [imgComponent1 setFrame:CGRectMake(self.frame.size.width/2 - imageComponent1.size.width/2, 29, imageComponent1.size.width, imageComponent1.size.height)];
            [self addSubview:imgComponent1];
            //label component 2
            UILabel *lblComponent2 = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 118/2, 58, 118, 11)];
            lblComponent2.text = [self.ingredientDataObject.nameComponent2 uppercaseString];
            lblComponent2.backgroundColor = [UIColor clearColor];
            lblComponent2.textAlignment = NSTextAlignmentCenter;
            lblComponent2.textColor = [UIColor colorWithRed:0.83f green:0.18f blue:0.44f alpha:1.00f];
            lblComponent2.font = [UIFont fontWithName:@"Helvetica-Bold" size:9];
            [self addSubview:lblComponent2];
            //img component 2
            NSString *pathComponent2 = [[NSBundle mainBundle] pathForResource:self.ingredientDataObject.urlComponent2 ofType:@"png" inDirectory:@"images/views/ingredients/small"];
            UIImage *imageComponent2 = [[UIImage alloc] initWithContentsOfFile:pathComponent2];
            UIImageView *imgComponent2 = [[UIImageView alloc] initWithImage:imageComponent2];
            [imgComponent2 setFrame:CGRectMake(self.frame.size.width/2 - imageComponent2.size.width/2, 72, imageComponent2.size.width, imageComponent2.size.height)];
            [self addSubview:imgComponent2];
        }
        
        //title ingredient
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 130/2, 106, 130, 11)];
        lblTitle.text = [self.ingredientDataObject.name uppercaseString];
        lblTitle.backgroundColor = [UIColor clearColor];
        lblTitle.textAlignment = NSTextAlignmentCenter;
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.font = [UIFont fontWithName:@"ChunkFive-Roman" size:12];
        [self addSubview:lblTitle];
    }
    return self;
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

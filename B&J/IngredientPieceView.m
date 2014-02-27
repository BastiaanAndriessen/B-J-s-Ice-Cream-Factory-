//
//  IngredientPieceView.m
//  B&J
//
//  Created by Bastiaan Andriessen on 23/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "IngredientPieceView.h"
#import "UIImage+AdditionalFunctionalities.h"
#import "Ingredient.h"
#import "Constants.h"
#import "UIColor_Categories.h"

@implementation IngredientPieceView

@synthesize pieceId = _pieceId;
@synthesize ingredientDataObject = _ingredientDataObject;
@synthesize btnBackground = _btnBackground;
@synthesize btnDelete = _btnDelete;

- (id)initWithFrame:(CGRect)frame ingredientDataObject:(Ingredient*)ingredientDataObject pieceId:(int)pieceId
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.pieceId = pieceId;
        self.ingredientDataObject = ingredientDataObject;
        
        //BtnBackground
        NSString *pieceId = [NSString stringWithFormat:@"part%d", self.pieceId];
        NSString *pathBg = [[NSBundle mainBundle] pathForResource:pieceId ofType:@"png" inDirectory:@"images/views/tastemixer/pieces"];
        UIImage *Bg = [[UIImage alloc] initWithContentsOfFile:pathBg];
        
        //calculate color from hex to rgb
        NSString *colorString = [NSString stringWithFormat:@"#%@", ingredientDataObject.colorCode];
        UIColor *rgbColor = [UIColor colorWithHexString:colorString];
        
        UIImage *editedBg = [Bg imageWithTint:rgbColor];
        self.btnBackground = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnBackground.frame = CGRectMake(0, 0, editedBg.size.width, editedBg.size.height);
        [self.btnBackground setBackgroundImage:editedBg forState:UIControlStateNormal];
        UIImage *editedBg2 = [Bg imageWithTint:[UIColor whiteColor]];
        [self.btnBackground setBackgroundImage:editedBg2 forState:UIControlStateHighlighted];
        [self addSubview:self.btnBackground];
        
        //BtnDelete
        NSString *pathDelete = [[NSBundle mainBundle] pathForResource:@"delete" ofType:@"png" inDirectory:@"images/views/tastemixer/buttons"];
        UIImage *delete = [[UIImage alloc] initWithContentsOfFile:pathDelete];
        self.btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnDelete.frame = CGRectMake(self.btnBackground.frame.size.width/2 - delete.size.width/2, self.btnBackground.frame.size.height/2 - delete.size.height/2, delete.size.width, delete.size.height);
        [self.btnDelete setBackgroundImage:delete forState:UIControlStateNormal];
        NSString *pathDeleteh = [[NSBundle mainBundle] pathForResource:@"deleteh" ofType:@"png" inDirectory:@"images/views/tastemixer/buttons"];
        UIImage *deleteh = [[UIImage alloc] initWithContentsOfFile:pathDeleteh];
        [self.btnDelete setBackgroundImage:deleteh forState:UIControlStateHighlighted];
        [self addSubview:self.btnDelete];
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

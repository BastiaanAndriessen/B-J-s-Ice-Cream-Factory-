//
//  IngredientSoloView.m
//  B&J
//
//  Created by Bastiaan Andriessen on 30/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "IngredientSoloView.h"

@implementation IngredientSoloView

@synthesize background = _background;
@synthesize lblTitle = _lblTitle;

@synthesize imgIngredient1 = _imgIngredient1;
@synthesize lblIngredient1 = _lblIngredient1;

@synthesize imgIngredient2 = _imgIngredient2;
@synthesize lblIngredient2 = _lblIngredient2;

- (id)initWithFrame:(CGRect)frame ingredientData:(NSDictionary*)ingredientData
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //BACKGROUND IMAGE
        NSString *pathBg = [[NSBundle mainBundle] pathForResource:@"background2" ofType:@"png" inDirectory:@"images/views/ratetastes"];
        UIImage *imageBg = [[UIImage alloc] initWithContentsOfFile:pathBg];
        self.background = [[UIImageView alloc] initWithImage:imageBg];
        [self.background setFrame:CGRectMake(0, 0, imageBg.size.width, imageBg.size.height)];
        [self addSubview:self.background];
        
        //TITLE LABEL
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, self.frame.size.width, 13)];
        self.lblTitle.text = [[NSString stringWithFormat:@"%@ ice cream",[ingredientData objectForKey:@"name"]] uppercaseString];
        self.lblTitle.backgroundColor = [UIColor clearColor];
        self.lblTitle.textAlignment = NSTextAlignmentCenter;
        self.lblTitle.textColor = [UIColor whiteColor];
        self.lblTitle.font = [UIFont fontWithName:@"ChunkFive-Roman" size:15];
        [self addSubview:self.lblTitle];
        
        //ImgIngredient1
        NSString *pathImgIngredient1 = [[NSBundle mainBundle] pathForResource:[ingredientData objectForKey:@"url"] ofType:@"png" inDirectory:@"images/views/ingredients/large"];
        UIImage *imageImgIngredient1 = [[UIImage alloc] initWithContentsOfFile:pathImgIngredient1];
        self.imgIngredient1 = [[UIImageView alloc] initWithImage:imageImgIngredient1];
        [self.imgIngredient1 setFrame:CGRectMake(19, 32, imageImgIngredient1.size.width, imageImgIngredient1.size.height)];
        [self addSubview:self.imgIngredient1];
        
        //lbl ingredient1
        self.lblIngredient1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 124, 153, 15)];
        self.lblIngredient1.text = [[ingredientData objectForKey:@"name"] uppercaseString];
        self.lblIngredient1.backgroundColor = [UIColor clearColor];
        self.lblIngredient1.textAlignment = NSTextAlignmentCenter;
        self.lblIngredient1.textColor = [UIColor whiteColor];
        self.lblIngredient1.font = [UIFont fontWithName:@"ChunkFive-Roman" size:12];
        [self addSubview:self.lblIngredient1];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame ingredientData:(NSDictionary*)ingredientData component1Data:(NSDictionary*)component1Data component2Data:(NSDictionary*)component2Data
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //BACKGROUND IMAGE
        NSString *pathBg = [[NSBundle mainBundle] pathForResource:@"background2" ofType:@"png" inDirectory:@"images/views/ratetastes"];
        UIImage *imageBg = [[UIImage alloc] initWithContentsOfFile:pathBg];
        self.background = [[UIImageView alloc] initWithImage:imageBg];
        [self.background setFrame:CGRectMake(0, 0, imageBg.size.width, imageBg.size.height)];
        [self addSubview:self.background];
        
        //TITLE LABEL
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, self.frame.size.width, 13)];
        self.lblTitle.text = [[ingredientData objectForKey:@"name"] uppercaseString];
        self.lblTitle.backgroundColor = [UIColor clearColor];
        self.lblTitle.textAlignment = NSTextAlignmentCenter;
        self.lblTitle.textColor = [UIColor whiteColor];
        self.lblTitle.font = [UIFont fontWithName:@"ChunkFive-Roman" size:15];
        [self addSubview:self.lblTitle];
        
        //ImgIngredient1
        NSString *pathImgIngredient1 = [[NSBundle mainBundle] pathForResource:[component1Data objectForKey:@"url"] ofType:@"png" inDirectory:@"images/views/ingredients/large"];
        UIImage *imageImgIngredient1 = [[UIImage alloc] initWithContentsOfFile:pathImgIngredient1];
        self.imgIngredient1 = [[UIImageView alloc] initWithImage:imageImgIngredient1];
        [self.imgIngredient1 setFrame:CGRectMake(19, 32, imageImgIngredient1.size.width, imageImgIngredient1.size.height)];
        [self addSubview:self.imgIngredient1];
        
        //lbl ingredient1
        self.lblIngredient1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 124, 153, 15)];
        self.lblIngredient1.text = [[component1Data objectForKey:@"name"] uppercaseString];
        self.lblIngredient1.backgroundColor = [UIColor clearColor];
        self.lblIngredient1.textAlignment = NSTextAlignmentCenter;
        self.lblIngredient1.textColor = [UIColor whiteColor];
        self.lblIngredient1.font = [UIFont fontWithName:@"ChunkFive-Roman" size:12];
        [self addSubview:self.lblIngredient1];
        
        //ImgIngredient2
        NSString *pathImgIngredient2 = [[NSBundle mainBundle] pathForResource:[component2Data objectForKey:@"url"] ofType:@"png" inDirectory:@"images/views/ingredients/large"];
        UIImage *imageImgIngredient2 = [[UIImage alloc] initWithContentsOfFile:pathImgIngredient2];
        self.imgIngredient2 = [[UIImageView alloc] initWithImage:imageImgIngredient2];
        [self.imgIngredient2 setFrame:CGRectMake(159, 32, imageImgIngredient2.size.width, imageImgIngredient2.size.height)];
        [self addSubview:self.imgIngredient2];
        
        //lbl ingredient2
        self.lblIngredient2 = [[UILabel alloc] initWithFrame:CGRectMake(142, 124, 153, 15)];
        self.lblIngredient2.text = [[component2Data objectForKey:@"name"] uppercaseString];
        self.lblIngredient2.backgroundColor = [UIColor clearColor];
        self.lblIngredient2.textAlignment = NSTextAlignmentCenter;
        self.lblIngredient2.textColor = [UIColor whiteColor];
        self.lblIngredient2.font = [UIFont fontWithName:@"ChunkFive-Roman" size:12];
        [self addSubview:self.lblIngredient2];
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

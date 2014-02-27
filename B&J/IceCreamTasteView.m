//
//  IceCreamTasteView.m
//  B&J
//
//  Created by Bastiaan Andriessen on 28/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "IceCreamTasteView.h"
#import "UIImage+AdditionalFunctionalities.h"
#import "UIColor_Categories.h"

@implementation IceCreamTasteView

@synthesize iceCreamId = _iceCreamId;
@synthesize ingredientIds = _ingredientIds;
@synthesize votedPeace = _votedPeace;
@synthesize votedLove = _votedLove;
@synthesize showIngredients = _showIngredients;

@synthesize lblTitle = _lblTitle;

@synthesize background = _background;
@synthesize cup = _cup;
@synthesize peace = _peace;
@synthesize love = _love;

@synthesize numPeace = _numPeace;
@synthesize numLove = _numLove;

@synthesize btnPeace = _btnPeace;
@synthesize btnLove = _btnLove;
@synthesize btnIngredients = _btnIngredients;

- (id)initWithFrame:(CGRect)frame andIceCreamDataObject:(NSDictionary*)arrIceCream andFilter:(NSString*)filter
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.iceCreamId = [arrIceCream objectForKey:@"id"];
        self.ingredientIds = [arrIceCream objectForKey:@"ingredient_ids"];
        self.votedPeace = NO;
        self.votedLove = NO;
        self.showIngredients = NO;
        self.numPeace = 0;
        self.numLove = 0;
        
        //TITLE LABEL
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 31)];
        self.lblTitle.text = [[arrIceCream objectForKey:@"name"] uppercaseString];
        self.lblTitle.backgroundColor = [UIColor clearColor];
        self.lblTitle.textAlignment = NSTextAlignmentLeft;
        self.lblTitle.textColor = [UIColor whiteColor];
        self.lblTitle.font = [UIFont fontWithName:@"ChunkFive-Roman" size:18];
        [self addSubview:self.lblTitle];
        
        //BACKGROUND IMAGE
        NSString *pathBg = [[NSBundle mainBundle] pathForResource:@"background" ofType:@"png" inDirectory:@"images/views/ratetastes"];
        UIImage *imageBg = [[UIImage alloc] initWithContentsOfFile:pathBg];
        self.background = [[UIImageView alloc] initWithImage:imageBg];
        [self.background setFrame:CGRectMake(0, 31, imageBg.size.width, imageBg.size.height)];
        [self addSubview:self.background];
        
        //CUP
        NSString *pathCup = [[NSBundle mainBundle] pathForResource:@"cup_small" ofType:@"png" inDirectory:@"images/views/ratetastes"];
        UIImage *imageCup = [[UIImage alloc] initWithContentsOfFile:pathCup];
        self.cup = [[UIImageView alloc] initWithImage:imageCup];
        [self.cup setFrame:CGRectMake(13, self.lblTitle.frame.size.height+8, imageCup.size.width, imageCup.size.height)];
        [self addSubview:self.cup];
        
        int peaceImgOffsetTop;
        int peaceBtnOffsetTop;
        int loveImgOffsetTop;
        int loveBtnOffsetTop;
        if([filter isEqualToString:@"peace"]){
            peaceImgOffsetTop = self.lblTitle.frame.size.height+17;
            peaceBtnOffsetTop = self.lblTitle.frame.size.height+9;
            loveImgOffsetTop = self.lblTitle.frame.size.height+64;
            loveBtnOffsetTop = self.lblTitle.frame.size.height+57;
        }else{
            peaceImgOffsetTop = self.lblTitle.frame.size.height+64;
            peaceBtnOffsetTop = self.lblTitle.frame.size.height+57;
            loveImgOffsetTop = self.lblTitle.frame.size.height+17;
            loveBtnOffsetTop = self.lblTitle.frame.size.height+9;
        }
        
        //PEACE
        NSString *pathPeace = [[NSBundle mainBundle] pathForResource:@"peace_small" ofType:@"png" inDirectory:@"images/views/ratetastes"];
        UIImage *imagePeace = [[UIImage alloc] initWithContentsOfFile:pathPeace];
        self.peace = [[UIImageView alloc] initWithImage:imagePeace];
        [self.peace setFrame:CGRectMake(153, peaceImgOffsetTop, imagePeace.size.width, imagePeace.size.height)];
        [self addSubview:self.peace];
        
        //LOVE
        NSString *pathLove = [[NSBundle mainBundle] pathForResource:@"love_small" ofType:@"png" inDirectory:@"images/views/ratetastes"];
        UIImage *imageLove = [[UIImage alloc] initWithContentsOfFile:pathLove];
        self.love = [[UIImageView alloc] initWithImage:imageLove];
        [self.love setFrame:CGRectMake(151, loveImgOffsetTop, imageLove.size.width, imageLove.size.height)];
        [self addSubview:self.love];
        
        NSString *pathButtonBg = [[NSBundle mainBundle] pathForResource:@"votes" ofType:@"png" inDirectory:@"images/views/ratetastes/buttons"];
        UIImage *buttonBg = [[UIImage alloc] initWithContentsOfFile:pathButtonBg];
        NSString *pathButtonBgh = [[NSBundle mainBundle] pathForResource:@"votesh" ofType:@"png" inDirectory:@"images/views/ratetastes/buttons"];
        UIImage *buttonBgh = [[UIImage alloc] initWithContentsOfFile:pathButtonBgh];
        
        //BTN PEACE
        self.btnPeace = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.btnPeace setBackgroundImage:buttonBg forState:UIControlStateNormal];
        [self.btnPeace setBackgroundImage:buttonBgh forState:UIControlStateHighlighted];
        self.btnPeace.frame = CGRectMake(194, peaceBtnOffsetTop, buttonBg.size.width, buttonBg.size.height);
        [self.btnPeace setTitle:[[arrIceCream objectForKey:@"peace"] uppercaseString] forState:UIControlStateNormal];
        [[self.btnPeace titleLabel] setFont:[UIFont fontWithName:@"ChunkFive-Roman" size:21]];
        [self.btnPeace setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.btnPeace];
        [self.btnPeace addTarget:self action:@selector(votePeace:) forControlEvents:UIControlEventTouchUpInside];
        self.numPeace = [[arrIceCream objectForKey:@"peace"] intValue];
        
        //BTN LOVE
        self.btnLove = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.btnLove setBackgroundImage:buttonBg forState:UIControlStateNormal];
        [self.btnLove setBackgroundImage:buttonBgh forState:UIControlStateHighlighted];
        self.btnLove.frame = CGRectMake(194, loveBtnOffsetTop, buttonBg.size.width, buttonBg.size.height);
        [self.btnLove setTitle:[[arrIceCream objectForKey:@"love"] uppercaseString] forState:UIControlStateNormal];
        [[self.btnLove titleLabel] setFont:[UIFont fontWithName:@"ChunkFive-Roman" size:21]];
        [self.btnLove setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.btnLove];
        [self.btnLove addTarget:self action:@selector(voteLove:) forControlEvents:UIControlEventTouchUpInside];
        self.numLove = [[arrIceCream objectForKey:@"love"] intValue];
        
        //BTN INGREDIENTS
        NSString *pathIngredientBg = [[NSBundle mainBundle] pathForResource:@"ingredients" ofType:@"png" inDirectory:@"images/views/ratetastes/buttons"];
        UIImage *ingredientBg = [[UIImage alloc] initWithContentsOfFile:pathIngredientBg];
        self.btnIngredients = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnIngredients.frame = CGRectMake(137, self.lblTitle.frame.size.height+107, ingredientBg.size.width, ingredientBg.size.height);
        [self.btnIngredients setBackgroundImage:ingredientBg forState:UIControlStateNormal];
        NSString *pathIngredientBgh = [[NSBundle mainBundle] pathForResource:@"ingredientsh" ofType:@"png" inDirectory:@"images/views/ratetastes/buttons"];
        UIImage *ingredientBgh = [[UIImage alloc] initWithContentsOfFile:pathIngredientBgh];
        [self.btnIngredients setBackgroundImage:ingredientBgh forState:UIControlStateHighlighted];
        [self.btnIngredients setTitle:[@"ingredients" uppercaseString] forState:UIControlStateNormal];
        [[self.btnIngredients titleLabel] setFont:[UIFont fontWithName:@"ChunkFive-Roman" size:14]];
        [self.btnIngredients setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.btnIngredients];
        [self.btnIngredients addTarget:self action:@selector(showIngredients:) forControlEvents:UIControlEventTouchUpInside];
        
        
        NSString *concatenatedColorCodes = [arrIceCream objectForKey:@"color_codes"];
        NSArray *arrColorCodes = [concatenatedColorCodes componentsSeparatedByString: @","];
        
        for(int i = 0; i < [arrColorCodes count]; i++){
            NSString *pathPartBg = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"part%d_small",i+1] ofType:@"png" inDirectory:@"images/views/ratetastes/pieces"];
            UIImage *partBg = [[UIImage alloc] initWithContentsOfFile:pathPartBg];
            
            //color conversion
            NSString *colorString = [NSString stringWithFormat:@"#%@",[arrColorCodes objectAtIndex:i]];
            UIColor *rgbColor = [UIColor colorWithHexString:colorString];
            
            UIImage *editedPartBg = [partBg imageWithTint:rgbColor];
            UIImageView *partImgV = [[UIImageView alloc] initWithImage:editedPartBg];
            switch (i) {
                default:
                case 0:
                    partImgV.frame = CGRectMake(30, self.lblTitle.frame.size.height+121, editedPartBg.size.width, editedPartBg.size.height);
                    break;
                case 1:
                    partImgV.frame = CGRectMake(28, self.lblTitle.frame.size.height+96, editedPartBg.size.width, editedPartBg.size.height);
                    break;
                case 2:
                    partImgV.frame = CGRectMake(25, self.lblTitle.frame.size.height+71, editedPartBg.size.width, editedPartBg.size.height);
                    break;
                case 3:
                    partImgV.frame = CGRectMake(23, self.lblTitle.frame.size.height+45, editedPartBg.size.width, editedPartBg.size.height);
                    break;
                case 4:
                    partImgV.frame = CGRectMake(15, self.lblTitle.frame.size.height+20, editedPartBg.size.width, editedPartBg.size.height);
                    break;
            }
            [self addSubview:partImgV];
        }
    }
    return self;
}

-(void)votePeace:(id)sender{
    self.votedPeace = YES;
    self.numPeace++;
    [self.btnPeace setTitle:[NSString stringWithFormat:@"%d",self.numPeace] forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"VOTED_PEACE" object:nil];
}

-(void)voteLove:(id)sender{
    self.votedLove = YES;
    self.numLove++;
    [self.btnLove setTitle:[NSString stringWithFormat:@"%d",self.numLove] forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"VOTED_LOVE" object:nil];
}

-(void)showIngredients:(id)sender{
    self.showIngredients = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PREPARE_DATA_SHOW_INGREDIENTS" object:nil];
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

//
//  TasteMixerScrollView.m
//  B&J
//
//  Created by Bastiaan Andriessen on 22/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "TasteMixerScrollView.h"
#import "Constants.h"
#import "Ingredient.h"
#import "IngredientPieceView.h"
#import "IngredientOverlayView.h"

@implementation TasteMixerScrollView

@synthesize background = _background;
@synthesize cloud = _cloud;
@synthesize cloud2 = _cloud2;
@synthesize colorFrame = _colorFrame;
@synthesize btnLogo = _btnLogo;
@synthesize btnBack = _btnBack;
@synthesize btnSubmit = _btnSubmit;
@synthesize lblInfo = _lblInfo;

@synthesize timer = _timer;
@synthesize arrTips = _arrTips;

@synthesize btnAddIngredient = _btnAddIngredient;
@synthesize btnMixIngredient = _btnMixIngredient;

@synthesize numAddedIngredients = _numAddedIngredients;
@synthesize arrIngredientPieces = _arrIngredientPieces;
@synthesize arrIngredientDataObjects = _arrIngredientDataObjects;
@synthesize currentSelectedDataObject = _currentSelectedDataObject;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.numAddedIngredients = 0;
        self.arrIngredientPieces = [NSMutableArray array];
        self.arrIngredientDataObjects = [NSMutableArray array];
        
        //BACKGROUND IMAGE
        NSString *pathBg = [[NSBundle mainBundle] pathForResource:@"background" ofType:@"png" inDirectory:@"images/views"];
        UIImage *imageBg = [[UIImage alloc] initWithContentsOfFile:pathBg];
        self.background = [[UIImageView alloc] initWithImage:imageBg];
        [self.background setFrame:CGRectMake(0, 0, imageBg.size.width, imageBg.size.height)];
        [self addSubview:self.background];
        
        //CLOUDS
        NSString *pathCloud = [[NSBundle mainBundle] pathForResource:@"cloud1" ofType:@"png" inDirectory:@"images/views/clouds"];
        UIImage *imageCloud = [[UIImage alloc] initWithContentsOfFile:pathCloud];
        self.cloud = [[UIImageView alloc] initWithImage:imageCloud];
        [self.cloud setFrame:CGRectMake(imageCloud.size.width * -1, -5, imageCloud.size.width, imageCloud.size.height)];
        [self addSubview:self.cloud];
        
        NSString *pathCloud2 = [[NSBundle mainBundle] pathForResource:@"cloud2" ofType:@"png" inDirectory:@"images/views/clouds"];
        UIImage *imageCloud2 = [[UIImage alloc] initWithContentsOfFile:pathCloud2];
        self.cloud2 = [[UIImageView alloc] initWithImage:imageCloud2];
        [self.cloud2 setFrame:CGRectMake(imageCloud2.size.width * -1, 35, imageCloud2.size.width, imageCloud2.size.height)];
        [self addSubview:self.cloud2];
        
        [self cloudAnimationWithDelay:0 objectToAnimate:self.cloud duration:40];
        [self cloudAnimationWithDelay:25 objectToAnimate:self.cloud2 duration:28];
        
        //COLOR FRAME
        NSString *pathColorFrame = [[NSBundle mainBundle] pathForResource:@"frame" ofType:@"png" inDirectory:@"images/views/tastemixer"];
        UIImage *imageColorFrame = [[UIImage alloc] initWithContentsOfFile:pathColorFrame];
        self.colorFrame = [[UIImageView alloc] initWithImage:imageColorFrame];
        [self.colorFrame setFrame:CGRectMake(0, BackFrameOffsetTop, imageColorFrame.size.width, imageColorFrame.size.height)];
        [self addSubview:self.colorFrame];
        
        //BtnLOGO
        NSString *pathLogoBg = [[NSBundle mainBundle] pathForResource:@"logo" ofType:@"png" inDirectory:@"images/views"];
        UIImage *logoBg = [[UIImage alloc] initWithContentsOfFile:pathLogoBg];
        self.btnLogo = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnLogo.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - logoBg.size.width/2, TopLogoOffsetTop, logoBg.size.width, logoBg.size.height);
        [self.btnLogo setBackgroundImage:logoBg forState:UIControlStateNormal];
        NSString *pathLogoBgh = [[NSBundle mainBundle] pathForResource:@"logoh" ofType:@"png" inDirectory:@"images/views"];
        UIImage *logoBgh = [[UIImage alloc] initWithContentsOfFile:pathLogoBgh];
        [self.btnLogo setBackgroundImage:logoBgh forState:UIControlStateHighlighted];
        [self addSubview:self.btnLogo];
        [self.btnLogo addTarget:self action:@selector(goToSite:) forControlEvents:UIControlEventTouchUpInside];
        
        //BtnBACK
        NSString *pathBackBg = [[NSBundle mainBundle] pathForResource:@"mainmenu_small" ofType:@"png" inDirectory:@"images/views/buttons/mainmenu"];
        UIImage *backBg = [[UIImage alloc] initWithContentsOfFile:pathBackBg];
        self.btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnBack.frame = CGRectMake(TopButtonLeftOffsetLeft, TopButtonOffsetTop, backBg.size.width, backBg.size.height);
        [self.btnBack setBackgroundImage:backBg forState:UIControlStateNormal];
        NSString *pathBackBgh = [[NSBundle mainBundle] pathForResource:@"mainmenu_smallh" ofType:@"png" inDirectory:@"images/views/buttons/mainmenu"];
        UIImage *backBgh = [[UIImage alloc] initWithContentsOfFile:pathBackBgh];
        [self.btnBack setBackgroundImage:backBgh forState:UIControlStateHighlighted];
        [self.btnBack setTitle:[@"menu" uppercaseString] forState:UIControlStateNormal];
        [[self.btnBack titleLabel] setFont:[UIFont fontWithName:@"ChunkFive-Roman" size:TopButtonFontSize]];
        [self.btnBack setTitleColor:[UIColor colorWithRed:0.20f green:0.67f blue:0.31f alpha:1.00f] forState:UIControlStateNormal];
        [self addSubview:self.btnBack];
        [self.btnBack addTarget:self action:@selector(backToMainMenu:) forControlEvents:UIControlEventTouchUpInside];
        
        //BtnSubmit
        NSString *pathSubmitBg = [[NSBundle mainBundle] pathForResource:@"submit_small" ofType:@"png" inDirectory:@"images/views/buttons/submit"];
        UIImage *submitBg = [[UIImage alloc] initWithContentsOfFile:pathSubmitBg];
        self.btnSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnSubmit.frame = CGRectMake(TopButtonRightOffsetLeft, TopButtonOffsetTop, submitBg.size.width, submitBg.size.height);
        [self.btnSubmit setBackgroundImage:submitBg forState:UIControlStateNormal];
        NSString *pathSubmitBgh = [[NSBundle mainBundle] pathForResource:@"submit_smallh" ofType:@"png" inDirectory:@"images/views/buttons/submit"];
        UIImage *submitBgh = [[UIImage alloc] initWithContentsOfFile:pathSubmitBgh];
        [self.btnSubmit setBackgroundImage:submitBgh forState:UIControlStateHighlighted];
        [self.btnSubmit setTitle:[@"submit" uppercaseString] forState:UIControlStateNormal];
        [[self.btnSubmit titleLabel] setFont:[UIFont fontWithName:@"ChunkFive-Roman" size:TopButtonFontSize]];
        [self.btnSubmit setTitleColor:[UIColor colorWithRed:0.98f green:0.42f blue:0.64f alpha:1.00f] forState:UIControlStateNormal];
        [self addSubview:self.btnSubmit];
        [self.btnSubmit addTarget:self action:@selector(submitIceCream:) forControlEvents:UIControlEventTouchUpInside];
        self.btnSubmit.alpha = 0.5;
        
        //INFO LABEL
        self.lblInfo = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 295/2, self.btnBack.frame.origin.y + self.btnBack.frame.size.height + 10, 295, 10)];
        self.lblInfo.text = [@"Tip: Tap the ingredients to see the ingredients’ name" uppercaseString];
        self.lblInfo.backgroundColor = [UIColor clearColor];
        self.lblInfo.textAlignment = NSTextAlignmentCenter;
        self.lblInfo.textColor = [UIColor whiteColor];
        self.lblInfo.font = [UIFont fontWithName:@"Helvetica-Bold" size:9];
        [self addSubview:self.lblInfo];
        self.arrTips = [NSArray arrayWithObjects:@"Tip: Tap the ingredients to see the ingredients’ name",@"Tip: The cup needs to be full to submit",@"Tip: Chocolate fudge is sooooo good",nil];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(setRandomTip:) userInfo:nil repeats:YES];
        
        //BtnAddIngredient
        NSString *pathAddBg = [[NSBundle mainBundle] pathForResource:@"add" ofType:@"png" inDirectory:@"images/views/tastemixer/buttons"];
        UIImage *addBg = [[UIImage alloc] initWithContentsOfFile:pathAddBg];
        self.btnAddIngredient = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnAddIngredient.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - addBg.size.width/2, 472, addBg.size.width, addBg.size.height);
        [self.btnAddIngredient setBackgroundImage:addBg forState:UIControlStateNormal];
        NSString *pathAddBgh = [[NSBundle mainBundle] pathForResource:@"addh" ofType:@"png" inDirectory:@"images/views/tastemixer/buttons"];
        UIImage *addBgh = [[UIImage alloc] initWithContentsOfFile:pathAddBgh];
        [self.btnAddIngredient setBackgroundImage:addBgh forState:UIControlStateHighlighted];
        [self addSubview:self.btnAddIngredient];
        [self.btnAddIngredient addTarget:self action:@selector(showAddIngredient:) forControlEvents:UIControlEventTouchUpInside];
        
        //BtnMixIngredient
        NSString *pathMixBg = [[NSBundle mainBundle] pathForResource:@"mix" ofType:@"png" inDirectory:@"images/views/tastemixer/buttons"];
        UIImage *mixBg = [[UIImage alloc] initWithContentsOfFile:pathMixBg];
        self.btnMixIngredient = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnMixIngredient.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - mixBg.size.width/2, self.btnAddIngredient.frame.origin.y + self.btnAddIngredient.frame.size.height + 10, mixBg.size.width, mixBg.size.height);
        [self.btnMixIngredient setBackgroundImage:mixBg forState:UIControlStateNormal];
        NSString *pathMixBgh = [[NSBundle mainBundle] pathForResource:@"mixh" ofType:@"png" inDirectory:@"images/views/tastemixer/buttons"];
        UIImage *mixBgh = [[UIImage alloc] initWithContentsOfFile:pathMixBgh];
        [self.btnMixIngredient setBackgroundImage:mixBgh forState:UIControlStateHighlighted];
        [self addSubview:self.btnMixIngredient];
        [self.btnMixIngredient addTarget:self action:@selector(showMixIngredient:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)setRandomTip:(id)sender{
    [UIView animateWithDuration:0.75 delay:0 options:UIViewAnimationOptionLayoutSubviews  animations:^{
        self.lblInfo.alpha = 0;
    } completion:^(BOOL finished){
        if(finished){
            for(NSInteger i = 0; i<300; i++)
            {
                float newRandomIndex = (arc4random() % [self.arrTips count]);
                if(![[[self.arrTips objectAtIndex:newRandomIndex] uppercaseString] isEqualToString:self.lblInfo.text]){
                    self.lblInfo.textColor = [UIColor whiteColor];
                    self.lblInfo.text = [[self.arrTips objectAtIndex:newRandomIndex] uppercaseString];
                    [UIView animateWithDuration:0.75 delay:0 options:UIViewAnimationOptionLayoutSubviews  animations:^{
                        self.lblInfo.alpha = 1;
                    } completion:NULL];
                    break;
                }
            }
        }
    }];
}

-(void)resetAnimations{    
    [self cloudAnimationWithDelay:0 objectToAnimate:self.cloud duration:40];
    [self cloudAnimationWithDelay:25 objectToAnimate:self.cloud2 duration:28];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(setRandomTip:) userInfo:nil repeats:YES];
}

//tap logo
-(void)goToSite:(id)sender{
    NSURL *url = [ [ NSURL alloc ] initWithString: @"http://www.benjerry.com/" ];
    [[UIApplication sharedApplication] openURL:url];
}

//animate clouds - constant animation
-(void)cloudAnimationWithDelay:(float)delay objectToAnimate:(UIImageView*)object duration:(float)duration
{
    [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear  animations:^{
        [object setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width, self.cloud.frame.origin.y, self.cloud.frame.size.width, self.cloud.frame.size.height)];
    } completion:^(BOOL finished){
        if(finished){
            [object setFrame:CGRectMake(self.cloud.frame.size.width * -1, self.cloud.frame.origin.y, self.cloud.frame.size.width, self.cloud.frame.size.height)];
            [self cloudAnimationWithDelay:delay objectToAnimate:object duration:duration];
        }
    }];
}

//Top buttons
-(void)backToMainMenu:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BACK_TO_MAIN" object:nil];
}

-(void)submitIceCream:(id)sender{
    if(self.btnSubmit.alpha != 1){
        self.lblInfo.text = [self.arrTips[1] uppercaseString];
        [self.lblInfo setTextColor:[UIColor colorWithRed:0.76f green:0.16f blue:0.41f alpha:1.00f]];
        [self.timer invalidate];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(setRandomTip:) userInfo:nil repeats:YES];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SAVE_NEW_TASTE" object:nil];
    }
}

//ingredient visualization
-(void)addIngredient:(Ingredient*)ingredientDataObject{
    self.numAddedIngredients++;
    [self.arrIngredientDataObjects addObject:ingredientDataObject];
    
    if(self.numAddedIngredients == 5){
        [self.btnAddIngredient setEnabled:NO];
        [self.btnMixIngredient setEnabled:NO];
        self.btnSubmit.alpha = 1;
    }
    
    int backgroundTopOffset = 0;
    switch(self.numAddedIngredients){
        default:
        case 1:
            backgroundTopOffset = Ingredient1OffsetTop;
            break;
        case 2:
            backgroundTopOffset = Ingredient2OffsetTop;
            break;
        case 3:
            backgroundTopOffset = Ingredient3OffsetTop;
            break;
        case 4:
            backgroundTopOffset = Ingredient4OffsetTop;
            break;
        case 5:
            backgroundTopOffset = Ingredient5OffsetTop;
            break;
    }
    
    IngredientPieceView *ingredientView = [[IngredientPieceView alloc] initWithFrame:CGRectMake(20, 20, 20, 20) ingredientDataObject:ingredientDataObject pieceId:self.numAddedIngredients];
    ingredientView.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - ingredientView.btnBackground.frame.size.width/2, backgroundTopOffset, ingredientView.btnBackground.frame.size.width, ingredientView.btnBackground.frame.size.height);
    [ingredientView.btnDelete addTarget:self action:@selector(deleteIngredient:) forControlEvents:UIControlEventTouchUpInside];
    [ingredientView.btnBackground addTarget:self action:@selector(showIngredientDetail:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:ingredientView];
    [self.arrIngredientPieces addObject:ingredientView];
}

-(void)deleteIngredient:(id)sender{
    self.btnSubmit.alpha = .5;
    [self.btnAddIngredient setEnabled:YES];
    [self.btnMixIngredient setEnabled:YES];
    for(int i = 0; i<[self.arrIngredientPieces count]; i++){
        IngredientPieceView *currentEl = ((IngredientPieceView*)[self.arrIngredientPieces objectAtIndex:i]);
        UIButton *deleteButton = currentEl.btnDelete;
        if(sender == deleteButton){
            [self.arrIngredientDataObjects removeObjectAtIndex:i];
        }
        [currentEl removeFromSuperview];
    }
    self.numAddedIngredients = [self.arrIngredientDataObjects count];
    [self reloadIngredientPieces];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DELETE_INGREDIENT" object:nil];
}

-(void)reloadIngredientPieces{
    self.arrIngredientPieces = [NSMutableArray array];
    for(int i=0; i<[self.arrIngredientDataObjects count]; i++){
        int backgroundTopOffset = 0;
        switch(i+1){
            default:
            case 1:
                backgroundTopOffset = Ingredient1OffsetTop;
                break;
            case 2:
                backgroundTopOffset = Ingredient2OffsetTop;
                break;
            case 3:
                backgroundTopOffset = Ingredient3OffsetTop;
                break;
            case 4:
                backgroundTopOffset = Ingredient4OffsetTop;
                break;
            case 5:
                backgroundTopOffset = Ingredient5OffsetTop;
                break;
        }
        
        IngredientPieceView *ingredientView = [[IngredientPieceView alloc] initWithFrame:CGRectMake(20, 20, 20, 20) ingredientDataObject:[self.arrIngredientDataObjects objectAtIndex:i] pieceId:i+1];
        ingredientView.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - ingredientView.btnBackground.frame.size.width/2, backgroundTopOffset, ingredientView.btnBackground.frame.size.width, ingredientView.btnBackground.frame.size.height);
        [ingredientView.btnDelete addTarget:self action:@selector(deleteIngredient:) forControlEvents:UIControlEventTouchUpInside];
        [ingredientView.btnBackground addTarget:self action:@selector(showIngredientDetail:) forControlEvents:UIControlEventTouchUpInside];
        [self.arrIngredientPieces addObject:ingredientView];
        [self addSubview:ingredientView];
    }
}

-(void)showIngredientDetail:(id)sender{
    for(int i = 0; i<[self.arrIngredientPieces count]; i++){
        IngredientPieceView *currentEl = ((IngredientPieceView*)[self.arrIngredientPieces objectAtIndex:i]);
        UIButton *backgroundButton = currentEl.btnBackground;
        if(sender == backgroundButton){
            self.currentSelectedDataObject = currentEl.ingredientDataObject;
            IngredientOverlayView *ingredientOverlayV = [[IngredientOverlayView alloc] initWithFrame:CGRectMake(1, 1, 1, 1) ingredientDataObject:self.currentSelectedDataObject];
            ingredientOverlayV.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
            ingredientOverlayV.alpha = 0;
            [self addSubview:ingredientOverlayV];
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                ingredientOverlayV.alpha = 1;
            } completion:^(BOOL finished){}];
        }
    }
}

//Bottom Buttons
-(void)showAddIngredient:(id)sender{
    [self.timer invalidate];
    self.timer = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOW_ADD_INGREDIENT" object:nil];
}

-(void)showMixIngredient:(id)sender{
    [self.timer invalidate];
    self.timer = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOW_MIX_INGREDIENT" object:nil];
}

//scroll control
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.contentOffset.y < 0){
        self.contentOffset = CGPointMake(0, 0);
    }
    if(self.background.frame.size.height > [[UIScreen mainScreen] bounds].size.height){
        if(self.contentOffset.y > self.background.frame.size.height - [[UIScreen mainScreen] bounds].size.height){
            self.contentOffset = CGPointMake(0, self.background.frame.size.height - [[UIScreen mainScreen] bounds].size.height);
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

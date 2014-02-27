//
//  MixIngredientScrollView.m
//  B&J
//
//  Created by Bastiaan Andriessen on 25/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "MixIngredientScrollView.h"
#import "Constants.h"
#import "UIImage+AdditionalFunctionalities.h"
#import "UIColor_Categories.h"
#import <QuartzCore/QuartzCore.h>

@implementation MixIngredientScrollView

@synthesize background = _background;
@synthesize cloud = _cloud;
@synthesize cloud2 = _cloud2;
@synthesize colorFrame = _colorFrame;
@synthesize btnLogo = _btnLogo;
@synthesize btnBack = _btnBack;
@synthesize txtInfo = _txtInfo;

@synthesize currentSelectingIngredient = _currentSelectingIngredient;
@synthesize selectedIngredient1Btn = _selectedIngredient1Btn;
@synthesize selectedIngredient1 = _selectedIngredient1;
@synthesize selectedIngredient2Btn = _selectedIngredient2Btn;
@synthesize selectedIngredient2 = _selectedIngredient2;

@synthesize mixBoard = _mixBoard;
@synthesize mixBoardOverlay = _mixBoardOverlay;
@synthesize blade = _blade;
@synthesize progressBarV = _progressBarV;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
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
        NSString *pathColorFrame = [[NSBundle mainBundle] pathForResource:@"neutralframe" ofType:@"png" inDirectory:@"images/views/tastemixer"];
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
        NSString *pathBackBg = [[NSBundle mainBundle] pathForResource:@"tastemixer_wide" ofType:@"png" inDirectory:@"images/views/buttons/tastemixer"];
        UIImage *backBg = [[UIImage alloc] initWithContentsOfFile:pathBackBg];
        self.btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnBack.frame = CGRectMake(TopButtonLeftOffsetLeft, TopButtonOffsetTop, backBg.size.width, backBg.size.height);
        [self.btnBack setBackgroundImage:backBg forState:UIControlStateNormal];
        NSString *pathBackBgh = [[NSBundle mainBundle] pathForResource:@"tastemixer_wideh" ofType:@"png" inDirectory:@"images/views/buttons/tastemixer"];
        UIImage *backBgh = [[UIImage alloc] initWithContentsOfFile:pathBackBgh];
        [self.btnBack setBackgroundImage:backBgh forState:UIControlStateHighlighted];
        [self.btnBack setTitle:[@"taste mixer" uppercaseString] forState:UIControlStateNormal];
        [[self.btnBack titleLabel] setFont:[UIFont fontWithName:@"ChunkFive-Roman" size:TopButtonFontSize]];
        [self.btnBack setTitleColor:[UIColor colorWithRed:0.95f green:0.30f blue:0.56f alpha:1.00f] forState:UIControlStateNormal];
        [self addSubview:self.btnBack];
        [self.btnBack addTarget:self action:@selector(backToMixer:) forControlEvents:UIControlEventTouchUpInside];
        
        //INFO LABEL        
        self.txtInfo = [[UITextView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 250/2, self.btnBack.frame.origin.y + self.btnBack.frame.size.height, 250, 30)];
        self.txtInfo.userInteractionEnabled = NO;
        self.txtInfo.text = [@"Select the ingredients you want to mix, then Shake the device to mix the ingredients" uppercaseString];
        self.txtInfo.backgroundColor = [UIColor clearColor];
        self.txtInfo.textAlignment = NSTextAlignmentCenter;
        self.txtInfo.textColor = [UIColor whiteColor];
        self.txtInfo.font = [UIFont fontWithName:@"Helvetica-Bold" size:9];
        [self addSubview:self.txtInfo];
        
        //Ingredient button 1
        NSString *pathIngredient1 = [[NSBundle mainBundle] pathForResource:@"default1" ofType:@"png" inDirectory:@"images/views/ingredients/medium"];
        UIImage *ingredient1 = [[UIImage alloc] initWithContentsOfFile:pathIngredient1];
        self.selectedIngredient1Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.selectedIngredient1Btn.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - ingredient1.size.width - 5, self.txtInfo.frame.origin.y + self.txtInfo.frame.size.height + 10, ingredient1.size.width, ingredient1.size.height);
        [self.selectedIngredient1Btn setBackgroundImage:ingredient1 forState:UIControlStateNormal];
        [self.selectedIngredient1Btn addTarget:self action:@selector(selectIngredient1:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.selectedIngredient1Btn];
        
        //Ingredient button 2
        NSString *pathIngredient2 = [[NSBundle mainBundle] pathForResource:@"default2" ofType:@"png" inDirectory:@"images/views/ingredients/medium"];
        UIImage *ingredient2 = [[UIImage alloc] initWithContentsOfFile:pathIngredient2];
        self.selectedIngredient2Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.selectedIngredient2Btn.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 + 5, self.txtInfo.frame.origin.y + self.txtInfo.frame.size.height + 10, ingredient2.size.width, ingredient2.size.height);
        [self.selectedIngredient2Btn setBackgroundImage:ingredient2 forState:UIControlStateNormal];
        [self.selectedIngredient2Btn addTarget:self action:@selector(selectIngredient2:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.selectedIngredient2Btn];
        
        //Mixboard
        NSString *pathMixBoard = [[NSBundle mainBundle] pathForResource:@"mixboard" ofType:@"png" inDirectory:@"images/views/tastemixer/mixerparts"];
        UIImage *imagemMixBoard = [[UIImage alloc] initWithContentsOfFile:pathMixBoard];
        self.mixBoard = [[UIImageView alloc] initWithImage:imagemMixBoard];
        [self.mixBoard setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - imagemMixBoard.size.width/2, self.selectedIngredient1Btn.frame.origin.y + self.selectedIngredient1Btn.frame.size.height + 10, imagemMixBoard.size.width, imagemMixBoard.size.height)];
        [self addSubview:self.mixBoard];
        
        //Blade
        NSString *pathBlade = [[NSBundle mainBundle] pathForResource:@"blades" ofType:@"png" inDirectory:@"images/views/tastemixer/mixerparts"];
        UIImage *imageBlade = [[UIImage alloc] initWithContentsOfFile:pathBlade];
        self.blade = [[UIImageView alloc] initWithImage:imageBlade];
        [self.blade setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - imageBlade.size.width/2, self.mixBoard.frame.origin.y + 11, imageBlade.size.width, imageBlade.size.height)];
        [self addSubview:self.blade];
        
        //progressBar
        self.progressBarV = [[ProgressBarView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 322/2, self.mixBoard.frame.origin.y + self.mixBoard.frame.size.height + 2, self.progressBarV.imgProgressBar.frame.size.width + 22, self.progressBarV.imgProgressMarker.frame.origin.y + self.progressBarV.imgProgressMarker.frame.size.height)];
        [self addSubview:self.progressBarV];
    }
    return self;
}

-(void)setMixBoardOverlayColor:(NSString*)colorCode{
    [self.mixBoardOverlay removeFromSuperview];
    NSString *pathMixBoard = [[NSBundle mainBundle] pathForResource:@"mixboard" ofType:@"png" inDirectory:@"images/views/tastemixer/mixerparts"];
    UIImage *imageMixBoard = [[UIImage alloc] initWithContentsOfFile:pathMixBoard];
    NSString *colorString = [NSString stringWithFormat:@"#%@", colorCode];
    UIColor *rgbColor = [UIColor colorWithHexString:colorString];
    UIImage *editedBg = [imageMixBoard imageWithTint:rgbColor];
    self.mixBoardOverlay = [[UIImageView alloc] initWithImage:editedBg];
    [self.mixBoardOverlay setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - editedBg.size.width/2, self.mixBoard.frame.origin.y, imageMixBoard.size.width, imageMixBoard.size.height)];
    self.mixBoardOverlay.alpha = 0;
    [self addSubview:self.mixBoardOverlay];
    [self bringSubviewToFront:self.blade];
}

-(void)enableMixboard{
    self.progressBarV.alpha = 1;
    self.mixBoard.alpha = 1;
    self.blade.alpha = 1;
}

-(void)disableMixboard{
    self.progressBarV.alpha = 0.3;
    self.mixBoard.alpha = 0.3;
    self.blade.alpha = 0.3;
}

-(void)setError:(NSString*)error andChangeTextColor:(BOOL)changeTextColor{
    self.txtInfo.text = [error uppercaseString];
    if(changeTextColor){
        self.txtInfo.textColor = [UIColor colorWithRed:0.73f green:0.05f blue:0.35f alpha:1.00f];
    }else{
        self.txtInfo.textColor = [UIColor whiteColor];
    }
}

-(void)updateSelectedIngredient:(Ingredient*)ingredientDataObject{
    if([self.currentSelectingIngredient isEqualToString:@"ingredient1"]){
        self.selectedIngredient1 = ingredientDataObject;
        NSString *pathIngredient1 = [[NSBundle mainBundle] pathForResource:self.selectedIngredient1.url ofType:@"png" inDirectory:@"images/views/ingredients/medium"];
        UIImage *imageIngredient1 = [[UIImage alloc] initWithContentsOfFile:pathIngredient1];
        [self.selectedIngredient1Btn setBackgroundImage:imageIngredient1 forState:UIControlStateNormal];
    }else{
        self.selectedIngredient2 = ingredientDataObject;
        NSString *pathIngredient2 = [[NSBundle mainBundle] pathForResource:self.selectedIngredient2.url ofType:@"png" inDirectory:@"images/views/ingredients/medium"];
        UIImage *imageIngredient2 = [[UIImage alloc] initWithContentsOfFile:pathIngredient2];
        [self.selectedIngredient2Btn setBackgroundImage:imageIngredient2 forState:UIControlStateNormal];
    }
    
    [self.mixBoard removeFromSuperview];
    NSString *pathMixBoard = [[NSBundle mainBundle] pathForResource:@"mixboard" ofType:@"png" inDirectory:@"images/views/tastemixer/mixerparts"];
    UIImage *imageMixBoard = [[UIImage alloc] initWithContentsOfFile:pathMixBoard];
    if(self.selectedIngredient1 && self.selectedIngredient2){
        NSMutableArray *arrColors = [NSMutableArray array];
        NSString *colorString1 = [NSString stringWithFormat:@"#%@", self.selectedIngredient1.colorCode];
        UIColor *rgbColor1 = [UIColor colorWithHexString:colorString1];
        [arrColors addObject:rgbColor1];
        NSString *colorString2 = [NSString stringWithFormat:@"#%@", self.selectedIngredient2.colorCode];
        UIColor *rgbColor2 = [UIColor colorWithHexString:colorString2];
        [arrColors addObject:rgbColor2];
        UIImage *editedBg = [imageMixBoard imageWithGradient:arrColors];
        self.mixBoard = [[UIImageView alloc] initWithImage:editedBg];
        int degrees = 10;
        float radians = degrees * M_PI / 180;
        self.mixBoard.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - self.mixBoard.frame.size.width/2, [[UIScreen mainScreen] bounds].size.height/2 - self.mixBoard.frame.size.height/2, self.mixBoard.frame.size.width, self.mixBoard.frame.size.height);
        self.mixBoard.contentMode = UIViewContentModeCenter;
        self.mixBoard.transform = CGAffineTransformMakeRotation(radians);
    } else if(self.selectedIngredient1){
        NSString *colorString = [NSString stringWithFormat:@"#%@", self.selectedIngredient1.colorCode];
        UIColor *rgbColor = [UIColor colorWithHexString:colorString];
        UIImage *editedBg = [imageMixBoard imageWithTint:rgbColor];
        self.mixBoard = [[UIImageView alloc] initWithImage:editedBg];
    } else{
        NSString *colorString = [NSString stringWithFormat:@"#%@", self.selectedIngredient2.colorCode];
        UIColor *rgbColor = [UIColor colorWithHexString:colorString];
        UIImage *editedBg = [imageMixBoard imageWithTint:rgbColor];
        self.mixBoard = [[UIImageView alloc] initWithImage:editedBg];
    }
    [self.mixBoard setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - imageMixBoard.size.width/2, self.selectedIngredient1Btn.frame.origin.y + self.selectedIngredient1Btn.frame.size.height + 10, imageMixBoard.size.width, imageMixBoard.size.height)];
    [self addSubview:self.mixBoard];
    [self bringSubviewToFront:self.blade];
    
    if(self.selectedIngredient1 && self.selectedIngredient2){
        //check if combination is original
        if(self.background.frame.size.height > [[UIScreen mainScreen] bounds].size.height){
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
                self.contentOffset = CGPointMake(0, 100);
            } completion:NULL];
        }
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"allowed_new_ingredients_ids"]){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CHECK_INGREDIENTS" object:nil];
        }else{
            [self setError:@"shake the device to mix the ingredients" andChangeTextColor:NO];
            [self enableMixboard];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ENABLE_SHAKING" object:nil];
        }
    }else{
        [self disableMixboard];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DISABLE_SHAKING" object:nil];
        [self setError:@"Select one more ingredient" andChangeTextColor:NO];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"INGREDIENTS_CHANGED" object:nil];
}

-(void)selectIngredient1:(id)sender{
    self.currentSelectingIngredient = @"ingredient1";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOW_ADD_MIX_INGREDIENT" object:nil];
}

-(void)selectIngredient2:(id)sender{
    self.currentSelectingIngredient = @"ingredient2";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOW_ADD_MIX_INGREDIENT" object:nil];
}

-(void)backToMixer:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BACK_TO_MIXER" object:nil];
}

-(void)resetAnimations{
    [self cloudAnimationWithDelay:0 objectToAnimate:self.cloud duration:40];
    [self cloudAnimationWithDelay:25 objectToAnimate:self.cloud2 duration:28];
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

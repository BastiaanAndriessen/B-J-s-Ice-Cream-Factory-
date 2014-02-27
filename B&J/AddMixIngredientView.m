//
//  AddMixIngredientView.m
//  B&J
//
//  Created by Bastiaan Andriessen on 25/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "AddMixIngredientView.h"
#import "Constants.h"

@implementation AddMixIngredientView

@synthesize background = _background;
@synthesize cloud = _cloud;
@synthesize cloud2 = _cloud2;
@synthesize timer = _timer;
@synthesize colorFrame = _colorFrame;
@synthesize btnLogo = _btnLogo;
@synthesize btnBack = _btnBack;
@synthesize imageIngredient = _imageIngredient;
@synthesize lblInfo = _lblInfo;

@synthesize addMixIngredientScrollV = _addMixIngredientScrollV;
@synthesize mainView = _mainView;

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
        [self.cloud setAlpha:0];
        [self addSubview:self.cloud];
        
        NSString *pathCloud2 = [[NSBundle mainBundle] pathForResource:@"cloud2" ofType:@"png" inDirectory:@"images/views/clouds"];
        UIImage *imageCloud2 = [[UIImage alloc] initWithContentsOfFile:pathCloud2];
        self.cloud2 = [[UIImageView alloc] initWithImage:imageCloud2];
        [self.cloud2 setFrame:CGRectMake(imageCloud2.size.width * -1, 35, imageCloud2.size.width, imageCloud2.size.height)];
        [self.cloud2 setAlpha:0];
        [self addSubview:self.cloud2];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startCloudAnimation:) userInfo:nil repeats:NO];
        
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
        [self.btnBack setTitle:[@"ingredient mixer" uppercaseString] forState:UIControlStateNormal];
        [[self.btnBack titleLabel] setFont:[UIFont fontWithName:@"ChunkFive-Roman" size:TopButtonFontSize]];
        [self.btnBack setTitleColor:[UIColor colorWithRed:0.95f green:0.30f blue:0.56f alpha:1.00f] forState:UIControlStateNormal];
        [self addSubview:self.btnBack];
        [self.btnBack addTarget:self action:@selector(backToIngredientMixer:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *pathIceCreamBg = [[NSBundle mainBundle] pathForResource:@"ingredient" ofType:@"png" inDirectory:@"images/views/tastemixer/buttons"];
        self.imageIngredient = [[UIImage alloc] initWithContentsOfFile:pathIceCreamBg];
                
        [self loadIngredients];
        
        //INFO LABEL
        self.lblInfo = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 295/2, self.btnBack.frame.origin.y + self.btnBack.frame.size.height + 10, 295, 10)];
        self.lblInfo.text = [@"Select a ingredient to mix" uppercaseString];
        self.lblInfo.backgroundColor = [UIColor clearColor];
        self.lblInfo.textAlignment = NSTextAlignmentCenter;
        self.lblInfo.textColor = [UIColor whiteColor];
        self.lblInfo.font = [UIFont fontWithName:@"Helvetica-Bold" size:9];
        [self addSubview:self.lblInfo];
    }
    return self;
}

-(void)loadIngredients{
    [self.mainView removeFromSuperview];
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 155, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 155)];
    [self addSubview:self.mainView];
    
    self.addMixIngredientScrollV = [[AddMixIngredientScrollView alloc] initWithFrame:CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height)];
    [self.addMixIngredientScrollV setUserInteractionEnabled:YES];
    [self.mainView addSubview:self.addMixIngredientScrollV];
    
    self.mainView.userInteractionEnabled = YES;
    self.addMixIngredientScrollV.scrollEnabled = YES;
    self.addMixIngredientScrollV.showsVerticalScrollIndicator = NO;
    self.addMixIngredientScrollV.delaysContentTouches = YES;
    self.addMixIngredientScrollV.canCancelContentTouches = NO;
    self.addMixIngredientScrollV.delegate = self.addMixIngredientScrollV;
    self.addMixIngredientScrollV.userInteractionEnabled = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setContentSize:) name:@"SET_CONTENT_SIZE" object:nil];
}

-(void)startCloudAnimation:(id)sender{
    [self.cloud setAlpha:1];
    [self.cloud2 setAlpha:1];
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

-(void)setContentSize:(id)sender{
    self.addMixIngredientScrollV.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, self.addMixIngredientScrollV.totalHeight);
}

-(void)backToIngredientMixer:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BACK_TO_INGREDIENT_MIXER" object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SET_CONTENT_SIZE" object:nil];
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

//
//  RateTastesView.m
//  B&J
//
//  Created by Bastiaan Andriessen on 28/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "RateTastesView.h"
#import "Constants.h"

@implementation RateTastesView

@synthesize background = _background;
@synthesize cloud = _cloud;
@synthesize cloud2 = _cloud2;
@synthesize timer = _timer;
@synthesize colorFrame = _colorFrame;
@synthesize btnLogo = _btnLogo;
@synthesize btnBack = _btnBack;
@synthesize btnSettings = _btnSettings;

@synthesize imageRate = _imageRate;
@synthesize currentSelectedRate = _currentSelectedRate;
@synthesize btnPeace = _btnPeace;
@synthesize btnLove = _btnLove;

@synthesize mainView = _mainView;
@synthesize rateTastesScrollV = _rateTastesScrollV;

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
        [self.cloud setAlpha:0];
        
        NSString *pathCloud2 = [[NSBundle mainBundle] pathForResource:@"cloud2" ofType:@"png" inDirectory:@"images/views/clouds"];
        UIImage *imageCloud2 = [[UIImage alloc] initWithContentsOfFile:pathCloud2];
        self.cloud2 = [[UIImageView alloc] initWithImage:imageCloud2];
        [self.cloud2 setFrame:CGRectMake(imageCloud2.size.width * -1, 35, imageCloud2.size.width, imageCloud2.size.height)];
        [self addSubview:self.cloud2];
        [self.cloud2 setAlpha:0];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startCloudAnimation:) userInfo:nil repeats:NO];
        
        //COLOR FRAME
        NSString *pathColorFrame = [[NSBundle mainBundle] pathForResource:@"frame" ofType:@"png" inDirectory:@"images/views/ratetastes"];
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
        [self.btnBack setTitleColor:[UIColor colorWithRed:0.24f green:0.67f blue:0.24f alpha:1.00f] forState:UIControlStateNormal];
        [self addSubview:self.btnBack];
        [self.btnBack addTarget:self action:@selector(backToMainMenu:) forControlEvents:UIControlEventTouchUpInside];
        
        //BtnSettings
        NSString *settingsBg = [[NSBundle mainBundle] pathForResource:@"settings_small" ofType:@"png" inDirectory:@"images/views/buttons/settings"];
        UIImage *imgSettingsBg = [[UIImage alloc] initWithContentsOfFile:settingsBg];
        self.btnSettings = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnSettings.frame = CGRectMake(TopButtonRightOffsetLeft, TopButtonOffsetTop, imgSettingsBg.size.width, imgSettingsBg.size.height);
        [self.btnSettings setBackgroundImage:imgSettingsBg forState:UIControlStateNormal];
        NSString *settingsBgh = [[NSBundle mainBundle] pathForResource:@"settings_smallh" ofType:@"png" inDirectory:@"images/views/buttons/settings"];
        UIImage *imgSettingsBgh = [[UIImage alloc] initWithContentsOfFile:settingsBgh];
        [self.btnSettings setBackgroundImage:imgSettingsBgh forState:UIControlStateHighlighted];
        [self.btnSettings setTitle:[@"settings" uppercaseString] forState:UIControlStateNormal];
        [[self.btnSettings titleLabel] setFont:[UIFont fontWithName:@"ChunkFive-Roman" size:TopButtonFontSize]];
        [self.btnSettings setTitleColor:[UIColor colorWithRed:0.06f green:0.46f blue:0.74f alpha:1.00f] forState:UIControlStateNormal];
        [self addSubview:self.btnSettings];
        [self.btnSettings addTarget:self action:@selector(showSettings:) forControlEvents:UIControlEventTouchUpInside];
        
        //imageRate
        NSString *pathRateBg = [[NSBundle mainBundle] pathForResource:@"top_button_background" ofType:@"png" inDirectory:@"images/views/ratetastes/buttons"];
        self.imageRate = [[UIImage alloc] initWithContentsOfFile:pathRateBg];
        
        //BtnPeace
        self.btnPeace = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnPeace.frame = CGRectMake(TopButtonLeftOffsetLeft, self.btnBack.frame.origin.y + self.btnBack.frame.size.height + 13, self.imageRate.size.width, self.imageRate.size.height);
        [self.btnPeace setBackgroundImage:self.imageRate forState:UIControlStateNormal];
        [self.btnPeace setBackgroundImage:self.imageRate forState:UIControlStateHighlighted];
        [self.btnPeace setTitle:[@"peace" uppercaseString] forState:UIControlStateNormal];
        [[self.btnPeace titleLabel] setFont:[UIFont fontWithName:@"ChunkFive-Roman" size:TopButtonFontSize]];
        [self.btnPeace setTitleColor:[UIColor colorWithRed:1.00f green:0.86f blue:0.01f alpha:1.00f] forState:UIControlStateNormal];
        [self addSubview:self.btnPeace];
        self.currentSelectedRate = @"peace";
        
        //BtnLove
        self.btnLove = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnLove.frame = CGRectMake(self.btnPeace.frame.origin.x + self.btnPeace.frame.size.width + 15, self.btnPeace.frame.origin.y, self.imageRate.size.width, self.imageRate.size.height);
        [self.btnLove setTitle:[@"love" uppercaseString] forState:UIControlStateNormal];
        [[self.btnLove titleLabel] setFont:[UIFont fontWithName:@"ChunkFive-Roman" size:TopButtonFontSize]];
        [self.btnLove setTitleColor:[UIColor colorWithRed:0.14f green:0.42f blue:0.58f alpha:1.00f] forState:UIControlStateNormal];
        [self.btnLove setTitleColor:[UIColor colorWithRed:1.00f green:0.86f blue:0.01f alpha:1.00f] forState:UIControlStateHighlighted];
        [self addSubview:self.btnLove];
        [self.btnLove addTarget:self action:@selector(selectLove:) forControlEvents:UIControlEventTouchUpInside];
        
        [self loadIceCreamTastes];
    }
    return self;
}

-(void)resetAnimations{
    [self cloudAnimationWithDelay:0 objectToAnimate:self.cloud duration:40];
    [self cloudAnimationWithDelay:25 objectToAnimate:self.cloud2 duration:28];
}

-(void)selectPeace:(id)sender{
    [self.btnPeace setTitleColor:[UIColor colorWithRed:1.00f green:0.86f blue:0.01f alpha:1.00f] forState:UIControlStateNormal];
    [self.btnPeace removeTarget:self action:@selector(selectPeace:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnPeace setBackgroundImage:self.imageRate forState:UIControlStateNormal];
    [self.btnPeace setBackgroundImage:self.imageRate forState:UIControlStateHighlighted];
    [self.btnLove setBackgroundImage:nil forState:UIControlStateNormal];
    [self.btnLove setBackgroundImage:nil forState:UIControlStateHighlighted];
    [self.btnLove setTitleColor:[UIColor colorWithRed:0.14f green:0.42f blue:0.58f alpha:1.00f] forState:UIControlStateNormal];
    [self.btnLove setTitleColor:[UIColor colorWithRed:1.00f green:0.86f blue:0.01f alpha:1.00f] forState:UIControlStateHighlighted];
    [self.btnLove addTarget:self action:@selector(selectLove:) forControlEvents:UIControlEventTouchUpInside];
    self.currentSelectedRate = @"peace";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGE_FILTER" object:nil];
}

-(void)selectLove:(id)sender{
    [self.btnLove setTitleColor:[UIColor colorWithRed:1.00f green:0.85f blue:0.27f alpha:1.00f] forState:UIControlStateNormal];
    [self.btnLove removeTarget:self action:@selector(selectChunks:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnLove setBackgroundImage:self.imageRate forState:UIControlStateNormal];
    [self.btnLove setBackgroundImage:self.imageRate forState:UIControlStateHighlighted];
    [self.btnPeace setBackgroundImage:nil forState:UIControlStateNormal];
    [self.btnPeace setBackgroundImage:nil forState:UIControlStateHighlighted];
    [self.btnPeace setTitleColor:[UIColor colorWithRed:0.14f green:0.42f blue:0.58f alpha:1.00f] forState:UIControlStateNormal];
    [self.btnPeace setTitleColor:[UIColor colorWithRed:1.00f green:0.85f blue:0.27f alpha:1.00f] forState:UIControlStateHighlighted];
    [self.btnPeace addTarget:self action:@selector(selectPeace:) forControlEvents:UIControlEventTouchUpInside];
    self.currentSelectedRate = @"love";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGE_FILTER" object:nil];
}

-(void)loadIceCreamTastes{
    [self.mainView removeFromSuperview];
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 188, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 188)];
    [self addSubview:self.mainView];
    
    self.rateTastesScrollV = [[RateTastesScrollView alloc] initWithFrame:CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height)];
    [self.rateTastesScrollV setUserInteractionEnabled:YES];
    [self.mainView addSubview:self.rateTastesScrollV];
    
    self.mainView.userInteractionEnabled = YES;
    self.rateTastesScrollV.scrollEnabled = YES;
    self.rateTastesScrollV.showsVerticalScrollIndicator = NO;
    self.rateTastesScrollV.delaysContentTouches = YES;
    self.rateTastesScrollV.canCancelContentTouches = NO;
    self.rateTastesScrollV.delegate = self.rateTastesScrollV;
    self.rateTastesScrollV.userInteractionEnabled = YES;
}

-(void)backToMainMenu:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BACK_TO_MAIN" object:nil];
}

-(void)showSettings:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOW_SETTINGS" object:nil];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

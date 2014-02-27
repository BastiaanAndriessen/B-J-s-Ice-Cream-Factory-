//
//  SocialShareScrollView.m
//  B&J
//
//  Created by Bastiaan Andriessen on 30/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "SocialShareScrollView.h"
#import "Constants.h"

@implementation SocialShareScrollView

@synthesize allowScrollControl = _allowScrollControl;

@synthesize background = _background;
@synthesize cloud = _cloud;
@synthesize cloud2 = _cloud2;
@synthesize colorFrame = _colorFrame;
@synthesize btnLogo = _btnLogo;
@synthesize btnBack = _btnBack;
@synthesize imgFacebook = _imgFacebook;
@synthesize txtInfo = _txtInfo;
@synthesize btnShare = _btnShare;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.allowScrollControl = YES;
        
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
        NSString *pathBackBg = [[NSBundle mainBundle] pathForResource:@"ratetastes_wide" ofType:@"png" inDirectory:@"images/views/buttons/ratetastes"];
        UIImage *backBg = [[UIImage alloc] initWithContentsOfFile:pathBackBg];
        self.btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnBack.frame = CGRectMake(TopButtonLeftOffsetLeft, TopButtonOffsetTop, backBg.size.width, backBg.size.height);
        [self.btnBack setBackgroundImage:backBg forState:UIControlStateNormal];
        NSString *pathBackBgh = [[NSBundle mainBundle] pathForResource:@"ratetastes_wideh" ofType:@"png" inDirectory:@"images/views/buttons/ratetastes"];
        UIImage *backBgh = [[UIImage alloc] initWithContentsOfFile:pathBackBgh];
        [self.btnBack setBackgroundImage:backBgh forState:UIControlStateHighlighted];
        [self.btnBack setTitle:[@"rate tastes" uppercaseString] forState:UIControlStateNormal];
        [[self.btnBack titleLabel] setFont:[UIFont fontWithName:@"ChunkFive-Roman" size:TopButtonFontSize]];
        [self.btnBack setTitleColor:[UIColor colorWithRed:0.06f green:0.46f blue:0.74f alpha:1.00f] forState:UIControlStateNormal];
        [self addSubview:self.btnBack];
        [self.btnBack addTarget:self action:@selector(backToRateTastes:) forControlEvents:UIControlEventTouchUpInside];
        
        //IMAGE FACEBOOK
        NSString *pathFacebook = [[NSBundle mainBundle] pathForResource:@"facebook" ofType:@"png" inDirectory:@"images/views/ratetastes"];
        UIImage *imageFacebook = [[UIImage alloc] initWithContentsOfFile:pathFacebook];
        self.imgFacebook = [[UIImageView alloc] initWithImage:imageFacebook];
        [self.imgFacebook setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - imageFacebook.size.width/2, self.btnBack.frame.origin.y + self.btnBack.frame.size.height + 22, imageFacebook.size.width, imageFacebook.size.height)];
        [self addSubview:self.imgFacebook];
        
        //INFO textfield
        self.txtInfo = [[UITextView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 245/2, self.imgFacebook.frame.origin.y + self.imgFacebook.frame.size.height + 15, 245, 150)];
        self.txtInfo.userInteractionEnabled = NO;
        self.txtInfo.text = [@"loading..." uppercaseString];
        self.txtInfo.backgroundColor = [UIColor clearColor];
        self.txtInfo.textAlignment = NSTextAlignmentCenter;
        self.txtInfo.textColor = [UIColor whiteColor];
        self.txtInfo.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        [self addSubview:self.txtInfo];
        
        //Btn Start Rating
        NSString *pathShareBg = [[NSBundle mainBundle] pathForResource:@"default_wide_bottom" ofType:@"png" inDirectory:@"images/views/ratetastes/buttons"];
        UIImage *shareBg = [[UIImage alloc] initWithContentsOfFile:pathShareBg];
        self.btnShare = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnShare.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - shareBg.size.width/2, 345, shareBg.size.width, shareBg.size.height);
        [self.btnShare setBackgroundImage:shareBg forState:UIControlStateNormal];
        [self.btnShare setBackgroundImage:shareBg forState:UIControlStateHighlighted];
        [self.btnShare setTitle:[@"share the love" uppercaseString] forState:UIControlStateNormal];
        [[self.btnShare titleLabel] setFont:[UIFont fontWithName:@"ChunkFive-Roman" size:TopButtonFontSize]];
        [self.btnShare setTitleColor:[UIColor colorWithRed:1.00f green:0.86f blue:0.01f alpha:1.00f] forState:UIControlStateNormal];
        [self.btnShare setTitleColor:[UIColor colorWithRed:1.00f green:0.93f blue:0.53f alpha:1.00f] forState:UIControlStateHighlighted];
        [self addSubview:self.btnShare];
        [self.btnShare addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)share:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SHARE" object:nil];
}

-(void)fillInVotedIceCreamName:(NSString*)name voteKind:(NSString*)voteKind{
    [self.btnShare setTitle:[[NSString stringWithFormat:@"share the %@",voteKind] uppercaseString] forState:UIControlStateNormal];
    self.txtInfo.text = [[NSString stringWithFormat:@"Thanks for voting on the %@ ice cream. Share the peace and love with your friends!",name] uppercaseString];
}

-(void)backToRateTastes:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BACK_TO_RATE_TASTES_FROM_INGREDIENTS_OR_SHARE" object:nil];
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
    if(self.btnShare.frame.origin.y + self.btnShare.frame.size.height + 10 > [[UIScreen mainScreen] bounds].size.height && self.allowScrollControl){
        if(self.contentOffset.y > self.btnShare.frame.origin.y + self.btnShare.frame.size.height + 10 - [[UIScreen mainScreen] bounds].size.height){
            self.contentOffset = CGPointMake(0, self.btnShare.frame.origin.y + self.btnShare.frame.size.height + 10 - [[UIScreen mainScreen] bounds].size.height);
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

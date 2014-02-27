//
//  HomeScrollView.m
//  B&J
//
//  Created by Bastiaan Andriessen on 21/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "HomeScrollView.h"
#import "Constants.h"

@implementation HomeScrollView

@synthesize background = _background;
@synthesize cloud = _cloud;
@synthesize cloud2 = _cloud2;
@synthesize backHill = _backHill;
@synthesize cow = _cow;
@synthesize frontHill = _frontHill;
@synthesize btnLogo = _btnLogo;

@synthesize randomIndex = _randomIndex;
@synthesize randomQuote = _randomQuote;

@synthesize btnMeuh = _btnMeuh;
@synthesize arrowsMeuh = _arrowsMeuh;
@synthesize btnMixer = _btnMixer;
@synthesize arrowsMixer = _arrowsMixer;
@synthesize btnRate = _btnRate;
@synthesize arrowsRate = _arrowsRate;

@synthesize timer = _timer;
@synthesize allowedToShowRandomQuote = _allowedToShowRandomQuote;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.allowedToShowRandomQuote = YES;
        
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
        
        //BACK HILL
        NSString *pathBackHill = [[NSBundle mainBundle] pathForResource:@"back_hill" ofType:@"png" inDirectory:@"images/views/menu"];
        UIImage *imageBackHill = [[UIImage alloc] initWithContentsOfFile:pathBackHill];
        self.backHill = [[UIImageView alloc] initWithImage:imageBackHill];
        [self.backHill setFrame:CGRectMake(0, 60, imageBackHill.size.width, imageBackHill.size.height)];
        [self addSubview:self.backHill];
        
        //COW
        NSString *pathCow = [[NSBundle mainBundle] pathForResource:@"cow" ofType:@"png" inDirectory:@"images/views/menu"];
        UIImage *imageCow = [[UIImage alloc] initWithContentsOfFile:pathCow];
        self.cow = [[UIImageView alloc] initWithImage:imageCow];
        [self.cow setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - imageCow.size.width/2, 70 + imageCow.size.height, imageCow.size.width, imageCow.size.height)];
        [self addSubview:self.cow];
        [self.cow setAlpha:0];
        
        //FRONT HILL
        NSString *pathFrontHill = [[NSBundle mainBundle] pathForResource:@"front_hill" ofType:@"png" inDirectory:@"images/views/menu"];
        UIImage *imageFrontHill = [[UIImage alloc] initWithContentsOfFile:pathFrontHill];
        self.frontHill = [[UIImageView alloc] initWithImage:imageFrontHill];
        [self.frontHill setFrame:CGRectMake(0, 115, imageFrontHill.size.width, imageFrontHill.size.height)];
        [self addSubview:self.frontHill];
        
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
        [self.btnLogo setAlpha:0];
        
        //BtnMEEEUUUH??
        NSString *pathMeuhBg = [[NSBundle mainBundle] pathForResource:@"btn_yellow" ofType:@"png" inDirectory:@"images/views/menu/buttons"];
        UIImage *meuhBg = [[UIImage alloc] initWithContentsOfFile:pathMeuhBg];
        self.btnMeuh = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnMeuh.frame = CGRectMake(31, 195, meuhBg.size.width, meuhBg.size.height);
        [self.btnMeuh setBackgroundImage:meuhBg forState:UIControlStateNormal];
        NSString *pathMeuhBgh = [[NSBundle mainBundle] pathForResource:@"btn_yellowh" ofType:@"png" inDirectory:@"images/views/menu/buttons"];
        UIImage *meuhBgh = [[UIImage alloc] initWithContentsOfFile:pathMeuhBgh];
        [self.btnMeuh setBackgroundImage:meuhBgh forState:UIControlStateHighlighted];
        [self.btnMeuh setTitle:[@"meeeuuuh??" uppercaseString] forState:UIControlStateNormal];
        [[self.btnMeuh titleLabel] setFont:[UIFont fontWithName:@"ChunkFive-Roman" size:30]];
        [self.btnMeuh setTitleColor:[UIColor colorWithRed:1.00f green:0.65f blue:0.22f alpha:1.00f] forState:UIControlStateNormal];
        [self.btnMeuh setAlpha:0];
        [self addSubview:self.btnMeuh];
        
        //ARROWS MEUH
        NSString *pathArrowsMeuh = [[NSBundle mainBundle] pathForResource:@"arrows" ofType:@"png" inDirectory:@"images/views/menu"];
        UIImage *arrowsMeuh = [[UIImage alloc] initWithContentsOfFile:pathArrowsMeuh];
        self.arrowsMeuh = [[UIImageView alloc] initWithImage:arrowsMeuh];
        [self.arrowsMeuh setFrame:CGRectMake(self.btnMeuh.frame.origin.x, self.btnMeuh.frame.origin.y + self.btnMeuh.frame.size.height + 10, arrowsMeuh.size.width, arrowsMeuh.size.height)];
        [self addSubview:self.arrowsMeuh];
        [self.arrowsMeuh setAlpha:0];
        
        //LABEL MEUH
        UILabel *lblMeuh = [[UILabel alloc] initWithFrame:CGRectMake(self.arrowsMeuh.frame.origin.x + self.arrowsMeuh.frame.size.width + 5, self.arrowsMeuh.frame.origin.y + 2, 200, 10)];
        lblMeuh.text = [@"Last resort for strayed cows" uppercaseString];
        lblMeuh.numberOfLines = 0;
        lblMeuh.backgroundColor = [UIColor clearColor];
        lblMeuh.textAlignment = NSTextAlignmentLeft;
        lblMeuh.textColor = [UIColor whiteColor];
        lblMeuh.font = [UIFont fontWithName:@"Helvetica-Bold" size:9];
        [self addSubview:lblMeuh];
        [lblMeuh setAlpha:0];
        
        //BtnTASTEMIXER
        NSString *pathTasteBg = [[NSBundle mainBundle] pathForResource:@"btn_red" ofType:@"png" inDirectory:@"images/views/menu/buttons"];
        UIImage *tasteBg = [[UIImage alloc] initWithContentsOfFile:pathTasteBg];
        self.btnMixer = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnMixer.frame = CGRectMake(self.btnMeuh.frame.origin.x, self.btnMeuh.frame.origin.y + self.btnMeuh.frame.size.height + 50, tasteBg.size.width, tasteBg.size.height);
        [self.btnMixer setBackgroundImage:tasteBg forState:UIControlStateNormal];
        NSString *pathTasteBgh = [[NSBundle mainBundle] pathForResource:@"btn_redh" ofType:@"png" inDirectory:@"images/views/menu/buttons"];
        UIImage *tasteBgh = [[UIImage alloc] initWithContentsOfFile:pathTasteBgh];
        [self.btnMixer setBackgroundImage:tasteBgh forState:UIControlStateHighlighted];
        [self.btnMixer setTitle:[@"taste mixer" uppercaseString] forState:UIControlStateNormal];
        [[self.btnMixer titleLabel] setFont:[UIFont fontWithName:@"ChunkFive-Roman" size:30]];
        [self.btnMixer setTitleColor:[UIColor colorWithRed:0.95f green:0.30f blue:0.56f alpha:1.00f] forState:UIControlStateNormal];
        [self.btnMixer setAlpha:0];
        [self addSubview:self.btnMixer];
        
        //ARROWS TASTE MIXER
        NSString *pathArrowsTaste = [[NSBundle mainBundle] pathForResource:@"arrows" ofType:@"png" inDirectory:@"images/views/menu"];
        UIImage *arrowsTaste = [[UIImage alloc] initWithContentsOfFile:pathArrowsTaste];
        self.arrowsMixer = [[UIImageView alloc] initWithImage:arrowsTaste];
        [self.arrowsMixer setFrame:CGRectMake(self.btnMixer.frame.origin.x, self.btnMixer.frame.origin.y + self.btnMixer.frame.size.height + 10, arrowsTaste.size.width, arrowsTaste.size.height)];
        [self addSubview:self.arrowsMixer];
        [self.arrowsMixer setAlpha:0];
        
        //LABEL TASTE MIXER
        UILabel *lblTaste = [[UILabel alloc] initWithFrame:CGRectMake(self.arrowsMixer.frame.origin.x + self.arrowsMixer.frame.size.width + 5, self.arrowsMixer.frame.origin.y + 2, 250, 10)];
        lblTaste.text = [@"Create your new unique ice cream taste" uppercaseString];
        lblTaste.numberOfLines = 0;
        lblTaste.backgroundColor = [UIColor clearColor];
        lblTaste.textAlignment = NSTextAlignmentLeft;
        lblTaste.textColor = [UIColor whiteColor];
        lblTaste.font = [UIFont fontWithName:@"Helvetica-Bold" size:9];
        [self addSubview:lblTaste];
        [lblTaste setAlpha:0];
        
        //BtnRATETASTES
        NSString *pathRateBg = [[NSBundle mainBundle] pathForResource:@"btn_blue" ofType:@"png" inDirectory:@"images/views/menu/buttons"];
        UIImage *rateBg = [[UIImage alloc] initWithContentsOfFile:pathRateBg];
        self.btnRate = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnRate.frame = CGRectMake(self.btnMeuh.frame.origin.x, self.btnMixer.frame.origin.y + self.btnMixer.frame.size.height + 50, rateBg.size.width, rateBg.size.height);
        [self.btnRate setBackgroundImage:rateBg forState:UIControlStateNormal];
        NSString *pathRateBgh = [[NSBundle mainBundle] pathForResource:@"btn_blueh" ofType:@"png" inDirectory:@"images/views/menu/buttons"];
        UIImage *rateBgh = [[UIImage alloc] initWithContentsOfFile:pathRateBgh];
        [self.btnRate setBackgroundImage:rateBgh forState:UIControlStateHighlighted];
        [self.btnRate setTitle:[@"rate tastes" uppercaseString] forState:UIControlStateNormal];
        [[self.btnRate titleLabel] setFont:[UIFont fontWithName:@"ChunkFive-Roman" size:30]];
        [self.btnRate setTitleColor:[UIColor colorWithRed:0.05f green:0.47f blue:0.72f alpha:1.00f] forState:UIControlStateNormal];
        [self.btnRate setAlpha:0];
        [self addSubview:self.btnRate];
        
        //ARROWS RATE TASTES
        NSString *pathArrowsRate = [[NSBundle mainBundle] pathForResource:@"arrows" ofType:@"png" inDirectory:@"images/views/menu"];
        UIImage *arrowsRate = [[UIImage alloc] initWithContentsOfFile:pathArrowsRate];
        self.arrowsRate = [[UIImageView alloc] initWithImage:arrowsRate];
        [self.arrowsRate setFrame:CGRectMake(self.btnRate.frame.origin.x, self.btnRate.frame.origin.y + self.btnRate.frame.size.height + 10, arrowsRate.size.width, arrowsRate.size.height)];
        [self addSubview:self.arrowsRate];
        [self.arrowsRate setAlpha:0];
        
        //LABEL RATE TASTE
        UILabel *lblRate = [[UILabel alloc] initWithFrame:CGRectMake(self.arrowsRate.frame.origin.x + self.arrowsRate.frame.size.width + 5, self.arrowsRate.frame.origin.y + 2, 200, 10)];
        lblRate.text = [@"Rate other new ice cream tastes" uppercaseString];
        lblRate.numberOfLines = 0;
        lblRate.backgroundColor = [UIColor clearColor];
        lblRate.textAlignment = NSTextAlignmentLeft;
        lblRate.textColor = [UIColor whiteColor];
        lblRate.font = [UIFont fontWithName:@"Helvetica-Bold" size:9];
        [self addSubview:lblRate];
        [lblRate setAlpha:0];
        
        //animate cow
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.cow.alpha = 1;
            [self.cow setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - self.cow.frame.size.width/2, 70, self.cow.frame.size.width, self.cow.frame.size.height)];
        } completion:^(BOOL finished){
            if(finished && self.allowedToShowRandomQuote){
                //cow quotes
                [self showRandomCowQuote];
            }
        }];
        
        //animate logo
        [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.btnLogo.alpha = 1;
        } completion:^(BOOL finished){
            if(finished){
                [self.btnLogo addTarget:self action:@selector(goToSite:) forControlEvents:UIControlEventTouchUpInside];
            }
        }];
        
        //animate menu buttons & labels
        [UIView animateWithDuration:1 delay:1.3 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.btnMeuh.alpha = 1;
            self.arrowsMeuh.alpha = 1;
            lblMeuh.alpha = 1;
        } completion:^(BOOL finished){
            if(finished){
                [self.btnMeuh addTarget:self action:@selector(showInfo:) forControlEvents:UIControlEventTouchUpInside];
            }
        }];
        
        [UIView animateWithDuration:1 delay:1.6 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.btnMixer.alpha = 1;
            self.arrowsMixer.alpha = 1;
            lblTaste.alpha = 1;
        } completion:^(BOOL finished){
            if(finished){
                [self.btnMixer addTarget:self action:@selector(showMixer:) forControlEvents:UIControlEventTouchUpInside];
            }
        }];
        
        [UIView animateWithDuration:1 delay:1.9 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.btnRate.alpha = 1;
            self.arrowsRate.alpha = 1;
            lblRate.alpha = 1;
        } completion:^(BOOL finished){
            if(finished){
                [self.btnRate addTarget:self action:@selector(showRates:) forControlEvents:UIControlEventTouchUpInside];
            }
        }];
        
        //clouds
        [self cloudAnimationWithDelay:0 objectToAnimate:self.cloud duration:40];
        [self cloudAnimationWithDelay:25 objectToAnimate:self.cloud2 duration:28];
    }
    return self;
}

-(void)resetAnimations{
    [self.randomQuote removeFromSuperview];
    [self.timer invalidate];
    self.timer = nil;
    
    [self cloudAnimationWithDelay:0 objectToAnimate:self.cloud duration:40];
    [self cloudAnimationWithDelay:25 objectToAnimate:self.cloud2 duration:28];
    [self showRandomCowQuote];
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

//random cow quotes
-(void)showRandomCowQuote
{
    float fadeInDelay = 0;
    if(self.randomQuote == nil){
        fadeInDelay = 2;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(relaunchQuote:) userInfo:nil repeats:NO];
    
    BOOL allowNulDeling = YES;
    if((int)self.randomIndex%2 != 0){
        allowNulDeling = NO;
    }
    
    float numLooped = 0;
    for(NSInteger i = 0; i<300; i++)
    {
        float newRandomIndex = (arc4random() % 6)+1;
        numLooped++;
        BOOL allowedToShow = NO;
        BOOL isCurrentNulDelingZero = YES;
        if((int)newRandomIndex%2 != 0){
            isCurrentNulDelingZero = NO;
        }
        if(newRandomIndex != self.randomIndex && isCurrentNulDelingZero != allowNulDeling){
            self.randomIndex = newRandomIndex;
            allowedToShow = YES;
        } else{
            if(numLooped == 299){
                if(allowNulDeling){
                    self.randomIndex = 1;
                } else {
                    self.randomIndex = 2;
                }
                allowedToShow = YES;
            }
        }
        
        if(allowedToShow){
            NSString *pathRandom = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"arrow%lu", (unsigned long)self.randomIndex] ofType:@"png" inDirectory:@"images/views/menu/arrows"];
            UIImage *imageRandom = [[UIImage alloc] initWithContentsOfFile:pathRandom];
            self.randomQuote = [[UIImageView alloc] initWithImage:imageRandom];
            self.randomQuote.alpha = 0;
            
            if((int)self.randomIndex%2 == 1){
                //arrow left side of cow
                [self.randomQuote setFrame:CGRectMake(91, 140, imageRandom.size.width, imageRandom.size.height)];
            }else{
                //arrow right side of cow
                [self.randomQuote setFrame:CGRectMake(175, 135, imageRandom.size.width, imageRandom.size.height)];
            }
            [self addSubview:self.randomQuote];
            
            [UIView animateWithDuration:1 delay:fadeInDelay options:UIViewAnimationOptionLayoutSubviews  animations:^{
                self.randomQuote.alpha = 1;
            } completion:NULL];
            
            break;
        }
    }
}

-(void)showInternetArrow{
    [self.timer invalidate];
    self.timer = nil;
    self.allowedToShowRandomQuote = NO;
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionLayoutSubviews  animations:^{
        self.randomQuote.alpha = 0;
    } completion:^(BOOL finished){
        [self.randomQuote removeFromSuperview];
        NSString *pathQuote = [[NSBundle mainBundle] pathForResource:@"internet" ofType:@"png" inDirectory:@"images/views/menu/arrows"];
        UIImage *imageQuote = [[UIImage alloc] initWithContentsOfFile:pathQuote];
        self.randomQuote = [[UIImageView alloc] initWithImage:imageQuote];
        self.randomQuote.alpha = 0;
        [self.randomQuote setFrame:CGRectMake(51, 140, imageQuote.size.width, imageQuote.size.height)];
        [self addSubview:self.randomQuote];
    
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionLayoutSubviews  animations:^{
            self.randomQuote.alpha = 1;
        } completion:NULL];
    }];
}

-(void)hideInternetArrow{
    [self.timer invalidate];
    self.timer = nil;
    self.allowedToShowRandomQuote = YES;
    [self relaunchQuote:@""];
}

-(void)relaunchQuote:(id)sender{
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionLayoutSubviews  animations:^{
        self.randomQuote.alpha = 0;
    } completion:^(BOOL finished){
        if(finished){
            [self.randomQuote removeFromSuperview];
            [self showRandomCowQuote];
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

-(void)goToSite:(id)sender{
    NSURL *url = [ [ NSURL alloc ] initWithString: @"http://www.benjerry.com/"];
    [[UIApplication sharedApplication] openURL:url];
}

-(void)showInfo:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOW_INFO" object:nil];
}

-(void)showMixer:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOW_MIXER" object:nil];
}

-(void)showRates:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOW_RATES" object:nil];
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

//
//  MeuhScrollView.m
//  B&J
//
//  Created by Bastiaan Andriessen on 22/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "MeuhScrollView.h"
#import "Constants.h"

@implementation MeuhScrollView

@synthesize background = _background;
@synthesize cloud = _cloud;
@synthesize cloud2 = _cloud2;
@synthesize colorFrame = _colorFrame;
@synthesize btnLogo = _btnLogo;
@synthesize btnBack = _btnBack;

@synthesize imgPeace = _imgPeace;
@synthesize imgLove = _imgLove;
@synthesize lblVInfoBlock2 = _lblVInfoBlock2;

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
        NSString *pathColorFrame = [[NSBundle mainBundle] pathForResource:@"frame" ofType:@"png" inDirectory:@"images/views/meuh"];
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
        NSString *pathBackBg = [[NSBundle mainBundle] pathForResource:@"mainmenu_wide" ofType:@"png" inDirectory:@"images/views/buttons/mainmenu"];
        UIImage *backBg = [[UIImage alloc] initWithContentsOfFile:pathBackBg];
        self.btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnBack.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - backBg.size.width/2, TopButtonOffsetTop, backBg.size.width, backBg.size.height);
        [self.btnBack setBackgroundImage:backBg forState:UIControlStateNormal];
        NSString *pathBackBgh = [[NSBundle mainBundle] pathForResource:@"mainmenu_wideh" ofType:@"png" inDirectory:@"images/views/buttons/mainmenu"];
        UIImage *backBgh = [[UIImage alloc] initWithContentsOfFile:pathBackBgh];
        [self.btnBack setBackgroundImage:backBgh forState:UIControlStateHighlighted];
        [self.btnBack setTitle:[@"main menu" uppercaseString] forState:UIControlStateNormal];
        [[self.btnBack titleLabel] setFont:[UIFont fontWithName:@"ChunkFive-Roman" size:TopButtonFontSize]];
        [self.btnBack setTitleColor:[UIColor colorWithRed:0.20f green:0.67f blue:0.31f alpha:1.00f] forState:UIControlStateNormal];
        [self addSubview:self.btnBack];
        [self.btnBack addTarget:self action:@selector(backToMainMenu:) forControlEvents:UIControlEventTouchUpInside];
    
        //LABEL BLOCK INFO 1
        UILabel *lblVInfoBlock1 = [[UILabel alloc] init];
        [lblVInfoBlock1 setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 295/2, self.btnBack.frame.origin.y + self.btnBack.frame.size.height, 295, 135)];
        [lblVInfoBlock1 setText:[@"The Wondrous ice cream factory contest is all about Peace, love and ice cream. to win a personal free cone day at your place for you and all your friends you’ll have to invent your very own ice cream taste and collect the most peace and love amongst the other contributors." uppercaseString]];
        lblVInfoBlock1.backgroundColor = [UIColor clearColor];
        lblVInfoBlock1.textAlignment = NSTextAlignmentLeft;
        lblVInfoBlock1.textColor = [UIColor whiteColor];
        lblVInfoBlock1.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.8];
        lblVInfoBlock1.numberOfLines = 0;
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: lblVInfoBlock1.attributedText];
        [text addAttribute: NSForegroundColorAttributeName value: [UIColor colorWithRed:0.77f green:0.13f blue:0.17f alpha:1.00f] range: NSMakeRange(4,35)];
        [text addAttribute: NSForegroundColorAttributeName value: [UIColor colorWithRed:0.77f green:0.13f blue:0.17f alpha:1.00f] range: NSMakeRange(96,14)];
        [text addAttribute: NSForegroundColorAttributeName value: [UIColor colorWithRed:0.77f green:0.13f blue:0.17f alpha:1.00f] range: NSMakeRange(227,14)];
        [lblVInfoBlock1 setAttributedText: text];
        [self addSubview:lblVInfoBlock1];
        
        //imgPeace
        NSString *pathPeace = [[NSBundle mainBundle] pathForResource:@"peace" ofType:@"png" inDirectory:@"images/views/meuh"];
        UIImage *imagePeace = [[UIImage alloc] initWithContentsOfFile:pathPeace];
        self.imgPeace = [[UIImageView alloc] initWithImage:imagePeace];
        [self.imgPeace setFrame:CGRectMake(22, 271, imagePeace.size.width, imagePeace.size.height)];
        [self addSubview:self.imgPeace];
        
        //labelPeace
        UILabel *lblPeace = [[UILabel alloc] initWithFrame:CGRectMake(self.imgPeace.frame.origin.x + self.imgPeace.frame.size.width + 16, self.imgPeace.frame.origin.y - 3, 206, 14)];
        lblPeace.text = [@"The peace - o - meter" uppercaseString];
        lblPeace.backgroundColor = [UIColor clearColor];
        lblPeace.textAlignment = NSTextAlignmentLeft;
        lblPeace.textColor = [UIColor colorWithRed:0.77f green:0.13f blue:0.17f alpha:1.00f];
        lblPeace.font = [UIFont fontWithName:@"ChunkFive-Roman" size:15];
        [self addSubview:lblPeace];
        
        //txtPeace
        UILabel *lblPeaceInfo = [[UILabel alloc] initWithFrame:CGRectMake(lblPeace.frame.origin.x, lblPeace.frame.origin.y + lblPeace.frame.size.height, lblPeace.frame.size.width, 43)];
        lblPeaceInfo.text = [@"You can give all ice cream tastes a peace sign. It means you like it, but wouldn’t share your love with it." uppercaseString];
        lblPeaceInfo.backgroundColor = [UIColor clearColor];
        lblPeaceInfo.numberOfLines = 0;
        lblPeaceInfo.textAlignment = NSTextAlignmentLeft;
        lblPeaceInfo.textColor = [UIColor whiteColor];
        lblPeaceInfo.font = [UIFont fontWithName:@"Helvetica-Bold" size:9];
        [self addSubview:lblPeaceInfo];
        
        //imgLove
        NSString *pathLove = [[NSBundle mainBundle] pathForResource:@"love" ofType:@"png" inDirectory:@"images/views/meuh"];
        UIImage *imageLove = [[UIImage alloc] initWithContentsOfFile:pathLove];
        self.imgLove = [[UIImageView alloc] initWithImage:imageLove];
        [self.imgLove setFrame:CGRectMake(self.imgPeace.frame.origin.x, self.imgPeace.frame.origin.y + self.imgPeace.frame.size.height + 30, imageLove.size.width, imageLove.size.height)];
        [self addSubview:self.imgLove];
        
        //labelPeace
        UILabel *lblLove = [[UILabel alloc] initWithFrame:CGRectMake(lblPeace.frame.origin.x, self.imgLove.frame.origin.y - 3, 206, 14)];
        lblLove.text = [@"The love - o - meter" uppercaseString];
        lblLove.backgroundColor = [UIColor clearColor];
        lblLove.textAlignment = NSTextAlignmentLeft;
        lblLove.textColor = [UIColor colorWithRed:0.77f green:0.13f blue:0.17f alpha:1.00f];
        lblLove.font = [UIFont fontWithName:@"ChunkFive-Roman" size:15];
        [self addSubview:lblLove];
        
        //txtPeace
        UILabel *lblLoveInfo = [[UILabel alloc] initWithFrame:CGRectMake(lblLove.frame.origin.x, lblLove.frame.origin.y + lblLove.frame.size.height, lblLove.frame.size.width, 43)];
        lblLoveInfo.text = [@"There is only one perfect ice cream for you. So think wisely before giving your one love away." uppercaseString];
        lblLoveInfo.backgroundColor = [UIColor clearColor];
        lblLoveInfo.numberOfLines = 0;
        lblLoveInfo.textAlignment = NSTextAlignmentLeft;
        lblLoveInfo.textColor = [UIColor whiteColor];
        lblLoveInfo.font = [UIFont fontWithName:@"Helvetica-Bold" size:9];
        [self addSubview:lblLoveInfo];
        
        //LABEL BLOCK INFO 2
        self.lblVInfoBlock2 = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 295/2, lblLoveInfo.frame.origin.y + lblLoveInfo.frame.size.height + 6, 295, 65)];
        self.lblVInfoBlock2.text = [@"This adventurous funky story obviously needs a happy end. We’ll announce BOTH (peace and love) winners the 30th of september 2013. " uppercaseString];
        self.lblVInfoBlock2.backgroundColor = [UIColor clearColor];
        self.lblVInfoBlock2.textAlignment = NSTextAlignmentLeft;
        self.lblVInfoBlock2.textColor = [UIColor whiteColor];
        self.lblVInfoBlock2.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.8];
        NSMutableAttributedString *text2 = [[NSMutableAttributedString alloc] initWithAttributedString: self.lblVInfoBlock2.attributedText];
        [text2 addAttribute: NSForegroundColorAttributeName value: [UIColor colorWithRed:0.77f green:0.13f blue:0.17f alpha:1.00f] range: NSMakeRange(107,22)];
        [self.lblVInfoBlock2 setAttributedText: text2];
        self.lblVInfoBlock2.numberOfLines = 0;
        [self addSubview:self.lblVInfoBlock2];
    }
    return self;
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

-(void)backToMainMenu:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BACK_TO_MAIN" object:nil];
}

//scroll control
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.contentOffset.y < 0){
        self.contentOffset = CGPointMake(0, 0);
    }
    if(self.lblVInfoBlock2.frame.origin.y + self.lblVInfoBlock2.frame.size.height > [[UIScreen mainScreen] bounds].size.height){
        if(self.contentOffset.y > self.lblVInfoBlock2.frame.origin.y + self.lblVInfoBlock2.frame.size.height - [[UIScreen mainScreen] bounds].size.height){
            self.contentOffset = CGPointMake(0, self.lblVInfoBlock2.frame.origin.y + self.lblVInfoBlock2.frame.size.height - [[UIScreen mainScreen] bounds].size.height);
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

//
//  EmailOverlayScrollView.m
//  B&J
//
//  Created by Bastiaan Andriessen on 28/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "EmailOverlayScrollView.h"
#import "Constants.h"

@implementation EmailOverlayScrollView

@synthesize allowScrollControl = _allowScrollControl;

@synthesize background = _background;
@synthesize cloud = _cloud;
@synthesize cloud2 = _cloud2;
@synthesize colorFrame = _colorFrame;
@synthesize btnLogo = _btnLogo;
@synthesize btnBack = _btnBack;

@synthesize txtInfo = _txtInfo;
@synthesize imgIcons = _imgIcons;

@synthesize lblEmailAddress = _lblEmailAddress;
@synthesize txtEmailAddress = _txtEmailAddress;
@synthesize lblFeedbackEmailAddress = _lblFeedbackEmailAddress;

@synthesize btnStartRating = _btnStartRating;

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
        NSString *pathBackBg = [[NSBundle mainBundle] pathForResource:@"mainmenu_wide" ofType:@"png" inDirectory:@"images/views/buttons/mainmenu"];
        UIImage *backBg = [[UIImage alloc] initWithContentsOfFile:pathBackBg];
        self.btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnBack.frame = CGRectMake(TopButtonLeftOffsetLeft, TopButtonOffsetTop, backBg.size.width, backBg.size.height);
        [self.btnBack setBackgroundImage:backBg forState:UIControlStateNormal];
        NSString *pathBackBgh = [[NSBundle mainBundle] pathForResource:@"mainmenu_wideh" ofType:@"png" inDirectory:@"images/views/buttons/mainmenu"];
        UIImage *backBgh = [[UIImage alloc] initWithContentsOfFile:pathBackBgh];
        [self.btnBack setBackgroundImage:backBgh forState:UIControlStateHighlighted];
        [self.btnBack setTitle:[@"menu" uppercaseString] forState:UIControlStateNormal];
        [[self.btnBack titleLabel] setFont:[UIFont fontWithName:@"ChunkFive-Roman" size:TopButtonFontSize]];
        [self.btnBack setTitleColor:[UIColor colorWithRed:0.20f green:0.67f blue:0.31f alpha:1.00f] forState:UIControlStateNormal];
        [self addSubview:self.btnBack];
        [self.btnBack addTarget:self action:@selector(backToMainMenu:) forControlEvents:UIControlEventTouchUpInside];
        
        //INFO textfield
        self.txtInfo = [[UITextView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 295/2, self.btnBack.frame.origin.y + self.btnBack.frame.size.height, 295, 35)];
        self.txtInfo.userInteractionEnabled = NO;
        self.txtInfo.text = [@"Please leave your email address here so you can start sharing peace, love & ice cream" uppercaseString];
        self.txtInfo.backgroundColor = [UIColor clearColor];
        self.txtInfo.textAlignment = NSTextAlignmentCenter;
        self.txtInfo.textColor = [UIColor whiteColor];
        self.txtInfo.font = [UIFont fontWithName:@"Helvetica-Bold" size:9];
        [self addSubview:self.txtInfo];
        
        //icons
        NSString *pathIconsBg = [[NSBundle mainBundle] pathForResource:@"icons" ofType:@"png" inDirectory:@"images/views/ratetastes"];
        UIImage *iconsBg = [[UIImage alloc] initWithContentsOfFile:pathIconsBg];
        self.imgIcons = [[UIImageView alloc] initWithImage:iconsBg];
        self.imgIcons.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - iconsBg.size.width/2, self.txtInfo.frame.origin.y + self.txtInfo.frame.size.height + 10, iconsBg.size.width, iconsBg.size.height);
        [self addSubview:self.imgIcons];
        
        //Label email address
        self.lblEmailAddress = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 295/2, self.imgIcons.frame.origin.y + self.imgIcons.frame.size.height + 20, 295, 20)];
        self.lblEmailAddress.text = [@"email address:" uppercaseString];
        self.lblEmailAddress.backgroundColor = [UIColor clearColor];
        self.lblEmailAddress.textAlignment = NSTextAlignmentCenter;
        self.lblEmailAddress.textColor = [UIColor whiteColor];
        self.lblEmailAddress.font = [UIFont fontWithName:@"ChunkFive-Roman" size:20];
        [self addSubview:self.lblEmailAddress];
        
        //Textfield email address
        NSString *pathEmailAddressBg = [[NSBundle mainBundle] pathForResource:@"textfield2_bg" ofType:@"png" inDirectory:@"images/views/forms"];
        UIImage *emailAddressBg = [[UIImage alloc] initWithContentsOfFile:pathEmailAddressBg];
        self.txtEmailAddress = [[UITextField alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - emailAddressBg.size.width/2, self.lblEmailAddress.frame.origin.y + self.lblEmailAddress.frame.size.height + 5, emailAddressBg.size.width, emailAddressBg.size.height)];
        [self.txtEmailAddress setBackground:emailAddressBg];
        self.txtEmailAddress.textAlignment = NSTextAlignmentCenter;
        self.txtEmailAddress.delegate = self;
        self.txtEmailAddress.textColor = [UIColor colorWithRed:0.06f green:0.46f blue:0.74f alpha:1.00f];
        self.txtEmailAddress.font = [UIFont fontWithName:@"ChunkFive-Roman" size:20];
        self.txtEmailAddress.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
        self.txtEmailAddress.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self.txtEmailAddress setPlaceholder:[@"chunky.brownie@gmail.com" uppercaseString]];
        [[self.txtEmailAddress valueForKey:@"textInputTraits"] setValue:[UIColor colorWithRed:0.06f green:0.46f blue:0.74f alpha:1.00f] forKey:@"insertionPointColor"];
        [self addSubview:self.txtEmailAddress];
        
        //Label feedback email address
        self.lblFeedbackEmailAddress = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 295/2, self.txtEmailAddress.frame.origin.y + self.txtEmailAddress.frame.size.height + 3, 295, 10)];
        self.lblFeedbackEmailAddress.text = [@"Wow! Doesn't really look like an email address." uppercaseString];
        self.lblFeedbackEmailAddress.backgroundColor = [UIColor clearColor];
        self.lblFeedbackEmailAddress.textAlignment = NSTextAlignmentCenter;
        self.lblFeedbackEmailAddress.textColor = [UIColor colorWithRed:1.00f green:0.86f blue:0.01f alpha:1.00f];
        self.lblFeedbackEmailAddress.alpha = 0;
        self.lblFeedbackEmailAddress.font = [UIFont fontWithName:@"Helvetica-Bold" size:9];
        [self addSubview:self.lblFeedbackEmailAddress];
        
        //Btn Start Rating
        NSString *pathStartBg = [[NSBundle mainBundle] pathForResource:@"default_wide_bottom" ofType:@"png" inDirectory:@"images/views/ratetastes/buttons"];
        UIImage *startBg = [[UIImage alloc] initWithContentsOfFile:pathStartBg];
        self.btnStartRating = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnStartRating.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - startBg.size.width/2, 335, startBg.size.width, startBg.size.height);
        [self.btnStartRating setBackgroundImage:startBg forState:UIControlStateNormal];
        [self.btnStartRating setBackgroundImage:startBg forState:UIControlStateHighlighted];
        [self.btnStartRating setTitle:[@"start rating" uppercaseString] forState:UIControlStateNormal];
        [[self.btnStartRating titleLabel] setFont:[UIFont fontWithName:@"ChunkFive-Roman" size:TopButtonFontSize]];
        [self.btnStartRating setTitleColor:[UIColor colorWithRed:1.00f green:0.86f blue:0.01f alpha:1.00f] forState:UIControlStateNormal];
        [self.btnStartRating setTitleColor:[UIColor colorWithRed:1.00f green:0.93f blue:0.53f alpha:1.00f] forState:UIControlStateHighlighted];
        [self addSubview:self.btnStartRating];
        [self.btnStartRating addTarget:self action:@selector(startRating:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)backToMainMenu:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BACK_TO_MAIN_FROM_RATE_EMAIL" object:nil];
}

-(void)startRating:(id)sender{
    [self removeFeedbackForLabel:self.lblFeedbackEmailAddress];
    
    //check email address - NOT UNIQUE!
    if([self.txtEmailAddress.text length] == 0 || self.txtEmailAddress.text == [@"chunky.brownie@gmail.com" uppercaseString]){
        [self showFeedBack:@"Wow! This email should probably be a bit longer" forLabel:self.lblFeedbackEmailAddress];
    }else if(![Constants NSStringIsValidEmail:self.txtEmailAddress.text]){
        [self showFeedBack:@"Wow! Doesn't really look like an email address" forLabel:self.lblFeedbackEmailAddress];
    } else {
        //email passed validation
        [[NSUserDefaults standardUserDefaults] setObject:[self.txtEmailAddress.text lowercaseString]  forKey:@"email"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BACK_TO_RATETASTES_FROM_RATE_EMAIL" object:nil];
    }
}

-(void)showFeedBack:(NSString*)feedback forLabel:(UILabel*)label{
    label.text = [feedback uppercaseString];
    [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        label.alpha = 1;
    } completion:NULL];
}

-(void)removeFeedbackForLabel:(UILabel*)label{
    label.alpha = 0;
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
    if(self.btnStartRating.frame.origin.y + self.btnStartRating.frame.size.height + 10 > [[UIScreen mainScreen] bounds].size.height && self.allowScrollControl){
        if(self.contentOffset.y > self.btnStartRating.frame.origin.y + self.btnStartRating.frame.size.height + 10 - [[UIScreen mainScreen] bounds].size.height){
            self.contentOffset = CGPointMake(0, self.btnStartRating.frame.origin.y + self.btnStartRating.frame.size.height + 10 - [[UIScreen mainScreen] bounds].size.height);
        }
    }
}

//Textfield control
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [self.txtEmailAddress resignFirstResponder];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.allowScrollControl = NO;
    [UIView animateWithDuration:.3 animations:^{
        self.contentOffset = CGPointMake(0, 100);
    }];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:.3 animations:^{
        self.contentOffset = CGPointMake(0, 0);
    }completion:^(BOOL finished){
        self.allowScrollControl = YES;
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self startRating:@""];
    return TRUE;
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

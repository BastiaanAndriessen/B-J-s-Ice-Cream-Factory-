//
//  SaveMixedIngredientScrollView.m
//  B&J
//
//  Created by Bastiaan Andriessen on 27/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "SaveMixedIngredientScrollView.h"
#import "Constants.h"
#import "Ingredient.h"

@implementation SaveMixedIngredientScrollView

@synthesize allowScrollControl = _allowScrollControl;

@synthesize background = _background;
@synthesize cloud = _cloud;
@synthesize cloud2 = _cloud2;
@synthesize colorFrame = _colorFrame;
@synthesize btnLogo = _btnLogo;
@synthesize btnBack = _btnBack;
@synthesize lblCongrats = _lblCongrats;
@synthesize txtInfo = _txtInfo;

@synthesize lblIngredientName = _lblIngredientName;
@synthesize txtIngredientName = _txtIngredientName;
@synthesize lblFeedback = _lblFeedback;

@synthesize lblCreation = _lblCreation;
@synthesize ingredient1V = _ingredient1V;
@synthesize ingredient2V = _ingredient2V;

@synthesize btnSave = _btnSave;

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
        [self.btnBack addTarget:self action:@selector(backToMixerFromSaveIngredient:) forControlEvents:UIControlEventTouchUpInside];
        
        //INFO LABEL
        self.lblCongrats = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 295/2, self.btnBack.frame.origin.y + self.btnBack.frame.size.height + 10, 295, 10)];
        self.lblCongrats.text = [@"Congratulations!" uppercaseString];
        self.lblCongrats.backgroundColor = [UIColor clearColor];
        self.lblCongrats.textAlignment = NSTextAlignmentCenter;
        self.lblCongrats.textColor = [UIColor whiteColor];
        self.lblCongrats.font = [UIFont fontWithName:@"Helvetica-Bold" size:11];
        [self addSubview:self.lblCongrats];
        
        //INFO textfield
        self.txtInfo = [[UITextView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 250/2, self.lblCongrats.frame.origin.y + self.lblCongrats.frame.size.height, 250, 44)];
        self.txtInfo.userInteractionEnabled = NO;
        self.txtInfo.text = [@"You’ve successfully created a new mix. Give your creation a name and use it in your new ice cream." uppercaseString];
        self.txtInfo.backgroundColor = [UIColor clearColor];
        self.txtInfo.textAlignment = NSTextAlignmentCenter;
        self.txtInfo.textColor = [UIColor whiteColor];
        self.txtInfo.font = [UIFont fontWithName:@"Helvetica-Bold" size:9];
        [self addSubview:self.txtInfo];
        
        //Label Ingredient Name
        self.lblIngredientName = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 295/2, self.txtInfo.frame.origin.y + self.txtInfo.frame.size.height + 30, 295, 20)];
        self.lblIngredientName.text = [@"mix name:" uppercaseString];
        self.lblIngredientName.backgroundColor = [UIColor clearColor];
        self.lblIngredientName.textAlignment = NSTextAlignmentCenter;
        self.lblIngredientName.textColor = [UIColor whiteColor];
        self.lblIngredientName.font = [UIFont fontWithName:@"ChunkFive-Roman" size:20];
        [self addSubview:self.lblIngredientName];
        
        //Textfield Ingredient Name
        NSString *pathFirstNameBg = [[NSBundle mainBundle] pathForResource:@"textfield_bg" ofType:@"png" inDirectory:@"images/views/forms"];
        UIImage *firstNameBg = [[UIImage alloc] initWithContentsOfFile:pathFirstNameBg];
        self.txtIngredientName = [[UITextField alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - firstNameBg.size.width/2, self.lblIngredientName.frame.origin.y + self.lblIngredientName.frame.size.height + 5, firstNameBg.size.width, firstNameBg.size.height)];
        [self.txtIngredientName setBackground:firstNameBg];
        self.txtIngredientName.textAlignment = NSTextAlignmentCenter;
        self.txtIngredientName.delegate = self;
        self.txtIngredientName.textColor = [UIColor colorWithRed:0.98f green:0.42f blue:0.64f alpha:1.00f];
        self.txtIngredientName.font = [UIFont fontWithName:@"ChunkFive-Roman" size:20];
        self.txtIngredientName.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
        self.txtIngredientName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self.txtIngredientName setPlaceholder:[@"I scream" uppercaseString]];
        [[self.txtIngredientName valueForKey:@"textInputTraits"] setValue:[UIColor colorWithRed:0.98f green:0.42f blue:0.64f alpha:1.00f] forKey:@"insertionPointColor"];
        [self addSubview:self.txtIngredientName];
        
        //Label Feedback
        self.lblFeedback = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 295/2, self.txtIngredientName.frame.origin.y + self.txtIngredientName.frame.size.height + 3, 295, 10)];
        self.lblFeedback.text = [@"Oops! The mix name can only be 15 characters long." uppercaseString];
        self.lblFeedback.backgroundColor = [UIColor clearColor];
        self.lblFeedback.textAlignment = NSTextAlignmentCenter;
        self.lblFeedback.textColor = [UIColor colorWithRed:0.76f green:0.16f blue:0.41f alpha:1.00f];
        self.lblFeedback.alpha = 0;
        self.lblFeedback.font = [UIFont fontWithName:@"Helvetica-Bold" size:9];
        [self addSubview:self.lblFeedback];
        
        //Label Creation
        self.lblCreation = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 295/2, self.txtIngredientName.frame.origin.y + self.txtIngredientName.frame.size.height + 40, 295, 10)];
        self.lblCreation.text = [@"Your new creation contains: " uppercaseString];
        self.lblCreation.backgroundColor = [UIColor clearColor];
        self.lblCreation.textAlignment = NSTextAlignmentCenter;
        self.lblCreation.textColor = [UIColor whiteColor];
        self.lblCreation.font = [UIFont fontWithName:@"Helvetica-Bold" size:10];
        [self addSubview:self.lblCreation];
        
        //Btn Save
        NSString *pathSaveBg = [[NSBundle mainBundle] pathForResource:@"default_wide_bottom" ofType:@"png" inDirectory:@"images/views/tastemixer/buttons"];
        UIImage *save = [[UIImage alloc] initWithContentsOfFile:pathSaveBg];
        self.btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnSave.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - save.size.width/2, 500, save.size.width, save.size.height);
        [self.btnSave setBackgroundImage:save forState:UIControlStateNormal];
        [self.btnSave setBackgroundImage:save forState:UIControlStateHighlighted];
        [self.btnSave setTitle:[@"save new mix" uppercaseString] forState:UIControlStateNormal];
        [[self.btnSave titleLabel] setFont:[UIFont fontWithName:@"ChunkFive-Roman" size:TopButtonFontSize+2]];
        [self.btnSave setTitleColor:[UIColor colorWithRed:1.00f green:0.86f blue:0.01f alpha:1.00f] forState:UIControlStateNormal];
        [self.btnSave setTitleColor:[UIColor colorWithRed:1.00f green:0.93f blue:0.53f alpha:1.00f] forState:UIControlStateHighlighted];
        [self addSubview:self.btnSave];
        [self.btnSave addTarget:self action:@selector(tappedSaveMix:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)tappedSaveMix:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SAVE_NEW_MIX" object:nil];
}

-(void)setupIngredientView:(Ingredient*)ingredientDataObject{
    NSString *pathIngredientVBg = [[NSBundle mainBundle] pathForResource:@"background_large" ofType:@"png" inDirectory:@"images/views/ingredients"];
    UIImage *ingredientVBg = [[UIImage alloc] initWithContentsOfFile:pathIngredientVBg];
    UIImageView *imgIngredientVBg = [[UIImageView alloc] initWithImage:ingredientVBg];
    [self addSubview:imgIngredientVBg];
    if(!self.ingredient1V){
        self.ingredient1V = [[IngredientView alloc] initWithFrame:CGRectMake(12,self.lblCreation.frame.origin.y + self.lblCreation.frame.size.height + 5,140,125) andIngredientDataObject:ingredientDataObject];
        [self addSubview:self.ingredient1V];
        imgIngredientVBg.frame = CGRectMake(self.ingredient1V.frame.origin.x, self.ingredient1V.frame.origin.y, ingredientVBg.size.width, ingredientVBg.size.height);
    }else{
        self.ingredient2V = [[IngredientView alloc] initWithFrame:CGRectMake(self.ingredient1V.frame.origin.x + self.ingredient1V.frame.size.width + 10,self.lblCreation.frame.origin.y + self.lblCreation.frame.size.height + 5,140,125) andIngredientDataObject:ingredientDataObject];
        [self addSubview:self.ingredient2V];
        imgIngredientVBg.frame = CGRectMake(self.ingredient2V.frame.origin.x, self.ingredient2V.frame.origin.y, ingredientVBg.size.width, ingredientVBg.size.height);
    }
}

-(void)backToMixerFromSaveIngredient:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BACK_TO_MIXER_FROM_SAVE_MIX" object:nil];
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
    if(self.background.frame.size.height > [[UIScreen mainScreen] bounds].size.height && self.allowScrollControl){
        if(self.contentOffset.y > self.background.frame.size.height - [[UIScreen mainScreen] bounds].size.height){
            self.contentOffset = CGPointMake(0, self.background.frame.size.height - [[UIScreen mainScreen] bounds].size.height);
        }
    }
    if(!self.allowScrollControl){
        [UIView animateWithDuration:.3 animations:^{
            self.contentOffset = CGPointMake(0, 100);
        }];
    }
}

//Textfield control
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    if(newLength > 15){
        self.lblFeedback.text = [@"Oops! The mix name can only be 15 characters long." uppercaseString];
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.lblFeedback.alpha = 1;
        } completion:NULL];
    } else {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.lblFeedback.alpha = 0;
        } completion:NULL];
    }
    return (newLength > 15) ? NO : YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [self.txtIngredientName resignFirstResponder];
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
        if(self.background.frame.size.height > [[UIScreen mainScreen] bounds].size.height){
            self.contentOffset = CGPointMake(0, 100);
        }
    }completion:^(BOOL finished){
        self.allowScrollControl = YES;
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SAVE_NEW_MIX" object:nil];
    [textField resignFirstResponder];
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

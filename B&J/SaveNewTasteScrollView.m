//
//  SaveNewTasteScrollView.m
//  B&J
//
//  Created by Bastiaan Andriessen on 27/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "SaveNewTasteScrollView.h"
#import "Constants.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFJSONRequestOperation.h"
#import "Ingredient.h"

@implementation SaveNewTasteScrollView

@synthesize arrAddedIngredientDataObjects = _arrAddedIngredientDataObjects;
@synthesize allowScrollControl = _allowScrollControl;
@synthesize ownContentSize = _ownContentSize;

@synthesize timer = _timer;

@synthesize background = _background;
@synthesize cloud = _cloud;
@synthesize cloud2 = _cloud2;
@synthesize colorFrame = _colorFrame;
@synthesize btnLogo = _btnLogo;
@synthesize btnBack = _btnBack;
@synthesize lblCongrats = _lblCongrats;
@synthesize txtInfo = _txtInfo;

@synthesize lblIceCreamName = _lblIceCreamName;
@synthesize txtIceCreamName = _txtIceCreamName;
@synthesize lblFeedbackIceCream = _lblFeedbackIceCream;

@synthesize lblUserName = _lblUserName;
@synthesize txtUserName = _txtUserName;
@synthesize lblFeedbackUserName = _lblFeedbackUserName;

@synthesize lblEmailAddress = _lblEmailAddress;
@synthesize txtEmailAddress = _txtEmailAddress;
@synthesize lblFeedbackEmailAddress = _lblFeedbackEmailAddress;

@synthesize btnSave = _btnSave;

- (id)initWithFrame:(CGRect)frame arrAddedIngredientDataObjects:(NSArray*)arrAddedIngredientDataObjects
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.allowScrollControl = YES;
        self.arrAddedIngredientDataObjects = arrAddedIngredientDataObjects;
        
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
        NSString *pathBackBg = [[NSBundle mainBundle] pathForResource:@"mainmenu_wide" ofType:@"png" inDirectory:@"images/views/buttons/mainmenu"];
        UIImage *backBg = [[UIImage alloc] initWithContentsOfFile:pathBackBg];
        self.btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnBack.frame = CGRectMake(TopButtonLeftOffsetLeft, TopButtonOffsetTop, backBg.size.width, backBg.size.height);
        [self.btnBack setBackgroundImage:backBg forState:UIControlStateNormal];
        NSString *pathBackBgh = [[NSBundle mainBundle] pathForResource:@"mainmenu_wideh" ofType:@"png" inDirectory:@"images/views/buttons/mainmenu"];
        UIImage *backBgh = [[UIImage alloc] initWithContentsOfFile:pathBackBgh];
        [self.btnBack setBackgroundImage:backBgh forState:UIControlStateHighlighted];
        [self.btnBack setTitle:[@"main menu" uppercaseString] forState:UIControlStateNormal];
        [[self.btnBack titleLabel] setFont:[UIFont fontWithName:@"ChunkFive-Roman" size:TopButtonFontSize]];
        [self.btnBack setTitleColor:[UIColor colorWithRed:0.24f green:0.67f blue:0.24f alpha:1.00f] forState:UIControlStateNormal];
        [self addSubview:self.btnBack];
        [self.btnBack addTarget:self action:@selector(backToMainMenu:) forControlEvents:UIControlEventTouchUpInside];
        
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
        self.txtInfo.text = [@"You’ve finished your own new ice cream taste. Give it a cool name and share the love with your friends." uppercaseString];
        self.txtInfo.backgroundColor = [UIColor clearColor];
        self.txtInfo.textAlignment = NSTextAlignmentCenter;
        self.txtInfo.textColor = [UIColor whiteColor];
        self.txtInfo.font = [UIFont fontWithName:@"Helvetica-Bold" size:9];
        [self addSubview:self.txtInfo];
        
        //Label Ice cream name
        self.lblIceCreamName = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 295/2, self.txtInfo.frame.origin.y + self.txtInfo.frame.size.height + 20, 295, 20)];
        self.lblIceCreamName.text = [@"Ice cream name:" uppercaseString];
        self.lblIceCreamName.backgroundColor = [UIColor clearColor];
        self.lblIceCreamName.textAlignment = NSTextAlignmentCenter;
        self.lblIceCreamName.textColor = [UIColor whiteColor];
        self.lblIceCreamName.font = [UIFont fontWithName:@"ChunkFive-Roman" size:20];
        [self addSubview:self.lblIceCreamName];
        
        //Textfield ice cream name
        NSString *pathIceCreamNameBg = [[NSBundle mainBundle] pathForResource:@"textfield_bg" ofType:@"png" inDirectory:@"images/views/forms"];
        UIImage *iceCreamNameBg = [[UIImage alloc] initWithContentsOfFile:pathIceCreamNameBg];
        self.txtIceCreamName = [[UITextField alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - iceCreamNameBg.size.width/2, self.lblIceCreamName.frame.origin.y + self.lblIceCreamName.frame.size.height + 5, iceCreamNameBg.size.width, iceCreamNameBg.size.height)];
        [self.txtIceCreamName setBackground:iceCreamNameBg];
        self.txtIceCreamName.textAlignment = NSTextAlignmentCenter;
        self.txtIceCreamName.delegate = self;
        self.txtIceCreamName.textColor = [UIColor colorWithRed:0.98f green:0.42f blue:0.64f alpha:1.00f];
        self.txtIceCreamName.font = [UIFont fontWithName:@"ChunkFive-Roman" size:20];
        self.txtIceCreamName.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
        self.txtIceCreamName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self.txtIceCreamName setPlaceholder:[@"Chocolatte" uppercaseString]];
        [[self.txtIceCreamName valueForKey:@"textInputTraits"] setValue:[UIColor colorWithRed:0.98f green:0.42f blue:0.64f alpha:1.00f] forKey:@"insertionPointColor"];
        [self addSubview:self.txtIceCreamName];
        
        //Label Feedback ice cream
        self.lblFeedbackIceCream = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 295/2, self.txtIceCreamName.frame.origin.y + self.txtIceCreamName.frame.size.height + 3, 295, 10)];
        self.lblFeedbackIceCream.text = [@"Oops! The ice cream name can only be 15 characters long." uppercaseString];
        self.lblFeedbackIceCream.backgroundColor = [UIColor clearColor];
        self.lblFeedbackIceCream.textAlignment = NSTextAlignmentCenter;
        self.lblFeedbackIceCream.textColor = [UIColor colorWithRed:0.76f green:0.16f blue:0.41f alpha:1.00f];
        self.lblFeedbackIceCream.alpha = 0;
        self.lblFeedbackIceCream.font = [UIFont fontWithName:@"Helvetica-Bold" size:9];
        [self addSubview:self.lblFeedbackIceCream];
        
        //Label username
        self.lblUserName = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 295/2, self.lblFeedbackIceCream.frame.origin.y + self.lblFeedbackIceCream.frame.size.height + 10, 295, 20)];
        self.lblUserName.text = [@"username:" uppercaseString];
        self.lblUserName.backgroundColor = [UIColor clearColor];
        self.lblUserName.textAlignment = NSTextAlignmentCenter;
        self.lblUserName.textColor = [UIColor whiteColor];
        self.lblUserName.font = [UIFont fontWithName:@"ChunkFive-Roman" size:20];
        [self addSubview:self.lblUserName];
        
        //Textfield username
        NSString *pathUsernameBg = [[NSBundle mainBundle] pathForResource:@"textfield_bg" ofType:@"png" inDirectory:@"images/views/forms"];
        UIImage *usernameBg = [[UIImage alloc] initWithContentsOfFile:pathUsernameBg];
        self.txtUserName = [[UITextField alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - usernameBg.size.width/2, self.lblUserName.frame.origin.y + self.lblUserName.frame.size.height + 5, usernameBg.size.width, usernameBg.size.height)];
        [self.txtUserName setBackground:usernameBg];
        self.txtUserName.textAlignment = NSTextAlignmentCenter;
        self.txtUserName.delegate = self;
        self.txtUserName.textColor = [UIColor colorWithRed:0.98f green:0.42f blue:0.64f alpha:1.00f];
        self.txtUserName.font = [UIFont fontWithName:@"ChunkFive-Roman" size:20];
        self.txtUserName.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
        self.txtUserName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self.txtUserName setPlaceholder:[@"Mr. Brownie" uppercaseString]];
        [[self.txtUserName valueForKey:@"textInputTraits"] setValue:[UIColor colorWithRed:0.98f green:0.42f blue:0.64f alpha:1.00f] forKey:@"insertionPointColor"];
        [self addSubview:self.txtUserName];
        
        //Label feedback username
        self.lblFeedbackUserName = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 295/2, self.txtUserName.frame.origin.y + self.txtUserName.frame.size.height + 3, 295, 10)];
        self.lblFeedbackUserName.text = [@"Yep! Seems like this username's too long." uppercaseString];
        self.lblFeedbackUserName.backgroundColor = [UIColor clearColor];
        self.lblFeedbackUserName.textAlignment = NSTextAlignmentCenter;
        self.lblFeedbackUserName.textColor = [UIColor colorWithRed:0.76f green:0.16f blue:0.41f alpha:1.00f];
        self.lblFeedbackUserName.alpha = 0;
        self.lblFeedbackUserName.font = [UIFont fontWithName:@"Helvetica-Bold" size:9];
        [self addSubview:self.lblFeedbackUserName];
        
        //Label email address
        self.lblEmailAddress = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 295/2, self.lblFeedbackUserName.frame.origin.y + self.lblFeedbackUserName.frame.size.height + 10, 295, 20)];
        self.lblEmailAddress.text = [@"email address:" uppercaseString];
        self.lblEmailAddress.backgroundColor = [UIColor clearColor];
        self.lblEmailAddress.textAlignment = NSTextAlignmentCenter;
        self.lblEmailAddress.textColor = [UIColor whiteColor];
        self.lblEmailAddress.font = [UIFont fontWithName:@"ChunkFive-Roman" size:20];
        [self addSubview:self.lblEmailAddress];
        
        //Textfield email address
        NSString *pathEmailAddressBg = [[NSBundle mainBundle] pathForResource:@"textfield_bg" ofType:@"png" inDirectory:@"images/views/forms"];
        UIImage *emailAddressBg = [[UIImage alloc] initWithContentsOfFile:pathEmailAddressBg];
        self.txtEmailAddress = [[UITextField alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - emailAddressBg.size.width/2, self.lblEmailAddress.frame.origin.y + self.lblEmailAddress.frame.size.height + 5, emailAddressBg.size.width, emailAddressBg.size.height)];
        [self.txtEmailAddress setBackground:emailAddressBg];
        self.txtEmailAddress.textAlignment = NSTextAlignmentCenter;
        self.txtEmailAddress.delegate = self;
        self.txtEmailAddress.textColor = [UIColor colorWithRed:0.98f green:0.42f blue:0.64f alpha:1.00f];
        self.txtEmailAddress.font = [UIFont fontWithName:@"ChunkFive-Roman" size:20];
        self.txtEmailAddress.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
        self.txtEmailAddress.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self.txtEmailAddress setPlaceholder:[@"chunky.brownie@gmail.com" uppercaseString]];
        [[self.txtEmailAddress valueForKey:@"textInputTraits"] setValue:[UIColor colorWithRed:0.98f green:0.42f blue:0.64f alpha:1.00f] forKey:@"insertionPointColor"];
        [self addSubview:self.txtEmailAddress];
        
        //Label feedback email address
        self.lblFeedbackEmailAddress = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 295/2, self.txtEmailAddress.frame.origin.y + self.txtEmailAddress.frame.size.height + 3, 295, 10)];
        self.lblFeedbackEmailAddress.text = [@"Wow! Doesn't really look like an email address." uppercaseString];
        self.lblFeedbackEmailAddress.backgroundColor = [UIColor clearColor];
        self.lblFeedbackEmailAddress.textAlignment = NSTextAlignmentCenter;
        self.lblFeedbackEmailAddress.textColor = [UIColor colorWithRed:0.76f green:0.16f blue:0.41f alpha:1.00f];
        self.lblFeedbackEmailAddress.alpha = 0;
        self.lblFeedbackEmailAddress.font = [UIFont fontWithName:@"Helvetica-Bold" size:9];
        [self addSubview:self.lblFeedbackEmailAddress];
        
        //Btn Save
        NSString *pathSaveBg = [[NSBundle mainBundle] pathForResource:@"default_wide_bottom" ofType:@"png" inDirectory:@"images/views/tastemixer/buttons"];
        UIImage *save = [[UIImage alloc] initWithContentsOfFile:pathSaveBg];
        self.btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnSave.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - save.size.width/2, 515, save.size.width, save.size.height);
        [self.btnSave setBackgroundImage:save forState:UIControlStateNormal];
        [self.btnSave setBackgroundImage:save forState:UIControlStateHighlighted];
        [self.btnSave setTitle:[@"save ice cream" uppercaseString] forState:UIControlStateNormal];
        [[self.btnSave titleLabel] setFont:[UIFont fontWithName:@"ChunkFive-Roman" size:TopButtonFontSize+2]];
        [self.btnSave setTitleColor:[UIColor colorWithRed:1.00f green:0.86f blue:0.01f alpha:1.00f] forState:UIControlStateNormal];
        [self.btnSave setTitleColor:[UIColor colorWithRed:1.00f green:0.93f blue:0.53f alpha:1.00f] forState:UIControlStateHighlighted];
        [self addSubview:self.btnSave];
        [self.btnSave addTarget:self action:@selector(tappedSaveIceCream:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)tappedSaveIceCream:(id)sender{
    [self removeFeedbackForLabel:self.lblFeedbackIceCream];
    [self removeFeedbackForLabel:self.lblFeedbackUserName];
    [self removeFeedbackForLabel:self.lblFeedbackEmailAddress];
    
    __block BOOL isIceCreamError = NO;
    __block BOOL isUsernameError = NO;
    __block BOOL isEmailAddressError = NO;
    
    //check ice cream name - UNIQUE!
    if([self.txtIceCreamName.text length] > 15 || self.txtIceCreamName.text == [@"chocolatte" uppercaseString]){
        isIceCreamError = YES;
        [self showFeedBack:@"Oops! The ice cream name can only be 15 characters long" forLabel:self.lblFeedbackIceCream];
    } else if([self.txtIceCreamName.text length] < 5){
        isIceCreamError = YES;
        [self showFeedBack:@"Oops! Can't you think up a longer name? (min 5)" forLabel:self.lblFeedbackIceCream];
    }
    
    //check username - UNIQUE!
    if([self.txtUserName.text length] > 20 || self.txtUserName.text == [@"mr. brownie" uppercaseString]){
        isUsernameError = YES;
        [self showFeedBack:@"Yep! Seems like this username's too long (max 20)" forLabel:self.lblFeedbackUserName];
    } else if([self.txtUserName.text length] < 3){
        isUsernameError = YES;
        [self showFeedBack:@"Yep! The username should be minimum 3 characters" forLabel:self.lblFeedbackUserName];
    }
    
    //check email address - UNIQUE!
    if([self.txtEmailAddress.text length] == 0 ||  self.txtEmailAddress.text == [@"chunky.brownie@gmail.com" uppercaseString]){
        isEmailAddressError = YES;
        [self showFeedBack:@"Wow! This email should probably be a bit longer" forLabel:self.lblFeedbackEmailAddress];
    }else if(![Constants NSStringIsValidEmail:self.txtEmailAddress.text]){
        isEmailAddressError = YES;
        [self showFeedBack:@"Wow! Doesn't really look like an email address" forLabel:self.lblFeedbackEmailAddress];
    }
    
    if(!isIceCreamError || !isUsernameError || !isEmailAddressError){
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@icecreamtastes",ApiUrl]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            if([JSON count] == 0){
                [self saveIceCreamTaste];
            }else{
                for(int i = 0; i<[JSON count]; i++){
                    //check if unique
                    if([[[JSON objectAtIndex:i] objectForKey:@"name"] isEqualToString:[self.txtIceCreamName.text lowercaseString]]){
                        isIceCreamError = YES;
                        [self showFeedBack:@"Oops! Someone already chose this name" forLabel:self.lblFeedbackIceCream];
                    }
                    
                    if([[[JSON objectAtIndex:i] objectForKey:@"username"] isEqualToString:[self.txtUserName.text lowercaseString]]){
                        isUsernameError = YES;
                        [self showFeedBack:@"Yep! The chosen username isn't unique" forLabel:self.lblFeedbackUserName];
                    }
                    
                    if([[[JSON objectAtIndex:i] objectForKey:@"email_address"] isEqualToString:[self.txtEmailAddress.text lowercaseString]]){
                        isEmailAddressError = YES;
                        [self showFeedBack:@"Wow! This email address is already taken" forLabel:self.lblFeedbackEmailAddress];
                    }
                }
                
                if(!isIceCreamError && !isUsernameError && !isEmailAddressError){
                    [self saveIceCreamTaste];
                }
            }
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"[SaveNewTasteScrollView] Error getting ice cream tastes");
        }];
        [operation start];
    }
}

-(void)saveIceCreamTaste{
    [self.btnSave setEnabled:NO];
    [self.btnSave setTitle:[@"Saving..." uppercaseString] forState:UIControlStateNormal];
    self.txtIceCreamName.userInteractionEnabled = NO;
    self.txtUserName.userInteractionEnabled = NO;
    self.txtEmailAddress.userInteractionEnabled = NO;
    
    //preparation of data vars
    NSString *ingredientIds = [NSString string];
    NSString *name = [self.txtIceCreamName.text lowercaseString];
    NSString *colorCodes = [NSString string];
    NSString *username = [self.txtUserName.text lowercaseString];
    NSString *emailAddress = [self.txtEmailAddress.text lowercaseString];
    BOOL isFirstRun = YES;
    for(int i = 0; i<[self.arrAddedIngredientDataObjects count]; i++){
        Ingredient *currentIngredient = [self.arrAddedIngredientDataObjects objectAtIndex:i];
        if(currentIngredient.isIngredientMixed){
            if(isFirstRun){
                ingredientIds = [NSString stringWithFormat:@"m%@",currentIngredient.ingredientId];
            }else{
                ingredientIds = [NSString stringWithFormat:@"%@,m%@",ingredientIds,currentIngredient.ingredientId];
            }
        }else{
            if(isFirstRun){
                ingredientIds = [NSString stringWithFormat:@"%@",currentIngredient.ingredientId];
            }else{
                ingredientIds = [NSString stringWithFormat:@"%@,%@",ingredientIds,currentIngredient.ingredientId];
            }
        }
        if(isFirstRun){
            isFirstRun = NO;
            colorCodes = [NSString stringWithFormat:@"%@",currentIngredient.colorCode];
        }else{
            colorCodes = [NSString stringWithFormat:@"%@,%@",colorCodes,currentIngredient.colorCode];
        }
    }
    
    NSURL *url = [NSURL URLWithString:ApiUrl];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            ingredientIds, @"ingredient_ids",
                            name, @"name",
                            colorCodes, @"color_codes",
                            username, @"username",
                            emailAddress, @"email_address",
                            nil];
    [httpClient postPath:@"icecreamtaste" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        [self.btnSave setTitle:[@"Saving Complete" uppercaseString] forState:UIControlStateNormal];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(backToMainMenu:) userInfo:nil repeats:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
    }];
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

-(void)backToMainMenu:(id)sender{
    [self.timer invalidate];
    self.timer = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BACK_TO_MAIN_MENU" object:nil];
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
}

//Textfield control
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    if(textField == self.txtIceCreamName){
        if(newLength > 15)[self showFeedBack:@"Oops! The ice cream name can only be 15 characters" forLabel:self.lblFeedbackIceCream];
        return (newLength > 15) ? NO : YES;
    }else if(textField == self.txtUserName){
        if(newLength > 20)[self showFeedBack:@"Yep! Seems like this username's too long (max 20)." forLabel:self.lblFeedbackUserName];
        return (newLength > 20) ? NO : YES;
    }else{
        return YES;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [self.txtIceCreamName resignFirstResponder];
        [self.txtUserName resignFirstResponder];
        [self.txtEmailAddress resignFirstResponder];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.allowScrollControl = NO;
    self.ownContentSize = self.contentSize;
    self.contentSize = CGSizeMake(self.ownContentSize.width, 5000);
    
    UIScrollView* v = (UIScrollView*) self ;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:v];
    rc.origin.x = 0 ;
    if(textField == self.txtIceCreamName){
        rc.origin.y -= 60 ;
    }else if(textField == self.txtUserName){
        rc.origin.y -= 80 ;
    }else if(textField == self.txtEmailAddress){
        rc.origin.y -= 100 ;
    }
    rc.size.height = 400;
    [self scrollRectToVisible:rc animated:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:.3 animations:^{
        self.contentOffset = CGPointMake(0, 0);
    }completion:^(BOOL finished){
        self.allowScrollControl = YES;
        self.contentSize = self.ownContentSize;
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self tappedSaveIceCream:@""];
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

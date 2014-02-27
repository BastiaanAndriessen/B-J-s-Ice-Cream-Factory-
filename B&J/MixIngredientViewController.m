//
//  MixIngredientViewController.m
//  B&J
//
//  Created by Bastiaan Andriessen on 25/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "MixIngredientViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFJSONRequestOperation.h"

@interface MixIngredientViewController ()

@end

@implementation MixIngredientViewController

@synthesize mixIngredientScrollV = _mixIngredientScrollV;
@synthesize mixedColorCode = _mixedColorCode;
@synthesize isRotating = _isRotating;
@synthesize allowEndAnimation = _allowEndAnimation;
@synthesize allowShakeDetection = _allowShakeDetection;
@synthesize timer = _timer;
@synthesize timer2 = _timer2;
@synthesize currentRotation = _currentRotation;
@synthesize progress = _progress;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.isRotating = NO;
        self.allowEndAnimation = NO;
        self.currentRotation = 0;
        self.progress = 0;
        self.allowShakeDetection = NO;
    }
    return self;
}

-(void)loadView{
    UIView *mainView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setView:mainView];
    mainView.backgroundColor = [UIColor clearColor];
    
    self.mixIngredientScrollV = [[MixIngredientScrollView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.mixIngredientScrollV setClipsToBounds:YES];
    [self.mixIngredientScrollV setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [self.mixIngredientScrollV setUserInteractionEnabled:YES];
    [mainView addSubview:self.mixIngredientScrollV];
    
    mainView.userInteractionEnabled = YES;
    self.mixIngredientScrollV.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, self.mixIngredientScrollV.background.frame.size.height);
    self.mixIngredientScrollV.scrollEnabled = YES;
    self.mixIngredientScrollV.showsVerticalScrollIndicator = NO;
    self.mixIngredientScrollV.delaysContentTouches = YES;
    self.mixIngredientScrollV.canCancelContentTouches = NO;
    self.mixIngredientScrollV.delegate = self.mixIngredientScrollV;
    [self.mixIngredientScrollV disableMixboard];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disableShaking:) name:@"DISABLE_SHAKING" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enableShaking:) name:@"ENABLE_SHAKING" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkIngredients:) name:@"CHECK_INGREDIENTS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ingredientsChanged:) name:@"INGREDIENTS_CHANGED" object:nil];
}

-(void)disableShaking:(id)sender{
    self.allowShakeDetection = NO;
}

-(void)enableShaking:(id)sender{
    self.allowShakeDetection = YES;
}

-(void)ingredientsChanged:(id)sender{
    [self.mixIngredientScrollV.progressBarV setMarkerValue:0];
    
    NSString *color1 = self.mixIngredientScrollV.selectedIngredient1.colorCode;
    NSString *color2 = self.mixIngredientScrollV.selectedIngredient2.colorCode;
    
    if(color1 && color2){
        //color 1
        NSString *color1r = [color1 substringWithRange:NSMakeRange(0, 2)];
        NSString *color1g = [color1 substringWithRange:NSMakeRange(2, 2)];
        NSString *color1b = [color1 substringWithRange:NSMakeRange(4, 2)];
    
        uint32_t value1r;
        const char *string1r = [color1r cStringUsingEncoding:NSUTF8StringEncoding];
        sscanf(string1r, "%x" , &value1r);
    
        uint32_t value1g;
        const char *string1g = [color1g cStringUsingEncoding:NSUTF8StringEncoding];
        sscanf(string1g, "%x" , &value1g);
    
        uint32_t value1b;
        const char *string1b = [color1b cStringUsingEncoding:NSUTF8StringEncoding];
        sscanf(string1b, "%x" , &value1b);
    
        //color 2
        NSString *color2r = [color2 substringWithRange:NSMakeRange(0, 2)];
        NSString *color2g = [color2 substringWithRange:NSMakeRange(2, 2)];
        NSString *color2b = [color2 substringWithRange:NSMakeRange(4, 2)];
    
        uint32_t value2r;
        const char *string2r = [color2r cStringUsingEncoding:NSUTF8StringEncoding];
        sscanf(string2r, "%x" , &value2r);
    
        uint32_t value2g;
        const char *string2g = [color2g cStringUsingEncoding:NSUTF8StringEncoding];
        sscanf(string2g, "%x" , &value2g);
    
        uint32_t value2b;
        const char *string2b = [color2b cStringUsingEncoding:NSUTF8StringEncoding];
        sscanf(string2b, "%x" , &value2b);
    
        //new color
        int newColorr = (value1r+value2r)/2;
        char hexStrr[20];
        sprintf(hexStrr,"%x",newColorr);
        NSString *strNewColorr = [NSString stringWithFormat:@"%s",hexStrr];
        if([strNewColorr length]==1){
            strNewColorr = [NSString stringWithFormat:@"0%@",strNewColorr];
        }
    
        int newColorg = (value1g+value2g)/2;
        char hexStrg[20];
        sprintf(hexStrg,"%x",newColorg);
        NSString *strNewColorg = [NSString stringWithFormat:@"%s",hexStrg];
        if([strNewColorg length]==1){
            strNewColorg = [NSString stringWithFormat:@"0%@",strNewColorg];
        }
    
        int newColorb = (value1b+value2b)/2;
        char hexStrb[20];
        sprintf(hexStrb,"%x",newColorb);
        NSString *strNewColorb = [NSString stringWithFormat:@"%s",hexStrb];
        if([strNewColorb length]==1){
            strNewColorb = [NSString stringWithFormat:@"0%@",strNewColorb];
        }
    
        NSString *newColorCode = [NSString stringWithFormat:@"%@%@%@",strNewColorr, strNewColorg, strNewColorb];
        self.mixedColorCode = newColorCode;
        [self.mixIngredientScrollV setMixBoardOverlayColor:self.mixedColorCode];
    }
}

-(void)checkIngredients:(id)sender{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@newingredients",ApiUrl]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSString *concatenated_ingredient_ids = [[NSUserDefaults standardUserDefaults] objectForKey:@"allowed_new_ingredients_ids"];
        NSArray *newIngredientIds = [concatenated_ingredient_ids componentsSeparatedByString: @","];
        //make an array out of the JSON
        NSMutableArray *arrNewIngredientCombinationIds = [NSMutableArray array];
        for(int i = 0; i<[JSON count]; i++){
            for(int j = 0; j<[newIngredientIds count]; j++){
                if([[[JSON objectAtIndex:i] objectForKey:@"id"] intValue] == [[newIngredientIds objectAtIndex:j] intValue]){
                    NSString *concatenated_ingredient_ids = [[JSON objectAtIndex:i] objectForKey:@"ingredient_ids"];
                    NSArray *newIngredientIds = [concatenated_ingredient_ids componentsSeparatedByString: @","];
                    [arrNewIngredientCombinationIds addObject:newIngredientIds];
                }
            }
        }
        
        NSArray *arrNewIds = [NSArray arrayWithObjects:self.mixIngredientScrollV.selectedIngredient1.ingredientId, self.mixIngredientScrollV.selectedIngredient2.ingredientId, nil];
        NSArray *arrNewIdsSwitched = [NSArray arrayWithObjects:arrNewIds[1],arrNewIds[0], nil];
        
        BOOL isCombinationAlreadyUsed = NO;
        for(int k = 0; k<[arrNewIngredientCombinationIds count]; k++){
            if(([[[arrNewIngredientCombinationIds objectAtIndex:k] objectAtIndex:0] isEqualToString:[arrNewIds objectAtIndex:0]] && [[[arrNewIngredientCombinationIds objectAtIndex:k] objectAtIndex:1] isEqualToString:[arrNewIds objectAtIndex:1]]) || ([[[arrNewIngredientCombinationIds objectAtIndex:k] objectAtIndex:0] isEqualToString:[arrNewIdsSwitched objectAtIndex:0]] && [[[arrNewIngredientCombinationIds objectAtIndex:k] objectAtIndex:1] isEqualToString:[arrNewIdsSwitched objectAtIndex:1]])){
                isCombinationAlreadyUsed = YES;
            }
        }
        
        if(isCombinationAlreadyUsed){
            self.allowShakeDetection = NO;
            [self.mixIngredientScrollV disableMixboard];
            [self.mixIngredientScrollV setError:@"This ingredient mix already exists, please Select another ingredient" andChangeTextColor:YES];
        }else{
            self.allowShakeDetection = YES;
            [self.mixIngredientScrollV enableMixboard];
            [self.mixIngredientScrollV setError:@"shake the device to mix the ingredients" andChangeTextColor:NO];
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"[MixIngredientViewController] Error getting new ingredients");
    }];
    [operation start];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(event.type == UIEventSubtypeMotionShake && self.allowShakeDetection)
    {
        if(!self.isRotating){
            CABasicAnimation *rotation;
            rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            rotation.fromValue = [NSNumber numberWithFloat:self.currentRotation];
            rotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
            rotation.duration = 4; // Speed
            rotation.repeatCount = HUGE_VALF; // Repeat forever. Can be a finite number.
            [self.mixIngredientScrollV.blade.layer addAnimation:rotation forKey:@"Spin"];
            [self.mixIngredientScrollV.mixBoard.layer addAnimation:rotation forKey:@"Spin"];
            self.isRotating = YES;
            self.allowEndAnimation = YES;
        
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateCurrentRotation:) userInfo:nil repeats:YES];
            self.timer2 = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(updateCurrentProgress:) userInfo:nil repeats:YES];
        }
    }
}

-(void)updateCurrentRotation:(id)sender{
    if(self.currentRotation < 360){
        self.currentRotation += 0.9;
    }else{
        self.currentRotation = 0;
    }
}

-(void)updateCurrentProgress:(id)sender{
    self.progress++;
    self.mixIngredientScrollV.mixBoardOverlay.alpha += 0.009;
    [self.mixIngredientScrollV.progressBarV setMarkerValue:self.progress];
    if(self.progress == 100){
        self.allowShakeDetection = NO;
        [self.timer invalidate];
        self.timer = nil;
        [self.timer2 invalidate];
        self.timer2 = nil;
        self.allowEndAnimation = NO;
        [self.mixIngredientScrollV.blade.layer removeAnimationForKey:@"Spin"];
        
        float degrees = 360;
        float radians = degrees * M_PI / 180;
        [UIView animateWithDuration:1.7 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.mixIngredientScrollV.blade.transform = CGAffineTransformMakeRotation(-radians);
            self.mixIngredientScrollV.mixBoard.transform = CGAffineTransformMakeRotation(-radians);
        } completion:^(BOOL finished){
            if(finished){
                self.currentRotation = 0;
                self.isRotating = NO;
                self.allowEndAnimation = YES;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOW_SAVE_MIXED_INGREDIENT" object:nil];
            }
        }];
    }
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake && self.isRotating && self.allowEndAnimation && self.allowShakeDetection)
    {
        [self.timer invalidate];
        self.timer = nil;
        [self.timer2 invalidate];
        self.timer2 = nil;
        self.allowEndAnimation = NO;
        [self.mixIngredientScrollV.blade.layer removeAnimationForKey:@"Spin"];
        [self.mixIngredientScrollV.mixBoard.layer removeAnimationForKey:@"Spin"];
        
        float degrees = 360 /*- self.currentRotation*/;
        float radians = degrees * M_PI / 180;
        [UIView animateWithDuration:1.7 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.mixIngredientScrollV.blade.transform = CGAffineTransformMakeRotation(-radians);
            self.mixIngredientScrollV.mixBoard.transform = CGAffineTransformMakeRotation(-radians);
        } completion:^(BOOL finished){
            if(finished){
                self.currentRotation = 0;
                self.isRotating = NO;
                self.allowEndAnimation = YES;
            }
        }];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"DISABLE_SHAKING" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ENABLE_SHAKING" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CHECK_INGREDIENTS" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"INGREDIENTS_CHANGED" object:nil];
}

@end

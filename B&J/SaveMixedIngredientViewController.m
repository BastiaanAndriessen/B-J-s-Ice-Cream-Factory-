//
//  SaveMixedIngredientViewController.m
//  B&J
//
//  Created by Bastiaan Andriessen on 27/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "SaveMixedIngredientViewController.h"
#import "Ingredient.h"
#import "Constants.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

@interface SaveMixedIngredientViewController ()

@end

@implementation SaveMixedIngredientViewController

@synthesize saveMixedIngredientScrollV = _saveMixedIngredientScrollV;
@synthesize ingredientDataObject1 = _ingredientDataObject1;
@synthesize ingredientDataObject2 = _ingredientDataObject2;
@synthesize colorCode = _colorCode;
@synthesize ingredientIds = _ingredientIds;
@synthesize ingredientName= _ingredientName;
@synthesize ingredientId = _ingredientId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil ingredientDataObject1:(Ingredient*)ingredientDataObject1 ingredientDataObject2:(Ingredient*)ingredientDataObject2 colorCode:(NSString*)colorCode
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.ingredientDataObject1 = ingredientDataObject1;
        self.ingredientDataObject2 = ingredientDataObject2;
        self.colorCode = [colorCode lowercaseString];
    }
    return self;
}

-(void)loadView{
    UIView *mainView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setView:mainView];
    mainView.backgroundColor = [UIColor clearColor];
    
    self.saveMixedIngredientScrollV = [[SaveMixedIngredientScrollView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.saveMixedIngredientScrollV setClipsToBounds:YES];
    [self.saveMixedIngredientScrollV setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [self.saveMixedIngredientScrollV setUserInteractionEnabled:YES];
    [mainView addSubview:self.saveMixedIngredientScrollV];
    
    mainView.userInteractionEnabled = YES;
    self.saveMixedIngredientScrollV.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, self.saveMixedIngredientScrollV.background.frame.size.height);
    self.saveMixedIngredientScrollV.scrollEnabled = YES;
    self.saveMixedIngredientScrollV.showsVerticalScrollIndicator = NO;
    self.saveMixedIngredientScrollV.delaysContentTouches = YES;
    self.saveMixedIngredientScrollV.canCancelContentTouches = NO;
    self.saveMixedIngredientScrollV.delegate = self.saveMixedIngredientScrollV;
    
    [self.saveMixedIngredientScrollV setupIngredientView:self.ingredientDataObject1];
    [self.saveMixedIngredientScrollV setupIngredientView:self.ingredientDataObject2];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveNewMix:) name:@"SAVE_NEW_MIX" object:nil];
}

- (void)saveNewMix:(id)sender{
    self.ingredientIds = [NSString stringWithFormat:@"%@,%@", self.ingredientDataObject1.ingredientId, self.ingredientDataObject2.ingredientId];
    self.ingredientName = [[self.saveMixedIngredientScrollV.txtIngredientName.text lowercaseString] capitalizedString];
    if([self.ingredientName length] >= 5){
        NSURL *url = [NSURL URLWithString:ApiUrl];
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
        
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.ingredientIds, @"ingredient_ids",
                                self.ingredientName, @"name",
                                [self.colorCode lowercaseString], @"color_code",
                                nil];
        [httpClient postPath:@"newingredient" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSMutableString *strippedString = [NSMutableString stringWithCapacity:10];
            for (int i=0; i<[responseStr length]; i++) {
                if (isdigit([responseStr characterAtIndex:i])) {
                    [strippedString appendFormat:@"%c",[responseStr characterAtIndex:i]];
                }
            }
            self.ingredientId = strippedString;
            NSString *newAllowedIngredientIds;
            if([[NSUserDefaults standardUserDefaults] objectForKey:@"allowed_new_ingredients_ids"]){
                newAllowedIngredientIds = [NSString stringWithFormat:@"%@,%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"allowed_new_ingredients_ids"],strippedString];
            }else{
                newAllowedIngredientIds = strippedString;
            }
            [[NSUserDefaults standardUserDefaults] setObject:newAllowedIngredientIds  forKey:@"allowed_new_ingredients_ids"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"BACK_TO_MIXER_FROM_SAVE_SET_NEW_MIX" object:nil];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
        }];
    }else{
        self.saveMixedIngredientScrollV.lblFeedback.text = [@"Oops! Your new mix should be minimum 5 characters." uppercaseString];
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.saveMixedIngredientScrollV.lblFeedback.alpha = 1;
        } completion:NULL];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SAVE_NEW_MIX" object:nil];
}

@end

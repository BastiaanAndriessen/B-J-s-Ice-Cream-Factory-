//
//  AddIngredientViewController.m
//  B&J
//
//  Created by Bastiaan Andriessen on 22/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "AddIngredientViewController.h"
#import "Constants.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFJSONRequestOperation.h"

@interface AddIngredientViewController ()

@end

@implementation AddIngredientViewController

@synthesize addIngredientV = _addIngredientV;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.addIngredientV = [[AddIngredientView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        [self setView:self.addIngredientV];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadIngredients:) name:@"LOAD_INGREDIENTS" object:nil];
        [self loadIngredients:nil];
    }
    return self;
}

-(void)loadIngredients:(id)sender{
    if([self.addIngredientV.currentSelectedIngredientKind isEqualToString:@"icecream"]){
        //load ice cream ingredients and new ingredients
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@ingredients/icecream",ApiUrl]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            //make an array out of the JSON
            NSMutableArray *arrIngredients = [NSMutableArray array];
            NSMutableArray *arrCompleteIngredients = [NSMutableArray array];
            for(int i = 0; i<[JSON count]; i++){
                [arrIngredients addObject:[JSON objectAtIndex:i]];
                [arrCompleteIngredients addObject:[JSON objectAtIndex:i]];
            }
            if([[NSUserDefaults standardUserDefaults] objectForKey:@"normal_ingredients"]){
                [[NSUserDefaults standardUserDefaults] setObject:arrIngredients  forKey:@"normal_ingredients"];
            }
            
            //check if user made any new ingredients 
            if([[NSUserDefaults standardUserDefaults] objectForKey:@"allowed_new_ingredients_ids"]){
                NSString *concatenated_ingredient_ids = [[NSUserDefaults standardUserDefaults] objectForKey:@"allowed_new_ingredients_ids"];
                NSArray *newIngredientIds = [concatenated_ingredient_ids componentsSeparatedByString: @","];
                
                //get all new ingredients
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@newingredients",ApiUrl]];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                    
                    for(int i = 0; i<[JSON count]; i++){
                        for(int j = 0; j<[newIngredientIds count]; j++){
                            if([[[JSON objectAtIndex:i] objectForKey:@"id"] isEqualToString:[newIngredientIds objectAtIndex:j]]){
                                NSMutableArray *arrCompleteIngredient = [NSMutableArray arrayWithObject:[JSON objectAtIndex:i]];
                                
                                NSString *concatenated_ingredient_ingredient_ids = [[JSON objectAtIndex:i] objectForKey:@"ingredient_ids"];
                                NSArray *newIngredientIngredientIds = [concatenated_ingredient_ingredient_ids componentsSeparatedByString: @","];
                                
                                NSMutableArray *arrIngredientIngredients = [NSMutableArray array];
                                for(int k = 0; k<[newIngredientIngredientIds count];k++){
                                    for(int l=0; l<[arrIngredients count]; l++){
                                        if([[newIngredientIngredientIds objectAtIndex:k] isEqualToString:[[arrIngredients objectAtIndex:l] objectForKey:@"id"]]){
                                            [arrIngredientIngredients addObject:[arrIngredients objectAtIndex:l]];
                                        }
                                    }
                                }
                                
                                [arrCompleteIngredient addObject:arrIngredientIngredients];
                                [arrCompleteIngredients addObject:arrCompleteIngredient];
                            }
                        }
                    }
                    [self.addIngredientV.addIngredientScrollV loadIngredients:arrCompleteIngredients];
                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                    NSLog(@"[AddIngredientVC] Error getting ingredients");
                }];
                [operation start];
            } else {
                [self.addIngredientV.addIngredientScrollV loadIngredients:arrIngredients];
            }
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"[AddIngredientVC] Error getting ingredients");
        }];
        [operation start];
    }else{
        //load ingredients in chunks
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@ingredients/chunks",ApiUrl]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            //make an array out of the JSON
            NSMutableArray *arrIngredients = [NSMutableArray array];
            for(int i = 0; i<[JSON count]; i++){
                [arrIngredients addObject:[JSON objectAtIndex:i]];
            }
            
            [self.addIngredientV.addIngredientScrollV loadIngredients:arrIngredients];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"[AddIngredientVC] Error getting ingredients");
        }];
        [operation start];
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

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LOAD_INGREDIENTS" object:nil];
}

@end

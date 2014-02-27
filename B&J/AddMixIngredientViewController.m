//
//  AddMixIngredientViewController.m
//  B&J
//
//  Created by Bastiaan Andriessen on 25/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "AddMixIngredientViewController.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFJSONRequestOperation.h"
#import "Constants.h"

@interface AddMixIngredientViewController ()

@end

@implementation AddMixIngredientViewController

@synthesize addMixIngredientV = _addMixIngredientV;
@synthesize ingredientNameNotToShow = _ingredientNameNotToShow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil ingredientNameNotToShow:(NSString*)ingredientNameNotToShow
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.ingredientNameNotToShow = ingredientNameNotToShow;
        self.addMixIngredientV = [[AddMixIngredientView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        [self setView:self.addMixIngredientV];
        [self loadIngredients];
    }
    return self;
}

-(void)loadIngredients{
        //load ice cream ingredients
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@ingredients/icecream",ApiUrl]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            //make an array out of the JSON
            NSMutableArray *arrIngredients = [NSMutableArray array];
            for(int i = 0; i<[JSON count]; i++){
                if(![self.ingredientNameNotToShow isEqualToString:[[JSON objectAtIndex:i] objectForKey:@"name"]]){
                    [arrIngredients addObject:[JSON objectAtIndex:i]];
                }
            }
            if([[NSUserDefaults standardUserDefaults] objectForKey:@"normal_ingredients"]){
                [[NSUserDefaults standardUserDefaults] setObject:arrIngredients  forKey:@"normal_ingredients"];
            }
            [self.addMixIngredientV.addMixIngredientScrollV loadIngredients:arrIngredients];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"[AddIngredientVC] Error getting ingredients");
        }];
        [operation start];
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

@end

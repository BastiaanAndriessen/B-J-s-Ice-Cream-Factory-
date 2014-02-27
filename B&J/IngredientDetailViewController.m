//
//  IngredientDetailViewController.m
//  B&J
//
//  Created by Bastiaan Andriessen on 30/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "IngredientDetailViewController.h"
#import "Constants.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFJSONRequestOperation.h"

@interface IngredientDetailViewController ()

@end

@implementation IngredientDetailViewController

@synthesize ingredientDetailV = _ingredientDetailV;
@synthesize iceCreamName = _iceCreamName;
@synthesize ingredientIds = _ingredientIds;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil iceCreamName:(NSString*)iceCreamName ingredientIds:(NSString*)ingredientIds
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.iceCreamName = iceCreamName;
        self.ingredientIds = ingredientIds;
    }
    return self;
}

-(void)loadView{
    self.ingredientDetailV = [[IngredientDetailView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) iceCreamName:self.iceCreamName];
    [self.ingredientDetailV loadIngredients];
    [self setView:self.ingredientDetailV];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@ingredients",ApiUrl]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSArray *ingredients = JSON;
        
        NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"%@newingredients",ApiUrl]];
        NSURLRequest *request2 = [NSURLRequest requestWithURL:url2];
        AFJSONRequestOperation *operation2 = [AFJSONRequestOperation JSONRequestOperationWithRequest:request2 success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON2) {
            NSArray *newingredients = JSON2;
            [self.ingredientDetailV.ingredientDetailScrollV loadIngredientsWithIds:self.ingredientIds ingredients:ingredients newIngredients:newingredients];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON2) {
            NSLog(@"[IngredientDetailViewController] Error getting new ingredients");
        }];
        [operation2 start];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"[IngredientDetailViewController] Error getting ingredients");
    }];
    [operation start];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

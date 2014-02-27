//
//  RateTastesViewController.m
//  B&J
//
//  Created by Bastiaan Andriessen on 28/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "RateTastesViewController.h"
#import "Constants.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFJSONRequestOperation.h"
#import "IceCreamTasteView.h"

@interface RateTastesViewController ()

@end

@implementation RateTastesViewController

@synthesize rateTastesV = _rateTastesV;
@synthesize iceCreamName = _iceCreamName;
@synthesize ingredientIds = _ingredientIds;
@synthesize votingKind = _votingKind;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(votedPeace:) name:@"VOTED_PEACE" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(votedLove:) name:@"VOTED_LOVE" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(prepareDataShowIngredients:) name:@"PREPARE_DATA_SHOW_INGREDIENTS" object:nil];
    }
    return self;
}

-(void)prepareDataShowIngredients:(id)sender{
    [self prepareDataFor:@"ingredients"];
}

-(void)prepareDataFor:(NSString*)goal{
    NSArray *arrIceCreamTasteViews = self.rateTastesV.rateTastesScrollV.arrIceCreamTasteViews;
    for(int i = 0; i<[arrIceCreamTasteViews count]; i++){
        IceCreamTasteView *currentIceCreamTaste = [arrIceCreamTasteViews objectAtIndex:i];
        if([goal isEqualToString:@"ingredients"]){
            if(currentIceCreamTaste.showIngredients){
                self.iceCreamName = currentIceCreamTaste.lblTitle.text;
                self.ingredientIds = currentIceCreamTaste.ingredientIds;
            }
        }else{
            if(currentIceCreamTaste.votedLove || currentIceCreamTaste.votedPeace){
                self.iceCreamName = currentIceCreamTaste.lblTitle.text;
            }
        }
    }
    
    if([goal isEqualToString:@"ingredients"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOW_INGREDIENTS" object:nil];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOW_SHARE" object:nil];
    }
}

-(void)readdObservers{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CHANGE_FILTER" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"VOTED_PEACE" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"VOTED_LOVE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFilter:) name:@"CHANGE_FILTER" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(votedPeace:) name:@"VOTED_PEACE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(votedLove:) name:@"VOTED_LOVE" object:nil];
}

-(void)votedPeace:(id)sender{
    self.votingKind = @"peace";
    [self prepareDataFor:@"peace"];
    NSString *peaceIds = @"";
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"votes"]){
        peaceIds = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"votes"] objectAtIndex:0] objectForKey:@"peace_ids"];
    }
    NSArray *arrIceCreamTasteViews = self.rateTastesV.rateTastesScrollV.arrIceCreamTasteViews;
    NSString *peaceIdToAdd = @"";
    NSString *numPeace;
    NSString *numLove;
    for(int i = 0; i<[arrIceCreamTasteViews count]; i++){
        IceCreamTasteView *currentIceCreamTasteV = [arrIceCreamTasteViews objectAtIndex:i];
        if(currentIceCreamTasteV.votedPeace){
            peaceIdToAdd = currentIceCreamTasteV.iceCreamId;
            numPeace = [NSString stringWithFormat:@"%d",currentIceCreamTasteV.numPeace];
            numLove = [NSString stringWithFormat:@"%d",currentIceCreamTasteV.numLove];
        }
    }
    
    NSURL *url = [NSURL URLWithString:ApiUrl];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSDictionary *params;
    if([peaceIds length] > 0){
        peaceIds = [NSString stringWithFormat:@"%@,%@",peaceIds,peaceIdToAdd];
        
        params = [NSDictionary dictionaryWithObjectsAndKeys:
                  peaceIds, @"peace_ids",
                  [[NSUserDefaults standardUserDefaults] objectForKey:@"email"], @"email",
                  nil];
        [httpClient postPath:@"vote/peace/update" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
            [self updateUserVotesWithId:peaceIdToAdd numPeace:numPeace numLove:numLove];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
        }];
    }else{
        peaceIds = peaceIdToAdd;
        
        params = [NSDictionary dictionaryWithObjectsAndKeys:
                  [[NSUserDefaults standardUserDefaults] objectForKey:@"email"], @"email",
                  peaceIds, @"peace_ids",
                  @"0", @"love_id",
                  nil];
        [httpClient postPath:@"vote" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
            [self updateUserVotesWithId:peaceIdToAdd numPeace:numPeace numLove:numLove];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
        }];
    }
}

-(void)votedLove:(id)sender{
    self.votingKind = @"love";
    [self prepareDataFor:@"love"];
    NSArray *arrIceCreamTasteViews = self.rateTastesV.rateTastesScrollV.arrIceCreamTasteViews;
    NSString *loveIdToAdd = @"";
    NSString *numPeace;
    NSString *numLove;
    for(int i = 0; i<[arrIceCreamTasteViews count]; i++){
        IceCreamTasteView *currentIceCreamTasteV = [arrIceCreamTasteViews objectAtIndex:i];
        if(currentIceCreamTasteV.votedLove){
            loveIdToAdd = currentIceCreamTasteV.iceCreamId;
            numPeace = [NSString stringWithFormat:@"%d",currentIceCreamTasteV.numPeace];
            numLove = [NSString stringWithFormat:@"%d",currentIceCreamTasteV.numLove];
        }
    }
    
    NSString *peaceIds = @"";
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"votes"]){
        peaceIds = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"votes"] objectAtIndex:0] objectForKey:@"peace_ids"];
    }
    
    NSURL *url = [NSURL URLWithString:ApiUrl];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSDictionary *params;
    if([peaceIds length] > 0){
        params = [NSDictionary dictionaryWithObjectsAndKeys:
                  loveIdToAdd, @"love_id",
                  [[NSUserDefaults standardUserDefaults] objectForKey:@"email"], @"email",
                  nil];
        [httpClient postPath:@"vote/love/update" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
            [self updateUserVotesWithId:loveIdToAdd numPeace:numPeace numLove:numLove];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
        }];
    }else{
        params = [NSDictionary dictionaryWithObjectsAndKeys:
                  [[NSUserDefaults standardUserDefaults] objectForKey:@"email"], @"email",
                  @"0", @"peace_ids",
                  loveIdToAdd, @"love_id",
                  nil];
        [httpClient postPath:@"vote" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
            [self updateUserVotesWithId:loveIdToAdd numPeace:numPeace numLove:numLove];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
        }];
    }
}

-(void)updateUserVotesWithId:(NSString*)iceCreamId numPeace:(NSString*)numPeace numLove:(NSString*)numLove{
    NSURL *url = [NSURL URLWithString:ApiUrl];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            numPeace, @"peace",
                            numLove, @"love",
                            iceCreamId, @"id",
                            nil];
    [httpClient postPath:@"icecreamtastes/update" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        [self.rateTastesV.rateTastesScrollV updateVoteButtons];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
    }];
}

-(void)loadIceCreamTastesOrderByFilter:(NSString*)filter{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@icecreamtastes/%@",ApiUrl,filter]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if([JSON count] > 0){
            [self.rateTastesV.rateTastesScrollV loadIceCreamTastes:JSON filtererdBy:filter];
            [self.rateTastesV.rateTastesScrollV updateVoteButtons];
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"[RateTastesViewController] Error getting ice cream tastes");
    }];
    [operation start];
}

- (void)loadView
{
    self.rateTastesV = [[RateTastesView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [self setView:self.rateTastesV];
    [self loadIceCreamTastesOrderByFilter:@"peace"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFilter:) name:@"CHANGE_FILTER" object:nil];
}

-(void)changeFilter:(id)sender{
    [self loadIceCreamTastesOrderByFilter:self.rateTastesV.currentSelectedRate];
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CHANGE_FILTER" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"VOTED_PEACE" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"VOTED_LOVE" object:nil];
}

@end

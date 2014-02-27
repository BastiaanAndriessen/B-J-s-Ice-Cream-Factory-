//
//  HomeViewController.m
//  B&J
//
//  Created by Bastiaan Andriessen on 21/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize hasInternetFailedYet = _hasInternetFailedYet;
@synthesize alert = _alert;
@synthesize homeScrollV = _homeScrollV;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hasInternetFailedYet = NO;
        self.alert = [[UIAlertView alloc] initWithTitle:@"Internet Connection Not Available" message:@"This is an online database connected app, you'll need to connect to a valid internet connection." delegate:nil cancelButtonTitle:@"I understand" otherButtonTitles:nil];
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)loadView
{
    [self testInternetConnection];
    
    UIView *mainView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setView:mainView];
    mainView.backgroundColor = [UIColor clearColor];
    
    self.homeScrollV = [[HomeScrollView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.homeScrollV setClipsToBounds:YES];
    [self.homeScrollV setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [self.homeScrollV setUserInteractionEnabled:YES];
    [mainView addSubview:self.homeScrollV];
    
    mainView.userInteractionEnabled = YES;
    self.homeScrollV.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, self.homeScrollV.background.frame.size.height);
    self.homeScrollV.scrollEnabled = YES;
    self.homeScrollV.showsVerticalScrollIndicator = NO;
    self.homeScrollV.delaysContentTouches = YES;
    self.homeScrollV.canCancelContentTouches = NO;
    self.homeScrollV.delegate = self.homeScrollV;
}

- (void)testInternetConnection
{
    internetReachableFoo = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Internet is reachable
    __weak typeof(self) weakSelf = self;
    internetReachableFoo.reachableBlock = ^(Reachability*reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.alert removeFromSuperview];
            [weakSelf.alert dismissWithClickedButtonIndex:0 animated:YES];
            [weakSelf.homeScrollV.btnMixer setEnabled:YES];
            [weakSelf.homeScrollV.btnRate setEnabled:YES];
            if(weakSelf.hasInternetFailedYet){
                [weakSelf.homeScrollV hideInternetArrow];
            }
        });
    };
    
    // Internet is not reachable
    internetReachableFoo.unreachableBlock = ^(Reachability*reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.alert show];
            [weakSelf.homeScrollV.btnMixer setEnabled:NO];
            [weakSelf.homeScrollV.btnRate setEnabled:NO];
            [weakSelf.homeScrollV showInternetArrow];
            weakSelf.hasInternetFailedYet = YES;
        });
    };
    
    [internetReachableFoo startNotifier];
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

//
//  SocialShareViewController.m
//  B&J
//
//  Created by Bastiaan Andriessen on 30/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "SocialShareViewController.h"

@interface SocialShareViewController ()

@end

@implementation SocialShareViewController

@synthesize socialShareScrollV = _socialShareScrollV;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    UIView *mainView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setView:mainView];
    mainView.backgroundColor = [UIColor clearColor];
    
    self.socialShareScrollV = [[SocialShareScrollView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.socialShareScrollV setClipsToBounds:YES];
    [self.socialShareScrollV setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [self.socialShareScrollV setUserInteractionEnabled:YES];
    [mainView addSubview:self.socialShareScrollV];
    
    mainView.userInteractionEnabled = YES;
    self.socialShareScrollV.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, self.socialShareScrollV.btnShare.frame.size.height);
    self.socialShareScrollV.scrollEnabled = YES;
    self.socialShareScrollV.showsVerticalScrollIndicator = NO;
    self.socialShareScrollV.delaysContentTouches = YES;
    self.socialShareScrollV.canCancelContentTouches = NO;
    self.socialShareScrollV.delegate = self.socialShareScrollV;
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

//
//  EmailOverlayViewController.m
//  B&J
//
//  Created by Bastiaan Andriessen on 28/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "EmailOverlayViewController.h"

@interface EmailOverlayViewController ()

@end

@implementation EmailOverlayViewController

@synthesize emailOverlayScrollV = _emailOverlayScrollV;

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
    
    self.emailOverlayScrollV = [[EmailOverlayScrollView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.emailOverlayScrollV setClipsToBounds:YES];
    [self.emailOverlayScrollV setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [self.emailOverlayScrollV setUserInteractionEnabled:YES];
    [mainView addSubview:self.emailOverlayScrollV];
    
    mainView.userInteractionEnabled = YES;
    self.emailOverlayScrollV.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, self.emailOverlayScrollV.btnStartRating.frame.size.height);
    self.emailOverlayScrollV.scrollEnabled = YES;
    self.emailOverlayScrollV.showsVerticalScrollIndicator = NO;
    self.emailOverlayScrollV.delaysContentTouches = YES;
    self.emailOverlayScrollV.canCancelContentTouches = NO;
    self.emailOverlayScrollV.delegate = self.emailOverlayScrollV;
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

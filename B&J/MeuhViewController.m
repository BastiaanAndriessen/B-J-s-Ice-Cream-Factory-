//
//  MeuhViewController.m
//  B&J
//
//  Created by Bastiaan Andriessen on 22/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "MeuhViewController.h"

@interface MeuhViewController ()

@end

@implementation MeuhViewController

@synthesize meuhScrollV = _meuhScrollV;

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
    
    self.meuhScrollV = [[MeuhScrollView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.meuhScrollV setClipsToBounds:YES];
    [self.meuhScrollV setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [self.meuhScrollV setUserInteractionEnabled:YES];
    [mainView addSubview:self.meuhScrollV];
    
    mainView.userInteractionEnabled = YES;
    self.meuhScrollV.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, self.meuhScrollV.lblVInfoBlock2.frame.origin.y + self.meuhScrollV.lblVInfoBlock2.frame.size.height);
    self.meuhScrollV.scrollEnabled = YES;
    self.meuhScrollV.showsVerticalScrollIndicator = NO;
    self.meuhScrollV.delaysContentTouches = YES;
    self.meuhScrollV.canCancelContentTouches = NO;
    self.meuhScrollV.delegate = self.meuhScrollV;
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

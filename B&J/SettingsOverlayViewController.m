//
//  SettingsOverlayViewController.m
//  B&J
//
//  Created by Bastiaan Andriessen on 29/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "SettingsOverlayViewController.h"

@interface SettingsOverlayViewController ()

@end

@implementation SettingsOverlayViewController

@synthesize settingsOverlayScrollV = _settingsOverlayScrollV;

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
    
    self.settingsOverlayScrollV = [[SettingsOverlayScrollView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.settingsOverlayScrollV setClipsToBounds:YES];
    [self.settingsOverlayScrollV setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [self.settingsOverlayScrollV setUserInteractionEnabled:YES];
    [mainView addSubview:self.settingsOverlayScrollV];
    
    mainView.userInteractionEnabled = YES;
    self.settingsOverlayScrollV.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, self.settingsOverlayScrollV.btnSaveSettings.frame.size.height);
    self.settingsOverlayScrollV.scrollEnabled = YES;
    self.settingsOverlayScrollV.showsVerticalScrollIndicator = NO;
    self.settingsOverlayScrollV.delaysContentTouches = YES;
    self.settingsOverlayScrollV.canCancelContentTouches = NO;
    self.settingsOverlayScrollV.delegate = self.settingsOverlayScrollV;
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

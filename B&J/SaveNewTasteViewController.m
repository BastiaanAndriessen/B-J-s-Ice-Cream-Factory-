//
//  SaveNewTasteViewController.m
//  B&J
//
//  Created by Bastiaan Andriessen on 27/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "SaveNewTasteViewController.h"

@interface SaveNewTasteViewController ()

@end

@implementation SaveNewTasteViewController

@synthesize saveNewTasteScrollV = _saveNewTasteScrollV;
@synthesize arrAddedIngredientDataObjects = _arrAddedIngredientDataObjects;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil arrAddedIngredientDataObjects:(NSArray*)arrAddedIngredientDataObjects
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.arrAddedIngredientDataObjects = arrAddedIngredientDataObjects;
    }
    return self;
}

-(void)loadView{
    UIView *mainView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setView:mainView];
    mainView.backgroundColor = [UIColor clearColor];
    
    self.saveNewTasteScrollV = [[SaveNewTasteScrollView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) arrAddedIngredientDataObjects:self.arrAddedIngredientDataObjects];
    [self.saveNewTasteScrollV setClipsToBounds:YES];
    [self.saveNewTasteScrollV setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [self.saveNewTasteScrollV setUserInteractionEnabled:YES];
    [mainView addSubview:self.saveNewTasteScrollV];
    
    mainView.userInteractionEnabled = YES;
    self.saveNewTasteScrollV.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, self.saveNewTasteScrollV.background.frame.size.height);
    self.saveNewTasteScrollV.scrollEnabled = YES;
    self.saveNewTasteScrollV.showsVerticalScrollIndicator = NO;
    self.saveNewTasteScrollV.delaysContentTouches = YES;
    self.saveNewTasteScrollV.canCancelContentTouches = NO;
    self.saveNewTasteScrollV.delegate = self.saveNewTasteScrollV;
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

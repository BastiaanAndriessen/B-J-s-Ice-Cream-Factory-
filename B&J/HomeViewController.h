//
//  HomeViewController.h
//  B&J
//
//  Created by Bastiaan Andriessen on 21/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeScrollView.h"
#import "Reachability.h"

@interface HomeViewController : UIViewController
{
    Reachability *internetReachableFoo;
}
@property(nonatomic) BOOL hasInternetFailedYet;
@property(strong, nonatomic) UIAlertView *alert;
@property(strong, nonatomic) HomeScrollView *homeScrollV;

@end

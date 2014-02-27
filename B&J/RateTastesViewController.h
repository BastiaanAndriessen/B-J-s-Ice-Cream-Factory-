//
//  RateTastesViewController.h
//  B&J
//
//  Created by Bastiaan Andriessen on 28/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateTastesView.h"

@interface RateTastesViewController : UIViewController

@property(strong, nonatomic) RateTastesView *rateTastesV;
@property(strong, nonatomic) NSString *iceCreamName;
@property(strong, nonatomic) NSString *ingredientIds;
@property(strong, nonatomic) NSString *votingKind;

-(void)readdObservers;

@end

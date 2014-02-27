//
//  RateTastesView.h
//  B&J
//
//  Created by Bastiaan Andriessen on 28/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateTastesScrollView.h"

@interface RateTastesView : UIView

@property(strong, nonatomic) UIImageView *background;
@property(strong, nonatomic) UIImageView *cloud;
@property(strong, nonatomic) UIImageView *cloud2;
@property(strong, nonatomic) NSTimer *timer;
@property(strong, nonatomic) UIImageView *colorFrame;
@property(strong, nonatomic) UIButton *btnLogo;
@property(strong, nonatomic) UIButton *btnBack;
@property(strong, nonatomic) UIButton *btnSettings;

@property(strong, nonatomic) UIImage *imageRate;
@property(strong, nonatomic) NSString *currentSelectedRate;
@property(strong, nonatomic) UIButton *btnPeace;
@property(strong, nonatomic) UIButton *btnLove;

@property(strong, nonatomic) UIView *mainView;
@property(strong, nonatomic) RateTastesScrollView *rateTastesScrollV;

-(void)resetAnimations;

@end

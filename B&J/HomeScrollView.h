//
//  HomeScrollView.h
//  B&J
//
//  Created by Bastiaan Andriessen on 21/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeScrollView : UIScrollView <UIScrollViewDelegate>

@property(strong, nonatomic) UIImageView *background;
@property(strong, nonatomic) UIImageView *cloud;
@property(strong, nonatomic) UIImageView *cloud2;
@property(strong, nonatomic) UIImageView *backHill;
@property(strong, nonatomic) UIImageView *cow;
@property(strong, nonatomic) UIImageView *frontHill;
@property(strong, nonatomic) UIButton *btnLogo;

@property(nonatomic) float randomIndex;
@property(strong, nonatomic) UIImageView *randomQuote;

@property(strong, nonatomic) UIButton *btnMeuh;
@property(strong, nonatomic) UIImageView *arrowsMeuh;
@property(strong, nonatomic) UIButton *btnMixer;
@property(strong, nonatomic) UIImageView *arrowsMixer;
@property(strong, nonatomic) UIButton *btnRate;
@property(strong, nonatomic) UIImageView *arrowsRate;

@property(strong, nonatomic) NSTimer *timer;
@property(nonatomic) BOOL allowedToShowRandomQuote;

-(void)resetAnimations;
-(void)showInternetArrow;
-(void)hideInternetArrow;

@end

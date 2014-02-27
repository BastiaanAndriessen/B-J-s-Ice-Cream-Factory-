//
//  MeuhScrollView.h
//  B&J
//
//  Created by Bastiaan Andriessen on 22/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeuhScrollView : UIScrollView <UIScrollViewDelegate>

@property(strong, nonatomic) UIImageView *background;
@property(strong, nonatomic) UIImageView *cloud;
@property(strong, nonatomic) UIImageView *cloud2;
@property(strong, nonatomic) UIImageView *colorFrame;
@property(strong, nonatomic) UIButton *btnLogo;
@property(strong, nonatomic) UIButton *btnBack;

@property(strong, nonatomic) UIImageView *imgPeace;
@property(strong, nonatomic) UIImageView *imgLove;
@property(strong, nonatomic) UILabel *lblVInfoBlock2;

@end

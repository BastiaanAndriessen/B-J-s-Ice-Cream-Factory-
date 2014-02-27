//
//  SocialShareScrollView.h
//  B&J
//
//  Created by Bastiaan Andriessen on 30/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialShareScrollView : UIScrollView <UIScrollViewDelegate>

@property(nonatomic) BOOL allowScrollControl;

@property(strong, nonatomic) UIImageView *background;
@property(strong, nonatomic) UIImageView *cloud;
@property(strong, nonatomic) UIImageView *cloud2;
@property(strong, nonatomic) UIImageView *colorFrame;
@property(strong, nonatomic) UIButton *btnLogo;
@property(strong, nonatomic) UIButton *btnBack;
@property(strong, nonatomic) UIImageView *imgFacebook;
@property(strong, nonatomic) UITextView *txtInfo;
@property(strong, nonatomic) UIButton *btnShare;

-(void)fillInVotedIceCreamName:(NSString*)name voteKind:(NSString*)voteKind;

@end

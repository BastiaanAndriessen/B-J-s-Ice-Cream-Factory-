//
//  SettingsOverlayScrollView.h
//  B&J
//
//  Created by Bastiaan Andriessen on 29/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsOverlayScrollView : UIScrollView <UIScrollViewDelegate, UITextFieldDelegate>

@property(nonatomic) BOOL allowScrollControl;

@property(strong, nonatomic) UIImageView *background;
@property(strong, nonatomic) UIImageView *cloud;
@property(strong, nonatomic) UIImageView *cloud2;
@property(strong, nonatomic) UIImageView *colorFrame;
@property(strong, nonatomic) UIButton *btnLogo;
@property(strong, nonatomic) UIButton *btnBack;

@property(strong, nonatomic) UITextView *txtInfo;
@property(strong, nonatomic) UIImageView *imgIcons;

@property(strong, nonatomic) UILabel *lblEmailAddress;
@property(strong, nonatomic) UITextField *txtEmailAddress;
@property(strong, nonatomic) UILabel *lblFeedbackEmailAddress;

@property(strong, nonatomic) UIButton *btnSaveSettings;

@end

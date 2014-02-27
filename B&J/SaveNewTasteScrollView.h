//
//  SaveNewTasteScrollView.h
//  B&J
//
//  Created by Bastiaan Andriessen on 27/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaveNewTasteScrollView : UIScrollView <UIScrollViewDelegate, UITextFieldDelegate>

@property(strong, nonatomic) NSArray *arrAddedIngredientDataObjects;
@property(nonatomic) BOOL allowScrollControl;
@property(nonatomic) CGSize ownContentSize;

@property(strong, nonatomic) NSTimer *timer;

@property(strong, nonatomic) UIImageView *background;
@property(strong, nonatomic) UIImageView *cloud;
@property(strong, nonatomic) UIImageView *cloud2;
@property(strong, nonatomic) UIImageView *colorFrame;
@property(strong, nonatomic) UIButton *btnLogo;
@property(strong, nonatomic) UIButton *btnBack;
@property(strong, nonatomic) UILabel *lblCongrats;
@property(strong, nonatomic) UITextView *txtInfo;

@property(strong, nonatomic) UILabel *lblIceCreamName;
@property(strong, nonatomic) UITextField *txtIceCreamName;
@property(strong, nonatomic) UILabel *lblFeedbackIceCream;

@property(strong, nonatomic) UILabel *lblUserName;
@property(strong, nonatomic) UITextField *txtUserName;
@property(strong, nonatomic) UILabel *lblFeedbackUserName;

@property(strong, nonatomic) UILabel *lblEmailAddress;
@property(strong, nonatomic) UITextField *txtEmailAddress;
@property(strong, nonatomic) UILabel *lblFeedbackEmailAddress;

@property(strong, nonatomic) UIButton *btnSave;

- (id)initWithFrame:(CGRect)frame arrAddedIngredientDataObjects:(NSArray*)arrAddedIngredientDataObjects;

@end

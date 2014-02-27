//
//  IngredientDetailView.h
//  B&J
//
//  Created by Bastiaan Andriessen on 30/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IngredientDetailScrollView.h"

@interface IngredientDetailView : UIView

@property(strong, nonatomic) UIImageView *background;
@property(strong, nonatomic) UIImageView *cloud;
@property(strong, nonatomic) UIImageView *cloud2;
@property(strong, nonatomic) NSTimer *timer;
@property(strong, nonatomic) UIImageView *colorFrame;
@property(strong, nonatomic) UIButton *btnLogo;
@property(strong, nonatomic) UIButton *btnBack;
@property(strong, nonatomic) UILabel *lblInfo;

@property(strong, nonatomic) UIView *mainView;
@property(strong, nonatomic) IngredientDetailScrollView *ingredientDetailScrollV;

-(void)loadIngredients;
- (id)initWithFrame:(CGRect)frame iceCreamName:(NSString*)iceCreamName;

@end

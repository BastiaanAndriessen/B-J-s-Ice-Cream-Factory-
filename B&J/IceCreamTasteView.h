//
//  IceCreamTasteView.h
//  B&J
//
//  Created by Bastiaan Andriessen on 28/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IceCreamTasteView : UIView

@property(strong, nonatomic) NSString *iceCreamId;
@property(strong, nonatomic) NSString *ingredientIds;
@property(nonatomic) BOOL votedPeace;
@property(nonatomic) BOOL votedLove;
@property(nonatomic) BOOL showIngredients;

@property(strong, nonatomic) UILabel *lblTitle;

@property(strong, nonatomic) UIImageView *background;
@property(strong, nonatomic) UIImageView *cup;
@property(strong, nonatomic) UIImageView *peace;
@property(strong, nonatomic) UIImageView *love;

@property(nonatomic) int numPeace;
@property(nonatomic) int numLove;

@property(strong, nonatomic) UIButton *btnPeace;
@property(strong, nonatomic) UIButton *btnLove;
@property(strong, nonatomic) UIButton *btnIngredients;

- (id)initWithFrame:(CGRect)frame andIceCreamDataObject:(NSDictionary*)arrIceCream andFilter:(NSString*)filter;

@end

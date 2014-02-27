//
//  RateTastesScrollView.h
//  B&J
//
//  Created by Bastiaan Andriessen on 28/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RateTastesScrollView : UIScrollView <UIScrollViewDelegate>

@property(strong, nonatomic) UIImageView *loading;
@property(strong, nonatomic) NSMutableArray *arrIceCreamTasteViews;
@property(nonatomic) int totalHeight;

-(void)loadIceCreamTastes:(NSArray*)arrIceCreamTastes filtererdBy:(NSString*)filter;
-(void)updateVoteButtons;

@end

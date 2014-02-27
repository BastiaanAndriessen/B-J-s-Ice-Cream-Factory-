//
//  ProgressBarView.h
//  B&J
//
//  Created by Bastiaan Andriessen on 25/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressBarView : UIView

@property(strong, nonatomic) UIImageView *imgProgressBar;
@property(strong, nonatomic) UIImageView *imgProgressMarker;
@property(strong, nonatomic) UILabel *lblProgress;

-(void)setMarkerValue:(int)value;

@end

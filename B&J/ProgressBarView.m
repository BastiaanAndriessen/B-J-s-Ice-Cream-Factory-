//
//  ProgressBarView.m
//  B&J
//
//  Created by Bastiaan Andriessen on 25/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "ProgressBarView.h"

@implementation ProgressBarView

@synthesize imgProgressBar = _imgProgressBar;
@synthesize imgProgressMarker = _imgProgressMarker;
@synthesize lblProgress = _lblProgress;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //ProgressBar
        NSString *pathBar = [[NSBundle mainBundle] pathForResource:@"progress_bar" ofType:@"png" inDirectory:@"images/views/tastemixer/mixerparts"];
        UIImage *imageBar = [[UIImage alloc] initWithContentsOfFile:pathBar];
        self.imgProgressBar = [[UIImageView alloc] initWithImage:imageBar];
        [self.imgProgressBar setFrame:CGRectMake(11, 23, imageBar.size.width, imageBar.size.height)];
        [self addSubview:self.imgProgressBar];
        
        //ProgressMarker
        NSString *pathMarker = [[NSBundle mainBundle] pathForResource:@"progress_marker" ofType:@"png" inDirectory:@"images/views/tastemixer/mixerparts"];
        UIImage *imageMarker = [[UIImage alloc] initWithContentsOfFile:pathMarker];
        self.imgProgressMarker = [[UIImageView alloc] initWithImage:imageMarker];
        [self.imgProgressMarker setFrame:CGRectMake(11, 16, imageMarker.size.width, imageMarker.size.height)];
        [self addSubview:self.imgProgressMarker];
        
        self.lblProgress = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 16)];
        self.lblProgress.text = [@"0" uppercaseString];
        self.lblProgress.backgroundColor = [UIColor clearColor];
        self.lblProgress.textAlignment = NSTextAlignmentCenter;
        self.lblProgress.textColor = [UIColor colorWithRed:0.73f green:0.05f blue:0.35f alpha:1.00f];
        self.lblProgress.font = [UIFont fontWithName:@"ChunkFive-Roman" size:20];
        [self addSubview:self.lblProgress];
    }
    return self;
}

-(void)setMarkerValue:(int)value{
    float multiplier = (self.imgProgressBar.frame.size.width - self.imgProgressMarker.frame.size.width)/100;
    float newPosition = 11+value*multiplier;
    self.imgProgressMarker.frame = CGRectMake(newPosition, self.imgProgressMarker.frame.origin.y, self.imgProgressMarker.frame.size.width, self.imgProgressMarker.frame.size.height);
    self.lblProgress.frame = CGRectMake(newPosition-11, self.lblProgress.frame.origin.y, self.lblProgress.frame.size.width, self.lblProgress.frame.size.height);
    self.lblProgress.text = [NSString stringWithFormat:@"%d",value];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

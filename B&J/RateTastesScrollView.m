//
//  RateTastesScrollView.m
//  B&J
//
//  Created by Bastiaan Andriessen on 28/08/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "RateTastesScrollView.h"
#import <QuartzCore/QuartzCore.h>
#import "IceCreamTasteView.h"
#import "Constants.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFJSONRequestOperation.h"

@implementation RateTastesScrollView

@synthesize loading = _loading;
@synthesize arrIceCreamTasteViews = _arrIceCreamTasteViews;
@synthesize totalHeight = _totalHeight;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.arrIceCreamTasteViews = [NSMutableArray array];
        self.totalHeight = 15;
        
        NSString *pathLoading = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif" inDirectory:@"images"];
        UIImage *imgLoading = [[UIImage alloc] initWithContentsOfFile:pathLoading];
        self.loading = [[UIImageView alloc] initWithImage:imgLoading];
        self.loading.frame = CGRectMake(self.frame.size.width/2 - imgLoading.size.width/2, self.frame.size.height/2 - imgLoading.size.height/2, imgLoading.size.width, imgLoading.size.height);
        [self addSubview:self.loading];
        
        CABasicAnimation *rotation;
        rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        rotation.fromValue = [NSNumber numberWithFloat:0];
        rotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
        rotation.duration = 2;
        rotation.repeatCount = HUGE_VALF;
        [self.loading.layer addAnimation:rotation forKey:@"Spin"];
    }
    return self;
}

-(void)updateVoteButtons{
    NSString *email = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@votes/email/%@",ApiUrl,email]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        for(int i = 0; i<[self.arrIceCreamTasteViews count]; i++){
            IceCreamTasteView *currentIceCreamTaste = [self.arrIceCreamTasteViews objectAtIndex:i];
            [currentIceCreamTaste.btnPeace setEnabled:YES];
            [currentIceCreamTaste.btnLove setEnabled:YES];
            currentIceCreamTaste.votedPeace = NO;
            currentIceCreamTaste.votedLove = NO;
            currentIceCreamTaste.showIngredients = NO;
        }
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"votes"];
        if([JSON count]>0){
            [[NSUserDefaults standardUserDefaults] setObject:JSON  forKey:@"votes"];
            
            NSString *pathCurrent = [[NSBundle mainBundle] pathForResource:@"votesc" ofType:@"png" inDirectory:@"images/views/ratetastes/buttons"];
            UIImage *imageCurrent = [[UIImage alloc] initWithContentsOfFile:pathCurrent];
            
            //Peace
            NSString *concatenatedPeaceIds = [[JSON objectAtIndex:0] objectForKey:@"peace_ids"];
            NSArray *peaceIds = [concatenatedPeaceIds componentsSeparatedByString: @","];
            
            for(int i = 0; i<[peaceIds count]; i++){
                for(int j = 0; j<[self.arrIceCreamTasteViews count]; j++){
                    IceCreamTasteView *currentIceCreamTaste = [self.arrIceCreamTasteViews objectAtIndex:j];
                    if([[peaceIds objectAtIndex:i] isEqualToString:currentIceCreamTaste.iceCreamId]){
                        [currentIceCreamTaste.btnPeace setEnabled:NO];
                        [currentIceCreamTaste.btnPeace setBackgroundImage:imageCurrent forState:UIControlStateDisabled];
                        [currentIceCreamTaste.btnPeace setTitleColor:[UIColor colorWithRed:0.14f green:0.42f blue:0.58f alpha:1.00f] forState:UIControlStateDisabled];
                    }
                }
            }
            
            //Love
            NSString *loveId = [[JSON objectAtIndex:0] objectForKey:@"love_id"];
            if(![loveId isEqualToString:@"0"]){
                for(int j = 0; j<[self.arrIceCreamTasteViews count]; j++){
                    IceCreamTasteView *currentIceCreamTaste = [self.arrIceCreamTasteViews objectAtIndex:j];
                    [currentIceCreamTaste.btnLove setEnabled:NO];
                    if([loveId isEqualToString:currentIceCreamTaste.iceCreamId]){
                        [currentIceCreamTaste.btnLove setBackgroundImage:imageCurrent forState:UIControlStateDisabled];
                        [currentIceCreamTaste.btnLove setTitleColor:[UIColor colorWithRed:0.14f green:0.42f blue:0.58f alpha:1.00f] forState:UIControlStateDisabled];
                    }
                }
            }else{
                for(int j = 0; j<[self.arrIceCreamTasteViews count]; j++){
                    IceCreamTasteView *currentIceCreamTaste = [self.arrIceCreamTasteViews objectAtIndex:j];
                    [currentIceCreamTaste.btnLove setEnabled:YES];
                }
            }
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"[RateTastesScrollView] Error getting votes");
    }];
    [operation start];
}

-(void)loadIceCreamTastes:(NSArray*)arrIceCreamTastes filtererdBy:(NSString*)filter{
    if([self.arrIceCreamTasteViews count]>0){
        for(int i = 0; i<[self.arrIceCreamTasteViews count]; i++){
            [[self.arrIceCreamTasteViews objectAtIndex:i] removeFromSuperview];
        }
        self.arrIceCreamTasteViews = [NSMutableArray array];
    }
    
    for(int i = 0; i<[arrIceCreamTastes count]; i++){
        IceCreamTasteView *iceCreamTasteV = [[IceCreamTasteView alloc] initWithFrame:CGRectMake(TopButtonLeftOffsetLeft, 5+(192*i), 293, 184) andIceCreamDataObject:[arrIceCreamTastes objectAtIndex:i] andFilter:filter];
        [self addSubview:iceCreamTasteV];
        [self.arrIceCreamTasteViews addObject:iceCreamTasteV];
        self.totalHeight += 192;
    }
    self.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 15+([arrIceCreamTastes count]*192));
    [self.loading removeFromSuperview];
}

//scroll control
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.contentOffset.y < 0){
        self.contentOffset = CGPointMake(0, 0);
    }
    if(self.totalHeight+188 > [[UIScreen mainScreen] bounds].size.height){
        if(self.contentOffset.y > self.totalHeight+188 - [[UIScreen mainScreen] bounds].size.height){
            self.contentOffset = CGPointMake(0, self.totalHeight+188 - [[UIScreen mainScreen] bounds].size.height);
        }
    }
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

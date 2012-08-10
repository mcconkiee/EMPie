//
//  EMPie.m
//  AnimatedPie
//
//  Created by Eric McConkie on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EMPie.h"

@implementation EMPie
@synthesize percentage = _percentage;
@synthesize  sliceLayer = _sliceLayer;


-(void)initilizeView
{
   
    
    
    _sliceLayer = [EMSlice layer];
    _sliceLayer.frame = self.bounds; 
    [_sliceLayer setPercent:0.0];
    [self.layer addSublayer:_sliceLayer];
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        [self initilizeView];
    }
    return self;
}


-(void)animateFrom:(float)from to:(float)to
{
    _percentage = to;
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"percent"];
    [anim setDuration:1.0];
    [anim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [anim setFromValue:[NSNumber numberWithFloat:from]];
    [anim setToValue:[NSNumber numberWithFloat:to]];
    
    [_sliceLayer addAnimation:anim forKey:@"percent"];
    [_sliceLayer setPercent:to];
}

-(void)setPercentage:(float)apercentage
{
    _percentage = apercentage;
    [_sliceLayer setPercent:_percentage];
    [_sliceLayer setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    [_sliceLayer setFrame:self.bounds];
    [super drawRect:rect];
}


@end

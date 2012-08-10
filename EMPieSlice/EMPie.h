//
//  EMPie.h
//  AnimatedPie
//
//  Created by Eric McConkie on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "EMSlice.h"

@interface EMPie : UIView

@property (nonatomic,assign)  EMSlice *sliceLayer;
@property (nonatomic,assign)float percentage;

-(void)animateFrom:(float)from to:(float)to;
@end

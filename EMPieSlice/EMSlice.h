//
//  EMSlice.h
//  AnimatedPie
//
//  Created by Eric McConkie on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum 
{
    EMPieTypeNormal,
    EMPieTypeDonut,
    EMPieTypeWithCenter,
    EMPieTypeClock
}EMPieType;

@interface EMSlice : CALayer

@property (nonatomic,retain) UIColor *pieBackgroundColor;
@property (nonatomic,retain) UIColor *pieColor;

@property (nonatomic,assign)float ringWidth;
@property (nonatomic,assign)float percent;
@property (nonatomic,assign)float radius;

@property (nonatomic,assign)EMPieType pieType;//can be a standard pie, ring, or w/center
@end




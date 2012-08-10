//
//  EMSlice.m
//  AnimatedPie
//
//  Created by Eric McConkie on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EMSlice.h"



@implementation EMSlice
@synthesize radius = _radius;
@synthesize  percent = _percent;
@synthesize pieColor = _pieColor;
@synthesize pieBackgroundColor = _pieBackgroundColor;
@synthesize pieType = _pieType;
@synthesize ringWidth = _ringWidth;

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([key isEqualToString:@"percent"]) {
        return YES;
    }else {
        return [super needsDisplayForKey:key];
    }
}

-(id<CAAction>)actionForKey:(NSString *)event {
    if ([event isEqualToString:@"percent"] ) {
        NSLog(@"!!!HOLD ON....we need to return an animation action here: %@",self);
        return nil;
    }
    
    return [super actionForKey:event];
}

- (id)initWithLayer:(id)layer {
	if ((self = [super initWithLayer:layer])) {
		if ([layer isKindOfClass:[EMSlice class]]) {
			// Copy custom property values between layers
			EMSlice *other = (EMSlice *)layer;
			self.percent = other.percent;
            self.radius = other.radius;
            self.pieBackgroundColor = other.pieBackgroundColor;
            self.pieColor = other.pieColor;
            self.ringWidth = other.ringWidth;
            self.pieType = other.pieType;
		}
	}
	return self;
}
-(void)setRadius:(float)aradius
{
    _radius = aradius;
    [self setNeedsDisplay];
}

-(void)setPercent:(float)apercent
{
    _percent = apercent;
    [self setNeedsDisplay];
}
- (id)init
{
    self = [super init];
    if (self) {
        [self setPieBackgroundColor:[UIColor blackColor]];
        [self setPieColor:[UIColor whiteColor]];
        [self setRingWidth:3.0];
        [self setPieType:EMPieTypeNormal];
    }
    return self;
}
-(void)drawInContext:(CGContextRef)ctx
{

    CGRect rect = self.bounds;
    
    float perc = _percent;
    float circle = M_PI *2;    
    float radians = circle * perc;//n radiands
    
    _radius = rect.size.width/2;
    CGPoint center = CGPointMake(_radius, _radius);
    
    
    CGRect dnutHole = CGRectMake(_ringWidth/2  ,_ringWidth/2, 
                             rect.size.width-_ringWidth, rect.size.height - _ringWidth);

    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetShouldAntialias(ctx, YES);
    /******************************************
     * BACKGROUND*******************************
     ******************************************/
    CGMutablePathRef bg = CGPathCreateMutable();
    CGPathAddEllipseInRect(bg, 0, rect);
    
    //donuts get holes
    if (_pieType == EMPieTypeDonut) {
        CGPathAddEllipseInRect(bg, NULL, dnutHole);
    }
    CGContextAddPath(ctx, bg);
    CGContextSetFillColorWithColor(ctx, _pieBackgroundColor.CGColor);    
    CGContextEOFillPath(ctx);
    CGPathRelease(bg);
    
    /******************************************
     * SLICE        *******************************
     ******************************************/
    //create the path/shape
    CGMutablePathRef path = CGPathCreateMutable();
    CGContextMoveToPoint(ctx, center.x , center.y);
    CGContextAddLineToPoint(ctx, _radius*2, center.y);
    CGContextAddArc(ctx, center.x, center.y, _radius, 0, radians, 0);
    CGContextAddLineToPoint(ctx, center.x, center.y);    
    CGContextClosePath(ctx);
    
    
    switch (_pieType) {
        case EMPieTypeDonut:
        {
            CGContextSetBlendMode(ctx, kCGBlendModeSourceIn);//THIS TOOK ME ALL DAY TO FIGURE OUT!
            CGPathAddEllipseInRect(path, NULL, dnutHole);
        }
            break;
        case EMPieTypeWithCenter:
        {
            CGPathAddEllipseInRect(path, NULL, dnutHole);
        }
        default:
            break;
    }

    
    //add all to the path
    CGContextAddPath(ctx, path);    
    CGContextSetFillColorWithColor(ctx, _pieColor.CGColor);
    if (_pieType == EMPieTypeDonut) {
        CGContextEOFillPath(ctx);
    }else {
        CGContextFillPath(ctx);
    }
    CGPathRelease(path);


}


@end


//float angle = radians * (180/M_PI);//degrees
//    float x1 =  (cos(radians) * radius);
//    float y1 =   (sin(radians) * radius);
//   
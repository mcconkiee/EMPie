//
//  EMViewController.m
//  EMPieSlice
//
//  Created by Eric McConkie on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SandboxViewController.h"
#define kWidth 100.0

@interface SandboxViewController ()

@end

@implementation SandboxViewController
@synthesize textViewDetails = _textViewDetails;
@synthesize sliderForAnimation = _sliderForAnimation;
@synthesize slider = _slider;
@synthesize sliderRingWidth = _sliderRingWidth;

-(void)pulsate:(EMPie*)pie
{
    CABasicAnimation *theAnimation;
    
    theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    theAnimation.duration=1.0;
    theAnimation.repeatCount=0;
    [theAnimation setDelegate:self];
    theAnimation.autoreverses=YES;
    theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
    theAnimation.toValue=[NSNumber numberWithFloat:0.0];
    [pie.sliceLayer addAnimation:theAnimation forKey:@"animateOpacity"];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(flag)
    {
        EMPie *pie = [pies objectAtIndex:_selectedIndex];
        [self pulsate:pie];
    }
        
}
-(void)onTapPie:(UITapGestureRecognizer*)tap
{
    EMPie *pie = (EMPie*)tap.view;
    int idx = [pies indexOfObject:pie];
    _selectedIndex = idx;
    [self pulsate:pie];
    
    [_textViewDetails setText:[NSString stringWithFormat:@"%d in array, at %f% ",
                               idx,
                               pie.percentage]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_sliderRingWidth setMinimumValue:1];
    [_sliderRingWidth setMaximumValue:kWidth/2 -1];
    [_sliderRingWidth setValue:_sliderRingWidth.maximumValue/2
                      animated:YES];//skinny
    
    
    
    //the pie charts
    EMPie *apie = [[EMPie alloc] initWithFrame:CGRectZero];
    [self.view addSubview:apie];    
    EMPie *bpie = [[EMPie alloc] initWithFrame:CGRectZero];
    [self.view addSubview:bpie];
    EMPie *cpie = [[EMPie alloc] initWithFrame:CGRectZero];
    [self.view addSubview:cpie];
    

    
    //collect the pies
    pies = [[NSArray alloc] initWithObjects:
            apie,
            bpie,
            cpie
            , nil];

    //define some vars for adjustments
    //we can start with the small pie, and make bigger ones outside of each
    CGFloat sze = kWidth;
    float x,y,w,h;
    w =h = sze;
    x= self.view.center.x-(sze/2);
    y= kWidth;
    for (int b = [pies  count]-1; b>=0; b--) {
        EMPie *p = [pies objectAtIndex:b];
        CGRect frm = CGRectMake(x,y,w,h);
        [p setFrame:frm];
        
        //increment
        w = h += 50;
        x -=25;
        y -=25;
        
        //add some shadow
        p.layer.shadowOffset= CGSizeMake(-5, 5);
        p.layer.shadowOpacity = 0.75;
        
        //define some things about our pie slices
        [p.sliceLayer setPieType:EMPieTypeDonut];
        [p.sliceLayer setRingWidth:5];
        [p.sliceLayer setPieColor:[UIColor whiteColor]];    
        float r = b/255.0;
        float g = (b+20)/255.0;
        float b = (b+40)/255.0;
        [p.sliceLayer setPieBackgroundColor:[UIColor colorWithRed:r green:g blue:b alpha:1.0]];

        [p setNeedsDisplay];
        
        
        
        //tap
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapPie:)];
        [p addGestureRecognizer:tap];
        [tap release];
    }
    
    [self onTap:nil];//GO!

}
- (IBAction)onTap:(id)sender {
    [_textViewDetails setText:@""];
    float curVal = [_slider value];
    float toVal = [_sliderForAnimation value];
    
    for (EMPie *pie in pies) {

            toVal +=0.1;
        [pie animateFrom:curVal to:toVal];
         
    }

    
    
    
}
- (IBAction)onWidthChange:(UISlider*)sender {
    float w = [sender value];
    for (EMPie *pie in pies) {
        [[pie sliceLayer] setRingWidth:w];
    }
    [self onTap:nil];
}
- (IBAction)onSliderChange:(id)sender {
    float val = self.slider.value;
    for (EMPie *pie in pies) {
        [pie setPercentage:val];
    }
}
- (IBAction)onCenter:(id)sender {
    for (EMPie *pie in pies) {
        [pie.sliceLayer setPieType:EMPieTypeWithCenter];
    }
    [self onTap:nil];
}
- (IBAction)onDonut:(id)sender {
    for (EMPie *pie in pies) {
        [pie.sliceLayer setPieType:EMPieTypeDonut];
    }
    [self onTap:nil];
}
- (IBAction)onNorm:(id)sender {
    for (EMPie *pie in pies) {
        [pie.sliceLayer setPieType:EMPieTypeNormal];
    }
    [self onTap:nil];
}

- (void)viewDidUnload
{
    [self setSlider:nil];
    [self setSliderForAnimation:nil];
    [self setSliderRingWidth:nil];
    [self setTextViewDetails:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [_slider release];
    [_sliderForAnimation release];
    [_sliderRingWidth release];
    [_textViewDetails release];
    [super dealloc];
}
@end

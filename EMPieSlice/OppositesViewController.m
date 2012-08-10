//
//  OppositesViewController.m
//  EMPieSlice
//
//  Created by Eric McConkie on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OppositesViewController.h"
#import "EMPie.h"

#define kWidth 100.0

@interface OppositesViewController ()

@end

@implementation OppositesViewController
-(void)onTapPie:(UITapGestureRecognizer*)tap
{
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)piechart
{
    int times[]= {9,10,11,12};

    int count = sizeof(times)/sizeof(int);
    
    //define some vars for adjustments
    //we can start with the small pie, and make bigger ones outside of each
    CGFloat sze = kWidth;
    float x,y,w,h;
    w =h = sze;
    x= self.view.center.x-(sze/2);
    y= kWidth;
    for (int b = count-1; b>=0; b--) {
        
        EMPie *p = [[EMPie alloc] initWithFrame:CGRectZero];
        CGRect frm = CGRectMake(x,y,w,h);
        [p setFrame:frm];
        [self.view addSubview:p];
        
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
        float blue = (b+40)/255.0;
        [p.sliceLayer setPieBackgroundColor:[UIColor colorWithRed:r green:g blue:blue alpha:1.0]];
        
        int tt = times[b];
        float perc = (float)tt/ 13.0;
        if(b%2==0)
            perc = -perc;
        
        [p animateFrom:0 to:perc];
        
        
        
        //tap
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapPie:)];
        [p addGestureRecognizer:tap];
        [tap release];
    }

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [[self view]setBackgroundColor:[UIColor lightGrayColor]];
    [self performSelector:@selector(piechart) withObject:nil afterDelay:0.5];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

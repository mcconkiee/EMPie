//
//  EMViewController.h
//  EMPieSlice
//
//  Created by Eric McConkie on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMPie.h"
@interface SandboxViewController : UIViewController
{
    NSArray *pies;
    int _selectedIndex;
}
@property (retain, nonatomic) IBOutlet UITextView *textViewDetails;
@property (retain, nonatomic) IBOutlet UISlider *sliderForAnimation;
@property (retain, nonatomic) IBOutlet UISlider *slider;
@property (retain, nonatomic) IBOutlet UISlider *sliderRingWidth;
@end

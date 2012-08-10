//
//  EMAppDelegate.h
//  EMPieSlice
//
//  Created by Eric McConkie on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EMMainViewController;

@interface EMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) EMMainViewController *viewController;

@end

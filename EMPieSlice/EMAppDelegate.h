//
//  EMAppDelegate.h
//  EMPieSlice
//
//  Created by Eric McConkie on 8/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EMViewController;

@interface EMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) EMViewController *viewController;

@end

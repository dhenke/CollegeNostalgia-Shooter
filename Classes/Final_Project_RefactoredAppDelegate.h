//
//  Final_Project_RefactoredAppDelegate.h
//  Final-Project-Refactored
//
//  Created by David Henke on 11/24/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface Final_Project_RefactoredAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end

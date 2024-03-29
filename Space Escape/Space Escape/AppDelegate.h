//
//  AppDelegate.h
//  Space Escape
//
//  Created by Ben Leiken on 4/22/12.
//  Copyright Tufts 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end

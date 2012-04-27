//
//  AppDelegate.h
//  space scroller
//
//  Created by Samuel Daniel on 4/23/12.
//  Copyright Tufts University 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end

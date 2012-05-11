//
//  SceneManager.m
//  Space Escape
//
//  Created by Ben Leiken on 5/10/12.
//  Copyright (c) 2012 Tufts. All rights reserved.
//

#import "SceneManager.h"
#import "MenuLayer.h"
#import "ControlsLayer.h"
#import "BackgroundLayer.h"

@interface SceneManager ()
+(void) go: (CCLayer *) layer;
+(CCScene *) wrap: (CCLayer *) layer;
@end


@implementation SceneManager


+(void) goMenu{
	CCLayer *layer = [MenuLayer node];
	[SceneManager go: layer];
}
+(void) goPlay{
    CCLayer *layer = [BackgroundLayer node];
    [SceneManager go: layer];
}

+(void) goControls{
    CCLayer* layer = [ControlsLayer node];
    [SceneManager go: layer];
}

+(void) go: (CCLayer *) layer{
	CCDirector *director = [CCDirector sharedDirector];
	CCScene *newScene = [SceneManager wrap:layer];
	if ([director runningScene]) {
		[director replaceScene:newScene];
	}else {
		[director runWithScene:newScene];		
	}
}

+(CCScene *) wrap: (CCLayer *) layer{
	CCScene *newScene = [CCScene node];
	[newScene addChild: layer];
	return newScene;
}

@end


//
//  MenuLayer.m
//  Space Escape
//
//  Created by Ben Leiken on 5/10/12.
//  Copyright (c) 2012 Tufts. All rights reserved.
//

#import "MenuLayer.h"


@implementation MenuLayer

-(id) init{
	self = [super init];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
	
	float delayTime = 0.3f;
	
	CCMenuItemFont *startNew = [CCMenuItemFont itemFromString:@"New Game" target:self selector: @selector(onNewGame:)];
	
	CCMenuItemFont *controls = [CCMenuItemFont itemFromString:@"Controls" target:self selector: @selector(onControls:)];
	
	CCMenu *menu = [CCMenu menuWithItems:startNew, controls, nil];
	
	for (CCMenuItemFont *each in [menu children]) {
		each.scaleX = 0.0f;
		each.scaleY = 0.0f;
		CCAction *action = [CCSequence actions:
							[CCDelayTime actionWithDuration: delayTime],
							[CCScaleTo actionWithDuration:0.5F scale:1.0],
							nil];
		delayTime += 0.2f;
		[each runAction: action];
	}
	
    CCSprite *bg = [CCSprite spriteWithFile:@"se_menu.gif"];
    bg.position = ccp(winSize.width/2,winSize.height/2);
    [self addChild:bg];
    
//	titleCenterTop.position = ccp(160, 380);
//	[self addChild: titleCenterTop];
//	
//	titleCenterBottom.position = ccp(160, 300);
//	[self addChild: titleCenterBottom];
//	
//	titleQuotes.position = ccp(160, 345);
//	[self addChild: titleQuotes];
//	
//	titleLeft.position = ccp(80, -80);
//	CCAction *titleLeftAction = [CCSequence actions:
//								 [CCDelayTime actionWithDuration: delayTime],
//								 [CCEaseBackOut actionWithAction:
//								  [CCMoveTo actionWithDuration: 1.0 position:ccp(80,345)]],
//								 nil];
//	[self addChild: titleLeft];
//	[titleLeft runAction: titleLeftAction];
//	
//	titleRight.position = ccp(220, 520);
//	CCAction *titleRightAction = [CCSequence actions:
//								  [CCDelayTime actionWithDuration: delayTime],
//								  [CCEaseBackOut actionWithAction:
//								   [CCMoveTo actionWithDuration: 1.0 position:ccp(220,345)]],
//								  nil];
//	[self addChild: titleRight];
//	[titleRight runAction: titleRightAction];
	
	menu.position = ccp(160, 75);
	[menu alignItemsVerticallyWithPadding: 40.0f];
	[self addChild:menu z: 2];
	
	return self;
}

- (void)onNewGame:(id)sender{
	[SceneManager goPlay];
}

- (void)onControls:(id)sender{
	[SceneManager goControls];
}

@end

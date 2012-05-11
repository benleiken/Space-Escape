//
//  ControlsLayer.m
//  Space Escape
//
//  Created by Ben Leiken on 5/10/12.
//  Copyright (c) 2012 Tufts. All rights reserved.
//

#import "ControlsLayer.h"

@implementation ControlsLayer
-(id) init{
	self = [super init];
    
    
	if (!self) {
		return nil;
	}
    CCSprite *bg = [CCSprite spriteWithFile:@"se_controls.gif"];
    bg.position = ccp(240,160);
    [self addChild:bg];
    
	CCMenuItemFont *back = [CCMenuItemFont itemFromString:@"back" target:self selector: @selector(back:)];
	CCMenu *menu = [CCMenu menuWithItems: back, nil];
	
	menu.position = ccp(400, 150);
	[self addChild: menu];
	
	return self;
}

-(void) back: (id) sender{
	[SceneManager goMenu];
}

@end


//
//  HelloWorldLayer.m
//  Space Escape
//
//  Created by Ben Leiken on 4/22/12.
//  Copyright Tufts 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		//create both sprite to handle background
		background = [CCSprite spriteWithFile:@"background.png"];
		background2 = [CCSprite spriteWithFile:@"background.png"];
        
		//one the screen and second just next to it
		background.position = ccp(winSize.width/2, winSize.height/2);
		background2.position = ccp(winSize.width/2, -winSize.height/2);
        
		//add schedule to move backgrounds
		[self schedule:@selector(scroll:)];
        
		//ofc add them to main layer
		[self addChild:background];
		[self addChild:background2];
	}
	return self;
}

- (void) scroll:(ccTime)dt{
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];

    
	BOOL flg=FALSE;
    
	//reset position when they are off from view.
    if (background.position.y - background.contentSize.height/2 >= winSize.height ) {
        background.position = ccp(winSize.width/2, -winSize.height/2);
		background2.position = ccp(winSize.width/2, winSize.height/2);
		flg =TRUE;
    }
    
	if (background2.position.y - background2.contentSize.height/2>= winSize.height) {
        background2.position = ccp(winSize.width/2, -winSize.height/2);
		background.position = ccp(winSize.width/2, winSize.height/2);
		flg =TRUE;
    }
    
	if (!flg) {
		//move them 100*dt pixels to left
		background.position = ccp( background.position.x , background.position.y + 40*dt);
		background2.position = ccp( background2.position.x , background2.position.y + 40*dt);
	}
    
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end

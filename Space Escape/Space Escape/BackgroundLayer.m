//
//  BackgroundLayer.m
//  Space Escape
//
//  Created by Sam Daniel on 4/22/12.
//  Copyright Tufts 2012. All rights reserved.
//


// Import the interfaces
#import "BackgroundLayer.h"

// HelloWorldLayer implementation
@implementation BackgroundLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	BackgroundLayer *layer = [BackgroundLayer node];
	
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
        seeker = [CCSprite spriteWithFile:@"seeker.png"];
        
		//one the screen and second just next to it
		background.position = ccp(winSize.width/2, winSize.height/2);
		background2.position = ccp(winSize.width + background2.contentSize.width/2, winSize.height/2);
        seeker.position = ccp(10, winSize.height/2);
        
		//add schedule to move backgrounds
		[self schedule:@selector(scroll:)];
        
		//ofc add them to main layer
		[self addChild:background];
		[self addChild:background2];
        [self addChild:seeker];
	}
	return self;
}

- (void) scroll:(ccTime)dt{
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];

    
	BOOL flg=FALSE;
    
    if (!flg) {
		//move them 100*dt pixels to left
		background.position = ccp( background.position.x - 40*dt, background.position.y);
		background2.position = ccp( background2.position.x  - 40*dt, background2.position.y);
	}
    
	//reset position when they are off from view.
    if (background.position.x + background.contentSize.width/2 <= 0 ) {
        background.position = ccp(winSize.width/2 + background.contentSize.width/2, winSize.height/2);
		background2.position = ccp(winSize.width/2, winSize.height/2);
		flg =TRUE;
    }

	if (background2.position.x + background2.contentSize.width/2 <= 0) {
        background2.position = ccp(winSize.width/2 + background2.contentSize.width/2, winSize.height/2);
		background.position = ccp(winSize.width/2, winSize.height/2);
		flg =TRUE;
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

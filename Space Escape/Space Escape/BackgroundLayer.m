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

@synthesize astronaut = _astronaut;
@synthesize running = _running;
@synthesize jumping = _jumping;
@synthesize move = _move;
@synthesize isRunning = _isRunning;

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
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if((self=[super init])) {
        
        self.isTouchEnabled = YES;
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
		//create both sprite to handle background
		background = [CCSprite spriteWithFile:@"se_background.gif"];
		background2 = [CCSprite spriteWithFile:@"se_background.gif"];
        seeker = [CCSprite spriteWithFile:@"seeker.png"];
        lamp1 = [CCSprite spriteWithFile:@"lamp.png"];
        box1 = [CCSprite spriteWithFile:@"box.png"];
        
		//one the screen and second just next to it
		background.position = ccp(winSize.width/2, winSize.height/2);
		background2.position = ccp(winSize.width + background2.contentSize.width/2, winSize.height/2);
        seeker.position = ccp(winSize.width + 300, winSize.height/2);
        lamp1.position = ccp(winSize.width + 450, winSize.height - lamp1.contentSize.height/2);
        box1.position = ccp(winSize.width + 500, 100);
        
		//add schedule to move backgrounds
		[self schedule:@selector(scroll:)];
        [self schedule:@selector(collisiondetection)];
        
		//ofc add them to main layer
		[self addChild:background];
		[self addChild:background2];
        [self addChild:seeker];
        [self addChild:lamp1];
        [self addChild:box1];
        
        _isRunning = TRUE;
        clicks = 0;
        
        // running action
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"running.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"running.png"];
        [self addChild:spriteSheet];
        NSMutableArray *runningFrames = [NSMutableArray array];
        for(int i = 1; i <= 8; ++i) {
            [runningFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"running%d.png", i]]];
        };
        
        //jumping action
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"jumping.plist"];
        CCSpriteBatchNode *jumpingSpriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"jumping.png"];
        [self addChild:jumpingSpriteSheet];
        NSMutableArray *jumpingFrames = [NSMutableArray array];
        for(int i = 1; i <= 6; ++i) {
            [jumpingFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"jumping%d.png", i]]];
        };
        
        //if (_isRunning) {
        CCAnimation *runningAnim = [CCAnimation animationWithFrames:runningFrames delay:0.1f];
        self.astronaut = [CCSprite spriteWithSpriteFrameName:@"running1.png"];        
        _astronaut.position = ccp(50, 100);
        self.running = [CCRepeatForever actionWithAction:
                        [CCAnimate actionWithAnimation:runningAnim restoreOriginalFrame:NO]];
        [_astronaut runAction:_running];
        [spriteSheet addChild:_astronaut];
        //}
        //else {
        //    CCAnimation *jumpingAnim = [CCAnimation animationWithFrames:jumpingFrames delay:0.1f];
        //    _astronaut = [CCSprite spriteWithSpriteFrameName:@"jumping1.png"];        
        //    _astronaut.position = ccp(50, 100);
        //    self.jumping = [CCAnimate actionWithAnimation:jumpingAnim restoreOriginalFrame:NO];
        //    [_astronaut runAction:_jumping];
        //    [jumpingSpriteSheet addChild:_astronaut];
        //}
	}
	return self;
}

-(void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 
                                              swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
	return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event { 
    if (_astronaut.position.y == 100){
        id jump = [CCJumpBy actionWithDuration:3 position:ccp(0, 0) 
                                        height:100 jumps:1];
        [_astronaut runAction:jump];
    }
}


- (void) scroll:(ccTime)dt{
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];

    
	BOOL flg=FALSE;
    
	//reset position when they are off from view.
    if (background.position.x + background.contentSize.width/2 < 0 ) {
        background.position = ccp(winSize.width + background.contentSize.width/2, winSize.height/2);
		background2.position = ccp(winSize.width/2, winSize.height/2);
		flg =TRUE;
    }

	if (background2.position.x + background2.contentSize.width/2 < 0) {
        background2.position = ccp(winSize.width + background2.contentSize.width/2, winSize.height/2);
		background.position = ccp(winSize.width/2, winSize.height/2);
		flg =TRUE;
    }
    
    if (!flg) {
		//move them 100*dt pixels to left
		background.position = ccp( background.position.x - 100*dt, background.position.y);
		background2.position = ccp( background2.position.x  - 100*dt, background2.position.y);
        seeker.position = ccp( seeker.position.x - 100*dt, seeker.position.y );
        lamp1.position = ccp( lamp1.position.x - 100*dt, lamp1.position.y );
        box1.position = ccp( box1.position.x - 100*dt, box1.position.y );
	}
    
}

- (void) collisiondetection
{
    CGRect astroRect = [_astronaut boundingBox];
    CGRect box1Rect = [box1 boundingBox];
    
    if (CGRectIntersectsRect(astroRect, box1Rect)) {
        //[fichiersToDelete addObject:fichier];
        _astronaut.position = ccp( 200, 200 );
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
    _astronaut = nil;
    _running = nil;
}

@end

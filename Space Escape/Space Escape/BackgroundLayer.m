//
//  BackgroundLayer.m
//  Space Escape
//
//  Created by Sam Daniel on 4/22/12.
//  Copyright Tufts 2012. All rights reserved.
//


// Import the interfaces
#import "BackgroundLayer.h"

#define kNumEnemies 15
#define kNumBoxes 15

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
        box2 = [CCSprite spriteWithFile:@"box.png"];
        box3 = [CCSprite spriteWithFile:@"box.png"];
        box4 = [CCSprite spriteWithFile:@"box.png"];
        box5 = [CCSprite spriteWithFile:@"box.png"];
        
		//one the screen and second just next to it
		background.position = ccp(winSize.width/2, winSize.height/2);
		background2.position = ccp(winSize.width + background2.contentSize.width/2, winSize.height/2);
        seeker.position = ccp(winSize.width + 300, winSize.height/2);
        lamp1.position = ccp(winSize.width + 450, winSize.height - lamp1.contentSize.height/2);
        box1.position = ccp(winSize.width + 500, 100);
        box2.position = ccp(winSize.width + 1000, 100);
        box3.position = ccp(winSize.width + 1500, 100);
        box4.position = ccp(winSize.width + 2000, 100);
        box5.position = ccp(winSize.width + 2500, 100);
        
		//add schedule to move backgrounds
		[self schedule:@selector(scroll:)];
        [self schedule:@selector(collisiondetection)];
        
		//ofc add them to main layer
		[self addChild:background];
		[self addChild:background2];
        [self addChild:seeker];
        [self addChild:lamp1];
        [self addChild:box1];
        [self addChild:box2];
        [self addChild:box3];
        [self addChild:box4];
        [self addChild:box5];
                
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
        CCAnimation *runningAnim = [CCAnimation animationWithFrames:runningFrames delay:0.1f];
        self.astronaut = [CCSprite spriteWithSpriteFrameName:@"running1.png"];        
        _astronaut.position = ccp(50, 100);
        self.running = [CCRepeatForever actionWithAction:
                        [CCAnimate actionWithAnimation:runningAnim restoreOriginalFrame:NO]];
        [_astronaut runAction:_running];
        [spriteSheet addChild:_astronaut];
        
        xvel = 0;
        yvel = 0;
        
        
        self.isAccelerometerEnabled = YES;

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
        id jump = [CCJumpBy actionWithDuration:1 position:ccp(10,0) height:150 jumps:1];
        [_astronaut runAction:jump];
        _astronaut.position = ccp( _astronaut.position.x - 10, _astronaut.position.y);
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
		background.position = ccp( background.position.x - 170*dt, background.position.y);
		background2.position = ccp( background2.position.x  - 170*dt, background2.position.y);
        seeker.position = ccp( seeker.position.x - 170*dt, seeker.position.y );
        lamp1.position = ccp( lamp1.position.x - 170*dt, lamp1.position.y );
        box1.position = ccp( box1.position.x - 170*dt, box1.position.y );
        box2.position = ccp( box2.position.x - 170*dt, box2.position.y );
        box3.position = ccp( box3.position.x - 170*dt, box3.position.y );
        box4.position = ccp( box4.position.x - 170*dt, box4.position.y );
        box5.position = ccp( box5.position.x - 170*dt, box5.position.y );
	}
    
    float maxY = winSize.height - _astronaut.contentSize.height/2;
    float minY = _astronaut.contentSize.height/2;
    
    float newY = _astronaut.position.y + (_astroPointsPerSecY * dt);
    newY = MIN(MAX(newY, minY), maxY);
    _astronaut.position = ccp(_astronaut.position.x, newY);
    
}

- (void)setInvisible:(CCNode *)node {
    node.visible = NO;
}

//- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
//    
//#define kFilteringFactor 0.1
//#define kRestAccelX -0.6
//#define kShipMaxPointsPerSec (winSize.height*0.5)        
//#define kMaxDiffX 0.2
//    
//    UIAccelerationValue rollingX, rollingY, rollingZ;
//    
//    rollingX = (acceleration.x * kFilteringFactor) + (rollingX * (1.0 - kFilteringFactor));    
//    rollingY = (acceleration.y * kFilteringFactor) + (rollingY * (1.0 - kFilteringFactor));    
//    rollingZ = (acceleration.z * kFilteringFactor) + (rollingZ * (1.0 - kFilteringFactor));
//    
//    float accelX = acceleration.x - rollingX;
//    float accelY = acceleration.y - rollingY;
//    float accelZ = acceleration.z - rollingZ;
//    
//    CGSize winSize = [CCDirector sharedDirector].winSize;
//    
//    float accelDiff = accelX - kRestAccelX;
//    float accelFraction = accelDiff / kMaxDiffX;
//    float pointsPerSec = kShipMaxPointsPerSec * accelFraction;
//    
//    _astroPointsPerSecY = pointsPerSec;
//    
//}

- (void) collisiondetection
{
    CGRect astroRect = [_astronaut boundingBox];
    CGRect box1Rect = [box1 boundingBox];
    CGRect box2Rect = [box2 boundingBox];
    CGRect box3Rect = [box3 boundingBox];
    CGRect box4Rect = [box4 boundingBox];
    CGRect box5Rect = [box5 boundingBox];
    
    if (CGRectIntersectsRect(astroRect, box1Rect)) {
        //[fichiersToDelete addObject:fichier];
        _astronaut.position = ccp( 200, 200 );
    }
    if (CGRectIntersectsRect(astroRect, box2Rect)) {
        //[fichiersToDelete addObject:fichier];
        _astronaut.position = ccp( 200, 200 );
    }
    if (CGRectIntersectsRect(astroRect, box3Rect)) {
        //[fichiersToDelete addObject:fichier];
        _astronaut.position = ccp( 200, 200 );
    }
    if (CGRectIntersectsRect(astroRect, box4Rect)) {
        //[fichiersToDelete addObject:fichier];
        _astronaut.position = ccp( 200, 200 );
    }
    if (CGRectIntersectsRect(astroRect, box5Rect)) {
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

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
        lamp1 = [CCSprite spriteWithFile:@"lamp.png"];
        box1 = [CCSprite spriteWithFile:@"alien.png"];
        box2 = [CCSprite spriteWithFile:@"alien.png"];
        box3 = [CCSprite spriteWithFile:@"alien.png"];
        box4 = [CCSprite spriteWithFile:@"alien.png"];
        box5 = [CCSprite spriteWithFile:@"alien.png"];
        platform1 = [CCSprite spriteWithFile:@"platformshort.png"];
        platform2 = [CCSprite spriteWithFile:@"platformmedium.png"];
        platform3 = [CCSprite spriteWithFile:@"platformlong.png"];
        ship = [CCSprite spriteWithFile:@"ship.png"];
        
//        endgame = [CCSprite spriteWithFile:@"se_gameover.gif"];
//        gameover = false;
        
		//one the screen and second just next to it
		background.position = ccp(winSize.width/2, winSize.height/2);
		background2.position = ccp(winSize.width + background2.contentSize.width/2, winSize.height/2);
        lamp1.position = ccp(winSize.width + 450, winSize.height - lamp1.contentSize.height/2);
        box1.position = ccp(winSize.width + 450, 100);
        box2.position = ccp(winSize.width + 800, 100);
        box3.position = ccp(winSize.width + 1500, 200);
        box4.position = ccp(winSize.width + 900, 100);
        box5.position = ccp(winSize.width + 2500, 100);
        platform1.position = ccp(winSize.width + 450, 150);
        platform2.position = ccp(winSize.width + 800, 250);
        platform3.position = ccp(winSize.width + 1500, 150);
        ship.position = ccp(winSize.width + 4000, winSize.height-ship.contentSize.height/2);
        
		//add schedule to move backgrounds
		[self schedule:@selector(scroll:)];
        [self schedule:@selector(collisiondetection)];
        [self schedule:@selector(check)];
        
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
        [self addChild:platform1];
        [self addChild:platform2];
        [self addChild:platform3];
        [self addChild:ship];
                
        _isRunning   = TRUE;
        _jumpingbool = FALSE;
        _onplatform  = FALSE;
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
        
        platforms = [[CCArray alloc] initWithCapacity:3];
        [platforms addObject:platform1];
        [platforms addObject:platform2];
        [platforms addObject:platform3];
        
	}
	return self;
}

-(void) check{
    
    CGRect astro_rect = [_astronaut boundingBox];
    CGRect plat1_rect = [platform1 boundingBox];
    CGRect plat2_rect = [platform2 boundingBox];
    CGRect plat3_rect = [platform3 boundingBox];

    
    
    if(CGRectIntersectsRect(astro_rect, plat1_rect)){
        _astronaut.position = ccp(50, 185);
        _jumpingbool = FALSE;
    }
    else if(CGRectIntersectsRect(astro_rect, plat3_rect)){
        _astronaut.position = ccp(50, 185);
        _jumpingbool = FALSE;
    }
    else if(CGRectIntersectsRect(astro_rect, plat2_rect)){
        _astronaut.position = ccp(50, 285);
        _jumpingbool = FALSE;
    }
    else if(_jumpingbool == FALSE && _astronaut.position.y > 100){
        _astronaut.position = ccp(_astronaut.position.x, _astronaut.position.y - 10);
    }
    
    if(_jumpingbool){
        if(_astronaut.position.y > 100){
            yvel -= .2;
        }
        else{
            if(yvel != 6){
                yvel = 0;
            }
        }
        
        _astronaut.position = ccp(_astronaut.position.x, _astronaut.position.y + yvel);
        
        if(_astronaut.position.y == 100){
            _jumpingbool = FALSE;
        }
    }
    
}

-(void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 
                                              swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    yvel = 6;
    _jumpingbool = TRUE;
    _astronaut.position = ccp(_astronaut.position.x, _astronaut.position.y + 15);
	return YES;
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
        lamp1.position = ccp( lamp1.position.x - 170*dt, lamp1.position.y );
        box1.position = ccp( box1.position.x - 170*dt, box1.position.y );
        box2.position = ccp( box2.position.x - 170*dt, box2.position.y );
        box3.position = ccp( box3.position.x - 170*dt, box3.position.y );
        box4.position = ccp( box4.position.x - 170*dt, box4.position.y );
        box5.position = ccp( box5.position.x - 170*dt, box5.position.y );
        platform1.position = ccp( platform1.position.x - 170*dt, platform1.position.y );
        platform2.position = ccp( platform2.position.x - 170*dt, platform2.position.y );
        platform3.position = ccp( platform3.position.x - 170*dt, platform3.position.y );
        ship.position = ccp( ship.position.x - 170*dt, ship.position.y );

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
    
    CGRect shipRect = [ship boundingBox];
    
    if (CGRectIntersectsRect(astroRect, box1Rect)) {
        //[fichiersToDelete addObject:fichier];
//        _astronaut.position = ccp( 200, 200 );
        [self gameover];
    }
    if (CGRectIntersectsRect(astroRect, box2Rect)) {
        //[fichiersToDelete addObject:fichier];
//        _astronaut.position = ccp( 200, 200 );
        [self gameover];
    }
    if (CGRectIntersectsRect(astroRect, box3Rect)) {
        //[fichiersToDelete addObject:fichier];
//        _astronaut.position = ccp( 200, 200 );
        [self gameover];
    }
    if (CGRectIntersectsRect(astroRect, box4Rect)) {
        //[fichiersToDelete addObject:fichier];
//        _astronaut.position = ccp( 200, 200 );
        [self gameover];
    }
    if (CGRectIntersectsRect(astroRect, box5Rect)) {
        //[fichiersToDelete addObject:fichier];
//        _astronaut.position = ccp( 200, 200 );
        [self gameover];
    }
    if (CGRectIntersectsRect(astroRect, shipRect)) {
        [self youwin];
    }
}

-(void)gameover {
        
    NSString *message;
    message = @"GAMEOVER";
    
    [_astronaut removeFromParentAndCleanup:YES];
    CCLabelTTF *label;
    label = [CCLabelTTF labelWithString:message fontName:@"Helvetica" fontSize:24];
    label.position = ccp(200,200);
    [self addChild:label];
}

-(void) youwin {
    NSString *message;
    message = @"YOU WIN! FULL GAME COMING SOON!";
    
    [_astronaut removeFromParentAndCleanup:YES];
    CCLabelTTF *label;
    label = [CCLabelTTF labelWithString:message fontName:@"Helvetica" fontSize:24];
    label.position = ccp(250,200);
    [self addChild:label];
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

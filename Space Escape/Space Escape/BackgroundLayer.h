//
//  BackgroundLayer.h
//  Space Escape
//
//  Created by Sam Daniel on 4/27/12.
//  Copyright Tufts 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// BackgroundLayer
@interface BackgroundLayer : CCLayer
{
    CCSprite *background;
    CCSprite *background2;
    CCSprite *seeker;
    
    // objects to avoid
    CCSprite *lamp1;
    CCSprite *box1;
    CCSprite *box2;
    CCSprite *box3;
    CCSprite *box4;
    CCSprite *box5;
    CCSprite *ship;
    
    CCSprite *_astronaut;
    CCAction *_running;
    CCAction *_jumping;
    CCAction *_move;
    BOOL _isRunning;
    BOOL _jumpingbool;
    BOOL _onplatform;
    
    float yvel;
    float xvel;
    float clicks;
    
    float _astroPointsPerSecY;
    
    CCArray *_enemies;
    CCArray *_boxes;
    int _nextEnemy;
    int _nextBox;
    double _nextEnemySpawn;
    double _nextBoxSpawn;
    
    CCSpriteBatchNode *_batchNode;
    
    CCArray *platforms;
    
    CCSprite *platform1;
    CCSprite *platform2;
    CCSprite *platform3;
    
    CCSprite *endgame;
}

@property (nonatomic, retain) CCSprite *astronaut;
@property (nonatomic, retain) CCAction *running;
@property (nonatomic, retain) CCAction *jumping;
@property (nonatomic, retain) CCAction *move;

// returns a CCScene that contains the BackgroundLayer as the only child
+(CCScene *) scene;
- (void) scroll:(ccTime)dt;
- (void) collisiondetection;
//-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event;
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event;
-(void) registerWithTouchDispatcher;
-(void) check;
-(void) gameover;
-(void) youwin;

@end

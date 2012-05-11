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
    
    CCSprite *_astronaut;
    CCAction *_running;
    CCAction *_jumping;
    CCAction *_move;
    BOOL _isRunning;
    BOOL _jumpingbool;
    
    float yvel;
    float clicks;
}

@property (nonatomic, retain) CCSprite *astronaut;
@property (nonatomic, retain) CCAction *running;
@property (nonatomic, retain) CCAction *jumping;
@property (nonatomic, retain) CCAction *move;

// returns a CCScene that contains the BackgroundLayer as the only child
+(CCScene *) scene;
- (void) scroll:(ccTime)dt;
- (void) collisiondetection;

@end

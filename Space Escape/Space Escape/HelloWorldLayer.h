//
//  HelloWorldLayer.h
//  Space Escape
//
//  Created by Ben Leiken on 4/22/12.
//  Copyright Tufts 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    CCSprite *background;
    CCSprite *background2;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
- (void) scroll:(ccTime)dt;

@end

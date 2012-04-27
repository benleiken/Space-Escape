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
}

// returns a CCScene that contains the BackgroundLayer as the only child
+(CCScene *) scene;
- (void) scroll:(ccTime)dt;

@end

//
//  GFFParallaxNode.h
//
//  Created by Rolando Abarca on 12/14/09.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define MAX_PARALLAX_CHILDREN 25

@interface GFFParallaxNode : CocosNode {
	float ratios[MAX_PARALLAX_CHILDREN];
	int childrenNo;
}
- (void)addChild:(CocosNode *)child z:(int)z parallaxRatio:(float)ratio;
- (void)scroll:(float)offset;
@end

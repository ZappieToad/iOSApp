//
//  ZTFrog.h
//  ZappieToad
//
//  Created by Mario J. Wunderlich on 12/15/13.
//  Copyright (c) 2013 Zero Tolerance Software. All rights reserved.
//

#import "cocos2d.h"

typedef enum {
    kZTDirectionUp = 0,
    kZTDirectionLeft = 1,
    kZTDirectionDown = 2,
    kZTDirectionRight = 3,
    kZTDirectionUnknown,
} ZTDirection;

@interface ZTFrog : CCNode {
    CCSprite       *m_oSprite;
}

- (void)moveToX:(int)gridX andY:(int)gridY;

- (void)jumpInDirection:(ZTDirection)direction;
- (void)fireInDirection:(ZTDirection)direction;

@end

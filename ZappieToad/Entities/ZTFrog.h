//
//  ZTFrog.h
//  ZappieToad
//
//  Created by Mario J. Wunderlich on 12/15/13.
//  Copyright (c) 2013 Zero Tolerance Software. All rights reserved.
//

#import "cocos2d.h"
#import "ZTFrogDefinitions.h"

@interface ZTFrog : CCNode {
    CCSprite       *m_oSprite;
    ZTGridXY        m_kGridXY;
}

- (void)moveToX:(int)gridX andY:(int)gridY;
- (void)jumpToGridXY:(ZTGridXY)xy withCompletionBlock:(ZTFrogCompletionBlock)block;

- (void)jumpInDirection:(ZTDirection)direction withCompletionBlock:(ZTFrogCompletionBlock)block;
- (void)fireInDirection:(ZTDirection)direction withCompletionBlock:(ZTFrogCompletionBlock)block;

@property (nonatomic, assign) ZTGridXY gridXY;

@end

//
//  ZTFrogTongue.h
//  ZappieToad
//
//  Created by Mario J. Wunderlich on 12/16/13.
//  Copyright (c) 2013 Zero Tolerance Software. All rights reserved.
//

#import "cocos2d.h"
#import "ZTFrogDefinitions.h"

@interface ZTFrogTongue : CCNode {
    CCSprite * m_oTongueBody;
    CCSprite * m_oTongueHead;
    ZTDirection m_nDirection;
}

@property (nonatomic, assign) float speed;
@property (nonatomic, assign) ccColor3B color;
@property (nonatomic, assign) ZTDirection direction;

- (void)fire;

@end

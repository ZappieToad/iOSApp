//
//  ZTSampleScene.h
//  ZappieToad
//
//  Created by Mario J. Wunderlich on 12/15/13.
//  Copyright (c) 2013 Zero Tolerance Software. All rights reserved.
//

#import "cocos2d.h"

@class ZTFrog;
@class ZTGrid;

@interface ZTSampleLayer : CCLayer <CCTouchOneByOneDelegate>

@property (nonatomic, retain) ZTGrid *gameGrid;
@property (nonatomic, retain) ZTFrog *frog;

+ (CCScene *)scene;

@end

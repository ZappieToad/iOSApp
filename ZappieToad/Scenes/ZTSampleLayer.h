//
//  ZTSampleScene.h
//  ZappieToad
//
//  Created by Mario J. Wunderlich on 12/15/13.
//  Copyright (c) 2013 Zero Tolerance Software. All rights reserved.
//

#import "cocos2d.h"

@class ZTFrog;

@interface ZTSampleLayer : CCLayer <CCTouchOneByOneDelegate>

@property (nonatomic, retain) ZTFrog *frog;

+ (CCScene *)scene;

@end

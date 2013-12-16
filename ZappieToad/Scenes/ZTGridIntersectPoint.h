//
//  ZTGridIntersectPoint.h
//  ZappieToad
//
//  Created by zecmo on 12/15/13.
//  Copyright (c) 2013 Zero Tolerance Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ZTGridIntersectPoint : CCNode
// Property
@property (nonatomic, retain) CCSprite *sprite;
@property (nonatomic, readwrite) bool upPossible;
@property (nonatomic, readwrite) bool downPossible;
@property (nonatomic, readwrite) bool leftPossible;
@property (nonatomic, readwrite) bool rightPossible;

@end

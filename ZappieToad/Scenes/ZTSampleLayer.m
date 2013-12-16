//
//  ZTSampleScene.m
//  ZappieToad
//
//  Created by Mario J. Wunderlich on 12/15/13.
//  Copyright (c) 2013 Zero Tolerance Software. All rights reserved.
//

#import "ZTSampleLayer.h"
#import "ZTGrid.h"

@implementation ZTSampleLayer

+ (CCScene *)scene
{
    CCScene *scene = [CCScene node];
    ZTSampleLayer *layer = [ZTSampleLayer node];

    [scene addChild:layer];

    return scene;
}

- (id)init
{
    if ((self = [super init]) == nil) {
        return nil;
    }

    CCSprite *sprite = [CCSprite spriteWithFile:@"Icon.png"];
    sprite.position = CGPointMake(240, 160);
    [self addChild:sprite];
    
    CCFiniteTimeAction *move1 = [CCMoveTo actionWithDuration:1.0 position:CGPointMake(40, 160)];
    CCFiniteTimeAction *move2 = [CCMoveTo actionWithDuration:1.0 position:CGPointMake(440, 160)];
    CCSequence *sequene = [CCSequence actions:move1, move2, nil];
    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:sequene];
    [sprite runAction:repeat];
    
    CCRotateBy *rotate = [CCRotateBy actionWithDuration:2.0 angle:300];
    [sprite runAction:[CCRepeatForever actionWithAction:rotate]];

    ZTGrid *grid = [ZTGrid node];
    grid.position = CGPointMake(0,0);
    [self addChild:grid];
    
    return self;
}

- (void)dealloc
{
    
}

@end

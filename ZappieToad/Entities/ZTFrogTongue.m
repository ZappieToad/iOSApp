//
//  ZTFrogTongue.m
//  ZappieToad
//
//  Created by Mario J. Wunderlich on 12/16/13.
//  Copyright (c) 2013 Zero Tolerance Software. All rights reserved.
//

#import "ZTFrogTongue.h"

@implementation ZTFrogTongue

@synthesize direction = m_nDirection;

- (id)init
{
    if ((self = [super init]) == nil) {
        return nil;
    }

    m_oTongueBody = [CCSprite spriteWithFile:@"tongue_segment.png"];
    m_oTongueHead = [CCSprite spriteWithFile:@"tongue_end.png"];
    m_nDirection = kZTDirectionRight;

    [self assemble];

    return self;
}

- (void)orient
{
    float rotation = 0;
    switch (m_nDirection) {
        case kZTDirectionUp:
            rotation = 90;
            break;
            
        case kZTDirectionLeft:
            rotation = 180;
            
        case kZTDirectionDown:
            rotation = 270;
            break;

        default:
            break;
    }

    m_oTongueBody.rotation = rotation;
    m_oTongueHead.rotation = rotation;
}

- (void)assemble
{
    [self addChild:m_oTongueHead];
    [self addChild:m_oTongueBody];
}

- (void)fire
{
    [self orient];

    CGPoint target;
    CGPoint scale;
    CGPoint scaleMove;

    float shipX = 0;
    float shipY = 0;

    switch (m_nDirection) {
        case kZTDirectionRight:
            target = ccp(480, shipY);
            scale = ccp(480, 1);
            scaleMove = ccp(240, 0);
            break;

        case kZTDirectionUp:
            target = ccp(shipX, 320);
            scale = ccp(160, 1);
            scaleMove = ccp(0, 80);
            break;
            
        case kZTDirectionLeft:
            target = ccp(-480, shipY);
            scale = ccp(1, -480);
            scaleMove = ccp(-240, 0);
            break;
            
        case kZTDirectionDown:
            target = ccp(shipX, -320);
            scale = ccp(-160, 1);
            scaleMove = ccp(0, -80);
            break;
            
        default:
            break;
    }

    CCActionInterval *action1 = [CCMoveTo actionWithDuration:self.speed position:target];
    action1 = [CCEaseIn actionWithAction:action1 rate:2.0];
    CCActionInterval *action2 = [CCMoveTo actionWithDuration:self.speed position:ccp(0, 0)];
    CCSequence *sequence = [CCSequence actions:action1, action2, nil];
    [m_oTongueHead runAction:sequence];

    CCSpawn *a1 = [CCSpawn actions:
              [CCScaleTo actionWithDuration:self.speed scaleX:scale.x scaleY:scale.y],
              [CCMoveBy actionWithDuration:self.speed position:ccp(scaleMove.x, scaleMove.y)],
                   nil];
    
    CCSpawn *a2 = [CCSpawn actions:
                   [CCScaleTo actionWithDuration:self.speed scaleX:1.0 scaleY:1.0],
                   [CCMoveBy actionWithDuration:self.speed position:ccp(-scaleMove.x, -scaleMove.y)],
                   nil];
    
    CCCallBlockN *a3 = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [self removeFromParentAndCleanup:true];
    }];

    [m_oTongueBody runAction:[CCSequence actions:a1, a2, a3, nil]];
}

/**
 * Instead of scaling a sprite, we can animate a quad,
 * draw it with a red texture on and display using opengl.
 *
 */
- (void)drawTongueAsQuad
{
    float x = self.position.x;
    float y = self.position.y;
    float size = 2.5;

    float coords[] = {
        x, y+size,
        x, y-size,
        x-10, y-size,
        x-10, y+size,
    };
    
    CGPoint vertices[] = {
        ccp(x, y+size),
        ccp(x, y-size),
        ccp(x-10, y-size),
        ccp(x-10, y+size)
    };
}

@end

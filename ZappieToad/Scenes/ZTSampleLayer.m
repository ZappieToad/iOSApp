//
//  ZTSampleScene.m
//  ZappieToad
//
//  Created by Mario J. Wunderlich on 12/15/13.
//  Copyright (c) 2013 Zero Tolerance Software. All rights reserved.
//

#import "ZTSampleLayer.h"
#import "ZTFrog.h"
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

    self.frog = [[ZTFrog alloc] init];
    self.frog.position = CGPointMake(200, 120);
    [self addChild:self.frog];

    [self scheduleOnce:@selector(jump) delay:3.0];

    ZTGrid *grid = [ZTGrid node];
    grid.position = CGPointMake(0,0);
    [self addChild:grid];
    
    return self;
}

- (void)onEnter
{
    [super onEnter];
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:1000 swallowsTouches:true];
}

-(void)onExit
{
    [super onExit];
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
}

- (void)jump
{
    [self.frog moveToX:16 andY:6];
}

- (void)dealloc
{
    
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint point = [touch locationInView:touch.view];
    point = [[CCDirector sharedDirector] convertToGL:point];

    CCSprite *sprite = [CCSprite spriteWithFile:@"frog_v2.png"];
    sprite.position = point;
    [self addChild:sprite];
    CCLOG(@"%f; %f;", sprite.position.x, sprite.position.y);
    return false;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    return;
}

@end

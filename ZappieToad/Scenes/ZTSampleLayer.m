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

    ZTGrid *grid = [ZTGrid node];
    [self addChild:grid];

    self.frog = [[ZTFrog alloc] init];
//    self.frog.position = CGPointMake(200, 120);
    self.frog.position = [grid returnHomeBoundsPoint];// CGPointMake(240, 160);
    [self addChild:self.frog];

//    [self scheduleOnce:@selector(jump) delay:3.0];
    
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

//    CCSprite *sprite = [CCSprite spriteWithFile:@"frog_v2.png"];
  //  sprite.position = point;
    //[self addChild:sprite];
    //CCLOG(@"%f; %f;", sprite.position.x, sprite.position.y);
    
    // Check and move appropriately
    [self checkTouchAndMove:point];
    
    return false;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    // Get the point on release
    CGPoint point = [touch locationInView:touch.view];
    point = [[CCDirector sharedDirector] convertToGL:point];
    
    CGPoint target;
    ZTDirection dir;// = [ZTDirection ];
    dir = kZTDirectionLeft;
    if (point.x < 200) { [self.frog jumpInDirection:dir]; }//target = [grid TryLeft]; }
    
    return;
}

-(void)checkTouchAndMove:(CGPoint) point
{
    ZTDirection dir;
    
    if (point.y < 100)
    {
        dir = kZTDirectionDown;
        [self.frog jumpInDirection:dir];
    }
    else if (point.y > 200)
    {
        dir = kZTDirectionUp;
        [self.frog jumpInDirection:dir];
    }
    else if (point.x < 180)
    {
        dir = kZTDirectionLeft;
        [self.frog jumpInDirection:dir];
    }
    else if (point.x > 280)
    {
        dir = kZTDirectionRight;
        [self.frog jumpInDirection:dir];
    }
}
@end

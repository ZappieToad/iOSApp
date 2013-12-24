//
//  ZTFrog.m
//  ZappieToad
//
//  Created by Mario J. Wunderlich on 12/15/13.
//  Copyright (c) 2013 Zero Tolerance Software. All rights reserved.
//

#import "ZTFrog.h"
#import "ZTFrogTongue2.h"

@interface ZTFrogJump : NSObject
@property (nonatomic, assign) ZTDirection direction;
@property (nonatomic, retain) ZTFrog *frog;
@property (nonatomic, retain) ZTFrogJump *next;
@property (nonatomic, assign) ZTGridXY gridXY;
@property (nonatomic, copy) ZTFrogCompletionBlock block;
- (id)initWithDirection:(ZTDirection) direction andFrog:(ZTFrog *)frog;;
@end

@implementation ZTFrogJump
- (id)initWithDirection:(ZTDirection) direction andFrog:(ZTFrog *)frog
{
    if ((self = [super init]) == nil) {
        return nil;
    }
    
    self.direction = direction;
    self.frog = frog;
    self.next = nil;
    self.block = nil;

    return self;
}

- (void)execute
{
    [self.frog jumpInDirection:self.direction
           withCompletionBlock:^(ZTFrog *frog) {
               // TODO:
               // Make the frog's Grid coordinates match the jump's.
               self.frog.gridXY = self.gridXY;
               
               // Execute the next jump
               [self nextExecute];
           }];
}

- (void)nextExecute
{
    if (self.next != nil) {
        [self.next execute];
    }
    else if (self.block != nil) {
        self.block(self.frog);
    }
}

@end

@implementation ZTFrog

const float g_fJumpSize = 22.0;

- (id)init
{
    if ((self = [super init]) == nil) {
        return nil;
    }

    m_oSprite = [CCSprite spriteWithFile:@"frog_v2.png"];
    [self addChild:m_oSprite];

    return self;
}

- (void)jumpToGridXY:(ZTGridXY)xy withCompletionBlock:(ZTFrogCompletionBlock)block;
{
    int x = xy.x;
    int y = xy.y;

    // TODO:
    // We need to track the frog's position as integral grid-coords
    // Instead of using floating-point pixel coords.
    int x0 = m_kGridXY.x;
    int y0 = m_kGridXY.y;

    ZTFrogJump *root = nil;
    ZTFrogJump *prev = nil;

    float deltax = (x - x0);
    while (x0 != x) {
        ZTDirection direction;
        if (deltax < 0) {
            direction = kZTDirectionLeft;
            x0 --;
        }
        else {
            direction = kZTDirectionRight;
            x0 ++;
        }

        ZTFrogJump *jump = [[ZTFrogJump alloc] initWithDirection:direction andFrog:self];
        jump.gridXY = (ZTGridXY){x0, y0};
        jump.block = block;

        if (root == nil) {
            root = jump;
        }
        if (prev != nil) {
            prev.next = jump;
        }
        prev = jump;
    }

    float deltay = (y - y0);
    while (y0 != y) {
        ZTDirection direction;
        if (deltay < 0) {
            direction = kZTDirectionDown;
            y0 --;
        }
        else {
            direction = kZTDirectionUp;
            y0 ++;
        }
        
        ZTFrogJump *jump = [[ZTFrogJump alloc] initWithDirection:direction andFrog:self];
        jump.gridXY = (ZTGridXY){x0, y0};
        jump.block = block;

        if (root == nil) {
            root = jump;
        }
        if (prev != nil) {
            prev.next = jump;
        }
        prev = jump;
    }

    // Finally execute the jumps
    if (root != nil) {
        [root execute];
    }
}

- (void)moveToX:(int)gridX andY:(int)gridY
{
    if (![self canMoveToX:gridX andY:gridY]) {
        return;
    }

    float targetX = [self worldXForGridX:gridX];
    float targetY = [self worldYForGridY:gridY];

    // Path find way to target
    float x = self.position.x;
    float y = self.position.y;

    int jumpsX = fabs((x - targetX) / g_fJumpSize);
    int jumpsY = fabs((y - targetY) / g_fJumpSize);
    int parity = 0;

    ZTFrogJump *prev = nil;
    ZTFrogJump *root = nil;
    while (jumpsX || jumpsY) {
        ZTDirection direction;
        if ((parity % 2 == 0 && jumpsX != 0) || jumpsY == 0) {
            jumpsX --;
            direction = kZTDirectionRight;
        }
        else {
            jumpsY --;
            direction = kZTDirectionUp;
        }

        ZTFrogJump *jump = [[ZTFrogJump alloc] initWithDirection:direction andFrog:self];
        if (prev != nil) {
            prev.next = jump;
        }
        if (root == nil) {
            root = jump;
        }
        prev = jump;

        parity ++;
    }
    
    [root execute];
}

- (void)jumpInDirection:(ZTDirection)direction withCompletionBlock:(ZTFrogCompletionBlock)block
{
    int x = 0;
    int y = 0;

    switch (direction) {
        case kZTDirectionUp:
            y = 1;
            break;

        case kZTDirectionLeft:
            x = -1;
            break;

        case kZTDirectionDown:
            y = -1;
            break;

        case kZTDirectionRight:
            x = 1;
            break;
            
        default:
            break;
    }

    float jumpSize = 22.0;
    CGPoint jumpPoint = CGPointMake(x * jumpSize, y * jumpSize);

    CCMoveBy *moveBy = [CCMoveBy actionWithDuration:0.25 position:jumpPoint];
    CCCallBlock *callBlock = [CCCallBlock actionWithBlock:^{
        if (block != nil) {
            block(self);
        }
    }];
    CCSequence *sequence = [CCSequence actions:moveBy, callBlock, nil];
    [self runAction:sequence];
}

- (void)fireInDirection:(ZTDirection)direction withCompletionBlock:(ZTFrogCompletionBlock)block
{
    ZTFrogTongue2 *tongue = [[ZTFrogTongue2 alloc] init];
    tongue.extractSpeed = 400;
    tongue.retractSpeed = 300;
    tongue.direction = direction;
    [self addChild:tongue];
    [tongue fireWithCompletionBlock:^(ZTFrogTongue2 *tongue) {
        [self removeChild:tongue];
        if (block != nil) {
            block(self);
        }
    }];
}

- (bool)canMoveToX:(int)x andY:(int)y
{
    return true;
}

- (float)worldXForGridX:(int)gridX
{
    return gridX * g_fJumpSize;
}

- (float)worldYForGridY:(int)gridY
{
    return gridY * g_fJumpSize;
}

@synthesize gridXY = m_kGridXY;

@end

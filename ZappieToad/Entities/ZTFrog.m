//
//  ZTFrog.m
//  ZappieToad
//
//  Created by Mario J. Wunderlich on 12/15/13.
//  Copyright (c) 2013 Zero Tolerance Software. All rights reserved.
//

#import "ZTFrog.h"

@interface ZTFrogJump : NSObject
@property (nonatomic, assign) ZTDirection direction;
@property (nonatomic, retain) ZTFrog *frog;
@property (nonatomic, retain) ZTFrogJump *next;
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

    return self;
}

- (void)execute
{
    [self.frog jumpInDirection:self.direction];
    [self performSelector:@selector(nextExecute) withObject:nil afterDelay:0.3];
}

- (void)nextExecute
{
    if (self.next != nil) {
        [self.next execute];
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

- (void)jumpInDirection:(ZTDirection)direction
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

    float jumpSize = 20.0;
    CGPoint jumpPoint = CGPointMake(x * jumpSize, y * jumpSize);

    CCMoveBy *moveBy = [CCMoveBy actionWithDuration:0.25 position:jumpPoint];
    [self runAction:moveBy];
}

- (void)fireInDirection:(ZTDirection)direction
{
    switch (direction) {
        case kZTDirectionUp:
        case kZTDirectionLeft:
        case kZTDirectionDown:
        case kZTDirectionRight:
            break;

        default:
            break;
    }
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

@end

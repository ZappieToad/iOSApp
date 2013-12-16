//
//  ZTFrog.m
//  ZappieToad
//
//  Created by Mario J. Wunderlich on 12/15/13.
//  Copyright (c) 2013 Zero Tolerance Software. All rights reserved.
//

#import "ZTFrog.h"

@implementation ZTFrog

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
    return false;
}

- (float)worldXForGridX:(int)gridX
{
    return 0.0;
}

- (float)worldYForGridY:(int)gridY
{
    return 0.0;
}

@end

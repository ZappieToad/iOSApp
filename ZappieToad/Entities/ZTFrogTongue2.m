//
//  ZTFrogTongue2.m
//  ZappieToad
//
//  Created by Mario J. Wunderlich on 12/23/13.
//  Copyright (c) 2013 Zero Tolerance Software. All rights reserved.
//

#import "ZTFrogTongue2.h"

@interface ZTFrogTongue2 ()
- (void)setup;
- (void)fireInternal;
- (void)fireFinished;
@end

@implementation ZTFrogTongue2

- (id)init
{
    if ((self = [super init]) == nil) {
        return nil;
    }
    
    
    m_nDirection = kZTDirectionUp;
    m_fExtractSpeed = 1.0;
    m_fRetractSpeed = 1.0;
    m_bInProcess = false;
    m_kCompletionBlock = nil;

    return self;
}

- (bool)fire
{
    if (m_bInProcess) {
        return false;
    }

    [self setup];
    [self fireInternal];

    return true;
}

- (bool)fireWithCompletionBlock:(ZTFrogTongueCompletionBlock)completionBlock
{
    self.completionBlock = completionBlock;

    return [self fire];
}

- (void)setup
{
    m_kOrigin = (ccVertex2F){0.0, 0.0};
    m_kTarget = (ccVertex2F){0.0, 15.0};
//    m_nDirection = kZTDirectionUp;
}

- (void)fireInternal
{
    m_bInProcess = true;
    m_fTravelDone = 0.0;
    m_fTravelTarget = 100.0;
    m_nState = kZTFrogTongueStateExtracting;

    [self scheduleUpdate];
}

- (void)fireFinished
{
    [self unscheduleUpdate];
    m_nState = kZTFrogTongueStateReady;
    if (m_kCompletionBlock != nil) {
        m_kCompletionBlock(self);
    }
}

- (void)draw
{
    [super draw];

    float x1 = m_kOrigin.x;
    float x2 = m_kTarget.x;
    float y1 = m_kOrigin.y;
    float y2 = m_kTarget.y;

    float halfsize = 2.5;

    // Draw the polygon for the tongue using the coordinates established
    // Points will go counter-clockwise
    ccVertex2F points[4];
    
    switch (m_nDirection) {
        case kZTDirectionUp:
        case kZTDirectionDown:
            points[0].x = points[1].x = x1 - halfsize;
            points[2].x = points[3].x = x1 + halfsize;
            points[0].y = points[3].y = y1;
            points[1].y = points[2].y = y2;
            break;

        case kZTDirectionLeft:
        case kZTDirectionRight:
            points[0].x = points[3].x = x1;
            points[1].x = points[2].x = x2;
            points[0].y = points[1].y = y1 - halfsize;
            points[2].y = points[3].y = y1 + halfsize;
            break;
            
        default:
            CCLOGERROR(@"Invalid enum");
            break;
    }

    ccDrawSolidPoly((CGPoint *) ((void *) &points[0].x), 4, ccc4f(1.0, 1.0, 1.0, 1.0));
}

- (void)processState
{
    switch (m_nState) {
        case kZTFrogTongueStateReady:
            // Nothing to be done for now
            break;
        case kZTFrogTongueStateExtracting:
            if (m_fTravelDone >= m_fTravelTarget) {
                m_nState = kZTFrogTongueStateRetracting;
            }
            break;
        case kZTFrogTongueStateRetracting:
            if (m_fTravelDone <= 0.0) {
                m_nState = kZTFrogTongueStateFinished;
            }
            break;
        case kZTFrogTongueStateFinished:
            [self fireFinished];
            break;
    }
}

- (void)update:(ccTime)delta
{
    // Process our current state
    [self processState];

    // Speed determines pixels/second travelled
    // So use the elapsed time (delta) to determine how many pixels to
    // Advance the tongue in this next iteration
    float speed = m_fExtractSpeed;
    if (m_nState == kZTFrogTongueStateRetracting) {
        // We negate the retract speed, because the tongue must travel in the opposite
        // direction from when it was extracting.
        speed = -m_fRetractSpeed;
    }

    float pixelsToTravel = delta * speed;

    if (!m_bInProcess) {
        // If tongue is not firing, then finito.
        return;
    }

    // Apply the pixels to the destination point
    switch (m_nDirection) {
        case kZTDirectionUp:
            m_kTarget.y += pixelsToTravel;
            break;
        case kZTDirectionDown:
            m_kTarget.y -= pixelsToTravel;
            break;
        case kZTDirectionLeft:
            m_kTarget.x -= pixelsToTravel;
            break;
        case kZTDirectionRight:
            m_kTarget.x += pixelsToTravel;
            break;
        default:
            CCLOGERROR(@"Invalid enum");
            [NSException raise:@"Invalid enum" format:@"Using an invalid enum for ZTDirection: %d", m_nDirection];
    }
    
    m_fTravelDone += pixelsToTravel;
}

@synthesize state = m_nState;
@synthesize direction = m_nDirection;
@synthesize extractSpeed = m_fExtractSpeed;
@synthesize retractSpeed = m_fRetractSpeed;
@synthesize completionBlock = m_kCompletionBlock;

@end

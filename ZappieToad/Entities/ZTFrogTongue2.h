//
//  ZTFrogTongue2.h
//  ZappieToad
//
//  Created by Mario J. Wunderlich on 12/23/13.
//  Copyright (c) 2013 Zero Tolerance Software. All rights reserved.
//

#import "cocos2d.h"
#import "ZTFrogTongue.h"

@class ZTFrogTongue2;
typedef void (^ZTFrogTongueCompletionBlock)(ZTFrogTongue2 *tongue);

/**
 * ZTFrogTongueState
 *
 * - Ready: the tongue can fire
 * - Extracting: the tongue is in the extraction phase
 * - Retracting: the tongue is in the retraction phase
 * - Finished: the tongue has finished execution
 *
 */
typedef enum _ZTFrogTongueState {
    kZTFrogTongueStateReady,
    kZTFrogTongueStateExtracting,
    kZTFrogTongueStateRetracting,
    kZTFrogTongueStateFinished,
} ZTFrogTongueState;

@interface ZTFrogTongue2 : CCNode {
    // The state of the tongue
    ZTFrogTongueState m_nState;
    
    // This represents the direction the tongue will shoot out in
    ZTDirection m_nDirection;
    
    // This is the speed at which the tongue will lash out
    float m_fExtractSpeed;
    
    // This is the speed at which the tongue retracts
    float m_fRetractSpeed;
    
    // At present, we do not know how far the tongue must travel before we
    // consider it as completed... so for now we'll use a fake target
    float m_fTravelDone;
    float m_fTravelTarget;
    
    // If the tongue is in the process of extracting/retracting, then this
    // flag will be set to true. While this flag is true, tongue cannot fire.
    bool m_bInProcess;

    // Used to draw the tongue
    ccVertex2F m_kOrigin;
    ccVertex2F m_kTarget;

    // If set, then this completion block will be invoked after the tongue
    // has finished the firing sequence.
    ZTFrogTongueCompletionBlock m_kCompletionBlock;
}

- (bool)fire;
- (bool)fireWithCompletionBlock:(ZTFrogTongueCompletionBlock)completionBlock;

@property (nonatomic, readonly) ZTFrogTongueState state;
@property (nonatomic, assign) ZTDirection direction;
@property (nonatomic, assign) float extractSpeed;
@property (nonatomic, assign) float retractSpeed;
@property (nonatomic, copy) ZTFrogTongueCompletionBlock completionBlock;

@end

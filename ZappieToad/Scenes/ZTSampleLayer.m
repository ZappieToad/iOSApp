//
//  ZTSampleScene.m
//  ZappieToad
//
//  Created by Mario J. Wunderlich on 12/15/13.
//  Copyright (c) 2013 Zero Tolerance Software. All rights reserved.
//

#import "ZTSampleLayer.h"

@implementation ZTSampleLayer

+ (CCScene *)scene
{
    CCScene *scene = [CCScene node];
    ZTSampleLayer *layer = [ZTSampleLayer node];
    
    [scene addChild:layer];
    
    return scene;
}

- (void)dealloc
{
    
}

@end

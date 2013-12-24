//
//  ZTGridIntersectPoint.m
//  ZappieToad
//
//  Created by zecmo on 12/15/13.
//  Copyright (c) 2013 Zero Tolerance Software. All rights reserved.
//

#import "ZTGridIntersectPoint.h"

@implementation ZTGridIntersectPoint

- (id)init
{
    if ((self = [super init]) == nil) {
        return nil;
    }
    
    self.sprite = [CCSprite spriteWithFile:@"Icon.png"];
    self.sprite.scale = 0.25f;
    
    [self addChild:self.sprite];
    
    //
    self.upPossible = true;
    self.downPossible = true;
    self.leftPossible = true;
    self.rightPossible= true;
    
    // This is the property
  //  self.sprite = nil;
    
    return self;
}

@end

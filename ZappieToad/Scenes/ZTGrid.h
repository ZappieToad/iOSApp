//
//  ZTGrid.h
//  ZappieToad
//
//  Created by zecmo on 12/15/13.
//  Copyright (c) 2013 Zero Tolerance Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ZTGrid : CCNode 
// Property
@property (nonatomic, retain) NSMutableArray *homeBounds;
@property (nonatomic, retain) NSMutableArray *leftBounds;
@property (nonatomic, retain) NSMutableArray *rightBounds;
@property (nonatomic, retain) NSMutableArray *upperBounds;
@property (nonatomic, retain) NSMutableArray *lowerBounds;

-(CGPoint)returnHomeBoundsPoint;

@end

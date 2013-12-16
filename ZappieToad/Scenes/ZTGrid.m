//
//  ZTGrid.m
//  ZappieToad
//
//  Created by zecmo on 12/15/13.
//  Copyright (c) 2013 Zero Tolerance Software. All rights reserved.
//

#include <stdlib.h>
#import "ZTGrid.h"
#import "ZTGridIntersectPoint.h"

@interface ZTGridPoint : NSObject
@property (nonatomic, assign) CGPoint point;
@end

@implementation ZTGrid

- (id)init
{
    if ((self = [super init]) == nil) {
        return nil;
    }
    
    // Let's build out the grid
    int xSeed = 26;
    int ySeed = 13;
    int xWidth = 22;
    int yWidth = 22;
    int columns= 20;
    int rows = 14;
    
    self.homeBounds = [[NSMutableArray alloc] init];
    self.leftBounds = [[NSMutableArray alloc] init];
    self.rightBounds= [[NSMutableArray alloc] init];
    self.upperBounds= [[NSMutableArray alloc] init];
    self.lowerBounds= [[NSMutableArray alloc] init];
    
    ZTGridIntersectPoint *intersection;
    int x,y;
    for (x=0; x<columns; x++) {
        for (y=0; y<rows; y++) {
            if ((y>4 && y<9) ||
                (x>7 && x<12))
            {
                intersection = [[ZTGridIntersectPoint alloc] init];
                intersection.position = CGPointMake(x*xWidth + xSeed, y*yWidth + ySeed);
                
                // Colorize them based on homeBounds & outerBounds
                if ((y>4 && y<9) &&
                    (x>7 && x<12))
                {
                    intersection.sprite.color = ccRED;
                    
                    // This is also where I add to the list of possible positions
                 //   ZTGridPoint *point = [[ZTGridPoint alloc] init];
                   // point.point = CGPointMake(0, 0);
                    [self.homeBounds addObject:intersection];
                }
                else {
                    intersection.sprite.color = ccGREEN;
                    
                    if (x<=7) {
                        [self.leftBounds addObject:intersection];
                    }
                    else if (x>=12) {
                        [self.rightBounds addObject:intersection];
                    }
                    else if (y<=4) {
                        [self.upperBounds addObject:intersection];
                    }
                    else if (y>=9) {
                        [self.lowerBounds addObject:intersection];
                    }
                }
                
                [self addChild:intersection];
            }
        }
    }
    
    return self;
}

-(CGPoint)returnHomeBoundsPoint
{
    int index = arc4random() % self.homeBounds.count;
    ZTGridIntersectPoint *point = self.homeBounds[index];
    return point.position;
}

@end

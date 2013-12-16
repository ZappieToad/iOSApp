//
//  ZTGrid.m
//  ZappieToad
//
//  Created by zecmo on 12/15/13.
//  Copyright (c) 2013 Zero Tolerance Software. All rights reserved.
//

#import "ZTGrid.h"
#import "ZTGridIntersectPoint.h"

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
    
    ZTGridIntersectPoint *intersection;
    int x,y;
    for (x=0; x<columns; x++) {
        for (y=0; y<rows; y++) {
            if ((y>4 && y<9) ||
                (x>7 && x<12)) {
                intersection = [[ZTGridIntersectPoint alloc] init];
                intersection.position = CGPointMake(x*xWidth + xSeed, y*yWidth + ySeed);
                if ((y>4 && y<9) &&
                    (x>7 && x<12)) {
                    intersection.sprite.color = ccRED;
                }
                else {
                    intersection.sprite.color = ccGREEN;
                }
                [self addChild:intersection];
            }
        }
    }
    
    return self;
}


@end

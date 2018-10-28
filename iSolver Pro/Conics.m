//
//  Conics.m
//  iSolver Pro
//
//  Created by Parker Caputo on 2/19/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "Conics.h"

@implementation Conics

- (BOOL)majorOnXaxiswithVert:(gPoint *)p1 andCoVert:(gPoint *)p2{
    
    if (p1.x > p2.x) {
        return TRUE;
    } else {
        return FALSE;
    }
}

@end

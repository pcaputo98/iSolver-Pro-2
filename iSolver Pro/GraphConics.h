//
//  GraphConics.h
//  iSolver Pro
//
//  Created by Parker Caputo on 2/12/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gPoint.h"
#import "Graph.h"

@interface GraphConics : Graph {
    BOOL graphCircle;
    gPoint *center_GRAPH;
    double radius_GRAPH;
}


- (void)requestCircleWithCenter:(gPoint*)center andRadius:(double)radius;
- (UIView*)graphCircleWithCenter:(gPoint*)center andRadius:(double)radius;

@end

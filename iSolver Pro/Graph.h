//
//  Graph.h
//  iSolver Pro
//
//  Created by Parker Caputo on 12/3/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Graph : UIView {
    double xMax, xMin, yMax, yMin;
    int graphWidth, graphHeight;
    
    NSMutableArray *currentArray;

}
@property NSMutableArray *currentArray;
@property double xMax, xMin, yMax, yMin;
@property int graphWidth, graphHeight;

- (UIView*) makeXAxis;
- (UIView*) makeYAxis;
- (UIView*) completeView;
- (void) graphLineWithArray:(NSMutableArray*)arry; // Can't be called until points array has been set

- (void) setGraphWidth:(int)width;
- (void) setGraphHeight:(int)height;

@end


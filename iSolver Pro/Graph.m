//
//  Graph.m
//  iSolver Pro
//
//  Created by Parker Caputo on 12/3/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//


#import "Graph.h"
#import "gPoint.h"
#import <QuartzCore/QuartzCore.h>

@implementation Graph

@synthesize xMax, xMin, yMax, yMin, graphHeight, graphWidth, currentArray;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Defaults
        NSLog(@"self is %p", self);
        
        graphHeight = 280;
        graphWidth = 280;
        
        xMax = 10;
        xMin = -10;
        yMax = 10;
        yMin = -10;
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    
    if ([currentArray count] > 0)
    {
        double yMultiple = graphHeight / (abs(yMax) + abs(yMin));
        double xMultiple = graphWidth / (abs(xMax) + abs(xMin));
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 1.0);
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        
        for (int i=0; i < ([currentArray count] -1); i++)
        {
            gPoint *aPoint = [currentArray objectAtIndex:i];
            gPoint *nextPoint = [currentArray objectAtIndex:i + 1];
            
            double theX = aPoint.x;
            double theY = aPoint.y;
            
            double toStartX = nextPoint.x;
            double toStartY = nextPoint.y;
            
            CGContextMoveToPoint(context, (theX * xMultiple) + graphWidth/2, (theY * -yMultiple) + graphHeight/2);
            CGContextAddLineToPoint(context, (toStartX * xMultiple) + graphWidth/2, (toStartY * -yMultiple) + graphHeight/2);
            CGContextStrokePath(context);
        }
        [self addSubview:[self completeView]];
    }
    
}

// THE CLASSES ARE RESPONSIBLE FOR SUPPLYING AN ARRAY WITH POINTS THEY WANT TO GRAPH!

- (void) graphLineWithArray:(NSMutableArray *)arry {

    currentArray = arry;
}


- (UIView*) completeView {
    UIView *completeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, graphHeight, graphHeight)];
    
    [completeView addSubview:[self makeXAxis]];
    [completeView addSubview:[self makeYAxis]];
    
    return completeView;
}


- (UIView*) makeXAxis {
    
    UIView *xAxis = [[UIView alloc] initWithFrame:CGRectMake(0, graphHeight/2, graphWidth, 1)];
    xAxis.backgroundColor = [UIColor redColor];
    
    // How many intervals I'll need total
    int xIntervals = abs(xMax) + abs(xMin);
    double markLength = graphWidth / xIntervals;
    
    for (int i = 0; i < xIntervals + 1; i++) {
        
        UIView *intervalLine = [[UIView alloc] initWithFrame:CGRectMake(markLength * i, -2.5, 1, 6)];
        intervalLine.backgroundColor = [UIColor redColor];
        [xAxis addSubview:intervalLine];
        
    }
    return xAxis;
    
                        
}
                    
- (UIView*) makeYAxis {
    
    UIView *yAxis = [[UIView alloc] initWithFrame:CGRectMake(graphWidth/2, 0, 1, graphHeight)];
    yAxis.backgroundColor = [UIColor redColor];
    
    // How many intervals I'll need total
    int yIntervals = abs(yMax) + abs(yMin);
    double markLength = graphHeight / yIntervals;
    
    for (int i = 0; i < yIntervals + 1; i++) {
        UIView *intervalLine = [[UIView alloc] initWithFrame:CGRectMake(-2.5, markLength * i, 6, 1)];
        intervalLine.backgroundColor = [UIColor redColor];
        [yAxis addSubview:intervalLine];
    }
    
    return yAxis;
                            
}


@end

//
//  GraphConics.m
//  iSolver Pro
//
//  Created by Parker Caputo on 2/12/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "GraphConics.h"

@implementation GraphConics


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Defaults
        
        graphHeight = 280;
        graphWidth = 280;
        
        xMax = 10;
        xMin = -10;
        yMax = 10;
        yMin = -10;
    }
    return self;
}

- (void)requestCircleWithCenter:(gPoint *)center andRadius:(double)radius {
    
    center_GRAPH = center; radius_GRAPH = radius; graphCircle = TRUE;
    
}

- (UIView*)graphCircleWithCenter:(gPoint *)center andRadius:(double)radius {
    
    
    double yMultiple = graphHeight / (abs(yMax) + abs(yMin));
    double xMultiple = graphWidth / (abs(xMax) + abs(xMin));
    
    CAShapeLayer *circle = [CAShapeLayer layer];
    // Make a circular shape
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(graphWidth/2, graphHeight/2, (radius*2) * xMultiple, (radius*2) *yMultiple)
                                             cornerRadius:(radius*xMultiple)].CGPath;
    // Center the shape in self.view
    if (center.x == 0) {
        center.x = .0000000000001;
    }
    if (center.y == 0) {
        center.y = .0000000000001;
    }
    
    circle.position = CGPointMake((center.x * xMultiple) - (radius*xMultiple), (center.y * yMultiple * -1) - (radius*yMultiple));

    
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.strokeColor = [UIColor blueColor].CGColor;
    circle.lineWidth = 2;
    
    UIView *circleView = [[UIView alloc] init];
    [circleView.layer addSublayer:circle];
    
    return circleView;
    
}



- (void)drawRect:(CGRect)rect
{
    [[self subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (graphCircle == TRUE) { // Draw a circle :D
        
        UIView *finalGraph = [[UIView alloc] initWithFrame:CGRectMake(0, 0, graphHeight, graphHeight)];
        [finalGraph addSubview:[self graphCircleWithCenter:center_GRAPH andRadius:radius_GRAPH]];
        [self addSubview:finalGraph];
        [self sendSubviewToBack:finalGraph];
        [self addSubview:[self completeView]];
        self.clipsToBounds = YES;
        graphCircle = FALSE;
        
    }
}


@end

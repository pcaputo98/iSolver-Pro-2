//
//  StandardQuadSolver.h
//  iSolver Pro
//
//  Code adapted from original iSolver
//  Created by Parker Caputo on 11/20/14.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Graph.h"


@interface StandardQuadSolver : UIViewController

- (NSMutableArray*)generatePointsWith:(double)a andB:(double)b andC:(double)c; // Creates a points array to send to the graph

- (NSString*)getInputData; // Gets the input data

- (BOOL)regexValidateQuadraticWithString:(NSString*)quad; // Validates that the input data is in fact a quadratic
- (BOOL)doubleSignDetection:(NSString*)quad;

- (double)getA:(NSString*)quad;
- (double)getB:(NSString*)quad;
- (double)getC:(NSString*)quad;

@property (weak, nonatomic) IBOutlet UITextField *inputBox;


@property (weak, nonatomic) IBOutlet UIButton *solveButton;


@property (weak, nonatomic) IBOutlet UIButton *exampleButton;


@property (weak, nonatomic) IBOutlet UILabel *answerBox;


@property (strong, nonatomic) IBOutlet Graph *graphArea;



@end

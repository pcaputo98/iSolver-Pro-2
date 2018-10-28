//
//  PolynomialSolver.h
//  iSolver Pro
//
//  Created by Parker Caputo on 1/8/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Graph.h"


@interface PolynomialSolver : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *inputBox;

@property (weak, nonatomic) IBOutlet UIButton *exampleButton;

@property (weak, nonatomic) IBOutlet UIButton *solveButton;

@property (strong, nonatomic) IBOutlet Graph *graphArea;

- (NSMutableArray*)getExponetsWithEquation:(NSString*)str; // Extracts all exponets and converts to NSMutableArray

- (NSMutableArray*)addDegreeOneToArray:(NSMutableArray*)arry; // Grabs the lone x term...if it exists?
- (double)caputureConstantInPoly:(NSString*)str;
- (BOOL)validatePoly:(NSString*)str;

- (NSMutableArray*)generatePointsWithEquation:(NSMutableArray*)arry;
- (NSString*)getInputData; // Gets the input data

@end

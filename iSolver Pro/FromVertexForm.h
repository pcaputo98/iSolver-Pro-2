//
//  FromVertexForm.h
//  iSolver Pro
//
//  Created by Parker Caputo on 1/25/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Graph.h"
#import "StandardQuadSolver.h"
#import "FoilSolver.h"
#import "ISolve.h"

@interface FromVertexForm : UIViewController

@property StandardQuadSolver *sqs;
@property FoilSolver *fs;
@property ISolve *is;

@property (weak, nonatomic) IBOutlet UILabel *answerBox;
@property (weak, nonatomic) IBOutlet UITextField *inputBox;
@property (weak, nonatomic) IBOutlet UIButton *exampleButton;
@property (weak, nonatomic) IBOutlet UIButton *solveButton;
@property (strong, nonatomic) IBOutlet Graph *graphArea;

- (NSString*)getInputData;
- (NSString*)getDualBinomial;
- (NSString*)getStandardFormOfEquationFromVertexForm:(NSString*)eq;
- (double)getAfromEquation;
- (double)getKfromEquation;
- (NSString*)cleanFinalAnswer:(NSString*)str;

@end

//
//  InequalitySolver.h
//  iSolver Pro
//
//  Created by Parker Caputo on 1/20/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Graph.h"

@interface InequalitySolver : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *answerBox;
@property (weak, nonatomic) IBOutlet UITextField *inputBox;
@property (weak, nonatomic) IBOutlet UIButton *solveButton;
@property (weak, nonatomic) IBOutlet UIButton *exampleButton;




- (NSString*)getInputData;
- (NSString*)getSign:(NSString*)inEquality;
- (NSString*)getLeftSideOfEquation:(NSString*)equation;
- (NSString*)getRightSideOfEquation:(NSString*)equation;
- (double)combineVariablesInEquation:(NSString*)equation;
- (double)combineConstantTermsInEquation:(NSString*)equation;




@end

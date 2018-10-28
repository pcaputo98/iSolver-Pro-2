//
//  FactorTrinomial.h
//  iSolver Pro
//
//  Created by Parker Caputo on 1/23/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StandardQuadSolver.h"
#import "ISolve.h"
#import "FactorObject.h"


@interface FactorTrinomial : UIViewController

@property StandardQuadSolver *qs;
@property ISolve *is;

@property (weak, nonatomic) IBOutlet UITextField *inputBox;
@property (weak, nonatomic) IBOutlet UIButton *solveButton;
@property (weak, nonatomic) IBOutlet UIButton *exampleButton;
@property (weak, nonatomic) IBOutlet UILabel *answerBox;


- (NSString*)getInputData;
- (int)getGreatestCommonFactorWith:(int)f1 and:(int)f2;
- (FactorObject*)findFactorsOf:(int)num1 thatAddToBe:(int)num2 andMultiplyToBe:(int)num3;




@end

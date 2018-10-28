//
//  RadicalSimplifier.h
//  iSolver Pro
//
//  Created by Parker Caputo on 1/22/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISolve.h"

@interface RadicalSimplifier : UIViewController

@property ISolve *is;
@property (weak, nonatomic) IBOutlet UITextField *inputBox;
@property (weak, nonatomic) IBOutlet UIButton *solveButton;
@property (weak, nonatomic) IBOutlet UIButton *exampleButton;
@property (weak, nonatomic) IBOutlet UILabel *answerBox;

- (int)findPerfectSquareInNumber:(int)num;
- (BOOL)validateRadicalInString:(NSString*)str;
- (NSString*)getInputData;
- (int)getNumber;

@end

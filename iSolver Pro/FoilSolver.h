//
//  FoilSolver.h
//  iSolver Pro
//
//  Created by Parker Caputo on 1/22/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.

#import <UIKit/UIKit.h>
#import "ISolve.h"
#import "Graph.h"

@interface FoilSolver : UIViewController
@property ISolve *is;
@property (weak, nonatomic) IBOutlet UITextField *inputBox;
@property (weak, nonatomic) IBOutlet UIButton *exampleButton;
@property (weak, nonatomic) IBOutlet UIButton *solveButton;
@property (weak, nonatomic) IBOutlet UILabel *answerBox;
@property (strong, nonatomic) IBOutlet Graph *graphArea;


- (NSString*)getStandardFromBinomials:(NSString*)eq;

- (double)getXinString:(NSString*)str;
- (double)getConstantInString:(NSString*)str;
- (NSString*)extractLeftSideInString:(NSString*)str;
- (NSString*)extractRightSideInString:(NSString*)str;;
- (NSString*)getInputData;


@end

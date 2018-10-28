//
//  VertexFocusEquation.h
//  iSolver Pro
//
//  Created by Parker Caputo on 1/27/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FromVertexForm.h"
#import "gPoint.h"
#import "ISolve.h"

@interface VertexFocusEquation : UIViewController

@property FromVertexForm *fvf;
@property ISolve *is;

@property (strong, nonatomic) IBOutlet UITextField *vertexBox;
@property (strong, nonatomic) IBOutlet UITextField *focusBox;
@property (strong, nonatomic) IBOutlet UILabel *answerBox;
@property (strong, nonatomic) IBOutlet UIButton *exampleButton;
@property (strong, nonatomic) IBOutlet UIButton *solveButton;

@property (weak, nonatomic) IBOutlet UIButton *toStandard;
@property (weak, nonatomic) IBOutlet UIButton *toVertex;
@property (weak, nonatomic) IBOutlet UIButton *toConic;



- (gPoint*)getVertex;
- (gPoint*)getFocus;

- (BOOL)determineVerticalWithPoints:(gPoint*)vertex and:(gPoint*)focus;
- (NSString*)writeEquationInConicForm;
- (NSString*)convertToVertexFormWithConic:(NSString*)conic isNormal:(BOOL)isNorm;
- (NSString*)cleanAnswer:(NSString*)ans;





@end

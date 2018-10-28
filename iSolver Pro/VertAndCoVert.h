//
//  VertAndCoVert.h
//  iSolver Pro
//
//  Created by Parker Caputo on 2/19/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISolve.h"
#import "gPoint.h"
#import "Conics.h"

@interface VertAndCoVert : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lineOne;
@property (weak, nonatomic) IBOutlet UILabel *lineTwo;
@property (weak, nonatomic) IBOutlet UILabel *addSign;
@property (weak, nonatomic) IBOutlet UILabel *equalsOne;

@property (weak, nonatomic) IBOutlet UILabel *xBox;
@property (weak, nonatomic) IBOutlet UILabel *yBox;
@property (weak, nonatomic) IBOutlet UILabel *numX;
@property (weak, nonatomic) IBOutlet UILabel *numY;

@property (weak, nonatomic) IBOutlet UITextField *vertOne;
@property (weak, nonatomic) IBOutlet UITextField *vertTwo;
@property (weak, nonatomic) IBOutlet UITextField *coVertOne;
@property (weak, nonatomic) IBOutlet UITextField *coVertTwo;

@property (weak, nonatomic) IBOutlet UIButton *exampleButton;
@property (weak, nonatomic) IBOutlet UIButton *solveButton;

@property ISolve *is;


- (BOOL)validateIsVertAndCoVert;
- (void)hideAnswer;
- (void)showAnswer;



@end

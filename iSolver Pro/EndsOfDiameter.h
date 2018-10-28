//
//  EndsOfDiameter.h
//  iSolver Pro
//
//  Created by Parker Caputo on 2/16/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphConics.h"
#import "ISolve.h"
#import "gPoint.h"

@interface EndsOfDiameter : UIViewController

@property ISolve *is;

@property (weak, nonatomic) IBOutlet UILabel *answerBox;
@property (weak, nonatomic) IBOutlet UITextField *pointOne;
@property (weak, nonatomic) IBOutlet UITextField *pointTwo;
@property (weak, nonatomic) IBOutlet UIButton *exampleButton;
@property (weak, nonatomic) IBOutlet UIButton *solveButton;

@property (strong, nonatomic) IBOutlet GraphConics *graphArea;

- (gPoint*)extractPointsFromText:(NSString*)str;
- (gPoint*)getMidPointFromPoints:(gPoint*)x and:(gPoint*)y;
- (double)getRadiusFromMidPoints:(gPoint*)points andPointOnCircle:(gPoint*)anyPoint;

@end

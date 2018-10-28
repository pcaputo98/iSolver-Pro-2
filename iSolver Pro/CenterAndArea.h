//
//  CenterAndArea.h
//  iSolver Pro
//
//  Created by Parker Caputo on 2/17/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gPoint.h"
#import "GraphConics.h"
#import "EndsOfDiameter.h"
#import "ISolve.h"

@interface CenterAndArea : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *answerBox;
@property (weak, nonatomic) IBOutlet UITextField *centerBox;
@property (weak, nonatomic) IBOutlet UITextField *areaBox;
@property (weak, nonatomic) IBOutlet UIButton *exampleButton;
@property (weak, nonatomic) IBOutlet UIButton *solveButton;
@property (strong, nonatomic) IBOutlet GraphConics *graphArea;
@property ISolve *is;
@property EndsOfDiameter *ed;



- (double)getRadiusWithoutPi:(double)area;

- (double)getOriginalRadius:(NSString*)rad;

- (BOOL)stringHasPi:(NSString*)pi;



@end

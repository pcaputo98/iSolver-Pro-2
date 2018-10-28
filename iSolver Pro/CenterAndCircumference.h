//
//  CenterAndCircumference.h
//  iSolver Pro
//
//  Created by Parker Caputo on 2/18/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphConics.h"
#import "ISolve.h"
#import "EndsOfDiameter.h"
#import "CenterAndArea.h"

@interface CenterAndCircumference : UIViewController

@property ISolve *is;
@property EndsOfDiameter *ed;
@property CenterAndArea *ca;

- (double)getRadiusFromCircumference:(NSString*)str;
- (double)getRadiusWithOutPi:(NSString*)str;

@property (weak, nonatomic) IBOutlet UITextField *centerBox;
@property (weak, nonatomic) IBOutlet UITextField *circumferenceBox;
@property (weak, nonatomic) IBOutlet UIButton *exampleButton;
@property (weak, nonatomic) IBOutlet UIButton *solveButton;
@property (strong, nonatomic) IBOutlet GraphConics *graphArea;
@property (weak, nonatomic) IBOutlet UILabel *answerBox;

@end

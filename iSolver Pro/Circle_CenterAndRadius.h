//
//  Circle_CenterAndRadius.h
//  iSolver Pro
//
//  Created by Parker Caputo on 2/10/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphConics.h"
#import "ISolve.h"
#import "gPoint.h"

@interface Circle_CenterAndRadius : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *centerBox;
@property (weak, nonatomic) IBOutlet UITextField *radius;
@property (weak, nonatomic) IBOutlet UIButton *exampleButton;
@property (weak, nonatomic) IBOutlet UIButton *solveButton;
@property (weak, nonatomic) IBOutlet UILabel *answerBox;
@property (strong, nonatomic) IBOutlet GraphConics *graphArea;
@property ISolve *is;

- (gPoint*)getCenterText:(NSString*)str;
- (double)getRadiusFromText:(NSString*)str;

- (BOOL)validateCenter;
- (BOOL)validateRadius;



@end

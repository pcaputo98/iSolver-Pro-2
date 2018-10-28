//
//  CenterAndPoint.h
//  iSolver Pro
//
//  Created by Parker Caputo on 2/19/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphConics.h"
#import "ISolve.h"

@interface CenterAndPoint : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *answerBox;
@property (weak, nonatomic) IBOutlet UITextField *centerBox;
@property (weak, nonatomic) IBOutlet UITextField *pointBox;
@property (weak, nonatomic) IBOutlet UIButton *exampleButton;
@property (weak, nonatomic) IBOutlet UIButton *solveButton;
@property (strong, nonatomic) IBOutlet GraphConics *graphArea;

@property ISolve *is;



@end

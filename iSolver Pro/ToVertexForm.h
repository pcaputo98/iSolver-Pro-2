//
//  ToVertexForm.h
//  iSolver Pro
//
//  Created by Parker Caputo on 1/25/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StandardQuadSolver.h"
#import "Graph.h"

@interface ToVertexForm : UIViewController {
    StandardQuadSolver *sqs;
}


@property (weak, nonatomic) IBOutlet UILabel *answerBox;
@property (weak, nonatomic) IBOutlet UITextField *inputBox;
@property (weak, nonatomic) IBOutlet UIButton *exampleButton;
@property (weak, nonatomic) IBOutlet UIButton *solveButton;

@property (strong, nonatomic) IBOutlet Graph *graphArea;

- (NSString*)getAnswerWithX:(double)x andY:(double)y andA:(double)a;

- (NSString*)getInputData;

- (double)getXvalueOfVertexWithA:(double)a andB:(double)b;

- (double)getYvalueWithA:(double)a andB:(double)b andC:(double)c andX:(double)x;

@end

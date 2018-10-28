//
//  CalculatorCell.h
//  iSolver Pro
//
//  Created by Parker Caputo on 3/2/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.


#import <UIKit/UIKit.h>

@interface CalculatorCell : UITableViewCell {
    IBOutlet UILabel *equation;
    IBOutlet UILabel *answer;
}

@property UILabel *equation;
@property UILabel *answer;

@end

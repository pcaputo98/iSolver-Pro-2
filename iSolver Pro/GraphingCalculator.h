//
//  GraphingCalculator.h
//  iSolver Pro
//
//  Created by Parker Caputo on 2/22/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MathParser.h"


@interface GraphingCalculator : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    int openParenthesis;
    BOOL radians;
    NSMutableArray *tableData;
}

@property (strong, nonatomic) NSMutableArray *tableData;

@property (weak, nonatomic) IBOutlet UITextField *inputBox;
@property (weak, nonatomic) IBOutlet UITableView *calculatorScreen;
@property (weak, nonatomic) IBOutlet UIButton *enterButton;
@property (weak, nonatomic) IBOutlet UIButton *modeButton;


@property MathParser *mp;

- (void)modifyEnterButton;
- (void)addTextForKey:(NSString*)str;


@end

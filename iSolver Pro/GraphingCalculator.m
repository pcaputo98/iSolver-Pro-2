//
//  GraphingCalculator.m
//  iSolver Pro
//
//  Created by Parker Caputo on 2/22/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "GraphingCalculator.h"
#import "CalculatorCell.h"
#import "CellObject.h"

@interface GraphingCalculator ()

@end

@implementation GraphingCalculator
@synthesize inputBox, calculatorScreen, enterButton, mp, modeButton, tableData;



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CalculatorCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CellObject *co = [[CellObject alloc] init];
    co = [tableData objectAtIndex:[indexPath row]];
    
    [cell.equation setText:co.equation];
    [cell.answer setText:co.answer];
    
    NSLog(@"Equation:%@",cell.equation.text);
    NSLog(@"Answer:%@",cell.answer.text);
    
    return cell;
}


- (void)addTextForKey:(NSString *)str {
    NSString *inputBoxText = [inputBox text];
    inputBox.text = [NSString stringWithFormat:@"%@%@",inputBoxText,str];
}

#pragma numbers

- (IBAction)zero {
    [self addTextForKey:@"0"];
}

- (IBAction)one {
    [self addTextForKey:@"1"];
}

- (IBAction)two {
    [self addTextForKey:@"2"];
}

- (IBAction)three {
    [self addTextForKey:@"3"];
}

- (IBAction)four {
    [self addTextForKey:@"4"];
}

- (IBAction)five {
    [self addTextForKey:@"5"];
}

- (IBAction)six {
    [self addTextForKey:@"6"];
}

- (IBAction)seven {
    [self addTextForKey:@"7"];
}

- (IBAction)eigth {
    [self addTextForKey:@"8"];
}

- (IBAction)nine {
    [self addTextForKey:@"9"];
}

- (IBAction)decimal {
    [self addTextForKey:@"."];
}

- (IBAction)plus {
    [self addTextForKey:@"+"];
}

- (IBAction)minus {
    [self addTextForKey:@"-"];
}

- (IBAction)multiply {
    [self addTextForKey:@"*"];
}

- (IBAction)divide {
    [self addTextForKey:@"/"];
}

- (IBAction)naturalLog {
    [self addTextForKey:@"ln("];
    openParenthesis ++;
    [self performSelector:@selector(modifyEnterButton)];
}

- (IBAction)log {
    [self addTextForKey:@"log("];
    openParenthesis ++;
    [self performSelector:@selector(modifyEnterButton)];
}

- (IBAction)squareRoot {
    [self addTextForKey:@"√("];
    openParenthesis ++;
    [self performSelector:@selector(modifyEnterButton)];
}

#pragma trig buttons

- (IBAction)sine {
    [self addTextForKey:@"sin("];
    openParenthesis ++;
    [self performSelector:@selector(modifyEnterButton)];
}

- (IBAction)arcSine {
    [self addTextForKey:@"arcsin("];
    openParenthesis ++;
    [self performSelector:@selector(modifyEnterButton)];
}

- (IBAction)cosine {
    [self addTextForKey:@"cos("];
    openParenthesis ++;
    [self performSelector:@selector(modifyEnterButton)];
}

- (IBAction)arccos {
    [self addTextForKey:@"arccos("];
    openParenthesis ++;
    [self performSelector:@selector(modifyEnterButton)];
}

- (IBAction)tangent {
    [self addTextForKey:@"tan("];
    openParenthesis ++;
    [self performSelector:@selector(modifyEnterButton)];
}

- (IBAction)arctangent {
    [self addTextForKey:@"arctan("];
    openParenthesis ++;
    [self performSelector:@selector(modifyEnterButton)];
}

- (IBAction)scientificNotation {
    [self addTextForKey:@"E"];
}

- (IBAction)eConstant {
    [self addTextForKey:@"e"];
}


- (IBAction)power {
    [self addTextForKey:@"^"];
}

- (IBAction)pi {
    [self addTextForKey:@"π"];
}



/// Special buttons and methods!

- (IBAction)clearButton {
    
    if (![[inputBox text] isEqual:@""]) {
        
        inputBox.text = @"";
    } else {
        tableData = [[NSMutableArray alloc] init];
        [calculatorScreen reloadData];
    }
    
}


- (IBAction)modeSwitch {
    
    if (radians == YES) {
        [modeButton setTitle:@"Degrees" forState:UIControlStateNormal];
        radians = NO;
    } else {
        [modeButton setTitle:@"Radians" forState:UIControlStateNormal];
        radians = YES;
    }
    
}



- (void)modifyEnterButton {
    
    NSLog(@"Parenthesis count:%i",openParenthesis);
    
    if (openParenthesis != 0) {
        [enterButton setTitle:@")" forState:UIControlStateNormal];
        enterButton.titleLabel.textColor = [UIColor whiteColor];
        enterButton.titleLabel.font = [UIFont fontWithName:@"System" size:15];
        
    } else if (openParenthesis == 0) {
        [enterButton setTitle:@"Enter" forState:UIControlStateNormal];
        enterButton.titleLabel.font = [UIFont fontWithName:@"System" size:13];
    }

}

- (IBAction)enterButtonHit {
    if ([enterButton.titleLabel.text isEqual:@")"]) {
        NSString *inputBoxText = [inputBox text];
        inputBox.text = [NSString stringWithFormat:@"%@)",inputBoxText];
        openParenthesis--;
        [self performSelector:@selector(modifyEnterButton)];
    } else if (openParenthesis == 0) {
        // Submit for parsing
        
        CellObject *co = [[CellObject alloc] init];
        
        NSString *equation = [[NSString alloc] init]; equation = [inputBox text];
        NSString *answer = [[NSString alloc] init];
        NSString *mode = [[NSString alloc] init];
        
        if ([modeButton.titleLabel.text isEqual:@"Degrees"]) {
            mode = @"Degrees";
        } else {
            mode = @"Radians";
        }
        
        mp = [[MathParser alloc] init];
        
        answer = [mp evaluateExpression:equation withMode:mode];
        
        co.equation = equation; co.answer = answer;
        
        NSLog(@"Equation:%@",co.equation); NSLog(@"Answer:%@",co.answer);
        
        [tableData addObject:co]; // Insert new row into data source
        
        [calculatorScreen reloadData];
        
        [calculatorScreen scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[tableData count]-1 inSection:0]
                         atScrollPosition:UITableViewScrollPositionBottom
                                 animated:NO];
        
    }
}

- (IBAction)openParenthesis {
    NSString *inputBoxText = [inputBox text];
    inputBox.text = [NSString stringWithFormat:@"%@(", inputBoxText];
    openParenthesis ++;
    [self performSelector:@selector(modifyEnterButton)];
}

- (IBAction)deleteButton {
    
    NSString *currentText = [inputBox text];
    
    if ([currentText length] > 0) {
        
        NSString *lastChar = [[NSString alloc] init]; lastChar = [currentText substringFromIndex:[currentText length]-1];
        currentText = [currentText substringToIndex:[currentText length] - 1];
        
        if ([lastChar isEqual:@")"]) {
            openParenthesis++;
            [self modifyEnterButton];
        } else if ([lastChar isEqual:@"("]) {
            openParenthesis--;
            [self modifyEnterButton];
        }
        
    }
    
    inputBox.text = currentText;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tableData = [[NSMutableArray alloc] init];
	openParenthesis = 0;
    radians = YES;
    UIView* dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    inputBox.inputView = dummyView;
    self.view.backgroundColor = [UIColor blackColor];
    mp = [[MathParser alloc] init];
    
    calculatorScreen.delegate = self; calculatorScreen.dataSource = self;
    
    NSString *equation = @"20-4(1-(2+2))"; NSLog(@"eq:%@",equation);
    equation = [mp simplifyParenthesis:equation withMode:@"Radians"];
    equation = [mp evaluateExpression:equation withMode:@"Radians"];
    NSLog(@"Final eq:%@",equation);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

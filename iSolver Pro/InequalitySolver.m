//
//  InequalitySolver.m
//  iSolver Pro
//
//  Created by Parker Caputo on 1/20/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "InequalitySolver.h"
#import "ISolve.h"

@interface InequalitySolver ()

@end

@implementation InequalitySolver

@synthesize inputBox, solveButton, exampleButton, answerBox;



-(void)configureKeyboardToolbars

{
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f,
                                                                     
                                                                     self.view.window.frame.size.width, 44.0f)];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        
    {
        
        toolBar.tintColor = [UIColor colorWithRed:0.6f green:0.6f blue:0.64f alpha:1.0f];
        
    }
    
    else
        
    {
        
        toolBar.tintColor = [UIColor colorWithRed:0.56f green:0.59f blue:0.63f alpha:1.0f];
        
    }
    
    toolBar.translucent = NO;
    
    toolBar.items =   @[ [[UIBarButtonItem alloc] initWithTitle:@"x"
                          
                                                          style:UIBarButtonItemStyleBordered
                          
                                                         target:self
                          
                                                         action:@selector(barButtonAddText:)],
                         
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                          
                                                                       target:nil
                          
                                                                       action:nil],
                         
                         
                         
                         [[UIBarButtonItem alloc] initWithTitle:@"+"
                          
                                                          style:UIBarButtonItemStyleBordered
                          
                                                         target:self
                          
                                                         action:@selector(barButtonAddText:)],
                         
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                          
                                                                       target:nil
                          
                                                                       action:nil],
                         
                         [[UIBarButtonItem alloc] initWithTitle:@"-"
                          
                                                          style:UIBarButtonItemStyleBordered
                          
                                                         target:self
                          
                                                         action:@selector(barButtonAddText:)],
                         
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                          
                                                                       target:nil
                          
                                                                       action:nil],
                         
                         [[UIBarButtonItem alloc] initWithTitle:@"<"
                          
                                                          style:UIBarButtonItemStyleBordered
                          
                                                         target:self
                          
                                                         action:@selector(barButtonAddText:)],
                         
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                          
                                                                       target:nil
                          
                                                                       action:nil],
                         [[UIBarButtonItem alloc] initWithTitle:@"<="
                          
                                                          style:UIBarButtonItemStyleBordered
                          
                                                         target:self
                          
                                                         action:@selector(barButtonAddText:)],
                         
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                          
                                                                       target:nil
                          
                                                                       action:nil],
                         [[UIBarButtonItem alloc] initWithTitle:@">"
                          
                                                          style:UIBarButtonItemStyleBordered
                          
                                                         target:self
                          
                                                         action:@selector(barButtonAddText:)],
                         
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                          
                                                                       target:nil
                          
                                                                       action:nil],
                         
                         [[UIBarButtonItem alloc] initWithTitle:@"=>"
                          
                                                          style:UIBarButtonItemStyleBordered
                          
                                                         target:self
                          
                                                         action:@selector(barButtonAddText:) ]];
    
    
    
    self.inputBox.inputAccessoryView = toolBar;
    
    
    
}


-(IBAction)barButtonAddText:(UIBarButtonItem*)sender

{
    
    if (self.inputBox.isFirstResponder)
        
    {
        
        [self.inputBox insertText:sender.title];
        
    }
    
}

- (IBAction)exampleTime:(id)sender {
    inputBox.text = @"3<-5x+2x";
    [self performSelector:@selector(calculateInequality)];
}


- (IBAction)backgroundTouched:(id)sender {
    [self.view endEditing:YES];
}


- (NSString*)getInputData {
    return [inputBox text];
}

- (double)combineConstantTermsInEquation:(NSString *)equation {
    ISolve *is= [[ISolve alloc] init];
    NSArray *constants = [is getMatchesWithPattern:@"(?!x)([\\+|-]?\\d+\\.?\\d*)(?!x)" inString:equation];
    
    double constantTerm = 0;
    
    for (NSTextCheckingResult *txtChk in constants) {
        
        NSString *stringToParse = [equation substringWithRange:[txtChk rangeAtIndex:0]];
        
        double term = [stringToParse doubleValue];
        constantTerm += term;
        
    }
    
    return constantTerm;
}

- (double)combineVariablesInEquation:(NSString *)equation {
    
    ISolve *is = [[ISolve alloc] init];
    NSArray *variables = [is getMatchesWithPattern:@"([\\+|-]?\\d+\\.?\\d*?)?[\\+|-]?[x]" inString:equation];
    double xTerm = 0;
    
    for (NSTextCheckingResult *txtChk in variables) { // Break out all the exponets into pieces (coefficient & exponet)
        
        NSString *stringToParse = [equation substringWithRange:[txtChk rangeAtIndex:0]];
        
        double x = [stringToParse doubleValue];
                
        xTerm = xTerm + x;
        
            
    }
    
    NSArray *loneXterms = [is getMatchesWithPattern:@"([\\+|-]x)" inString:equation];
    
    for (NSTextCheckingResult *txtChck in loneXterms) {
        
        NSString *loneX = [equation substringWithRange:[txtChck rangeAtIndex:0]];
        
        if ([loneX isEqual:@"+x"]) {
            loneX = @"1";
            
        } else if ([loneX isEqual:@"-x"]) {
            loneX = @"-1";
        }
        
        double theLoneXamount = [loneX doubleValue];
        
        xTerm = xTerm + theLoneXamount;
        
    }
    
        return xTerm;
    
}


- (NSString*)getLeftSideOfEquation:(NSString *)equation {
    
    ISolve *is = [[ISolve alloc] init];
    NSString *leftSide = [is getSingleMatchWithPattern:@"(?:(.*)(?:<=|=>|<|>))" inString:equation];
    return leftSide;
}

- (NSString*)getRightSideOfEquation:(NSString *)equation {
    
    ISolve *is = [[ISolve alloc] init];
    NSString *rightSide = [is getSingleMatchWithPattern:@"(?:(?:<=|=>|<|>)(.*))" inString:equation];
    return rightSide;
}

- (NSString*)getSign:(NSString *)inEquality {
    
    ISolve *is = [[ISolve alloc] init];
    NSString *sign = [is getSingleMatchWithPattern:@"(?:(<=|=>|<|>))" inString:inEquality];
    return sign;
}



- (IBAction)calculateInequality {
    
    NSString *equation = [self getInputData];
    NSString *sign = [self getSign:equation];
    
    NSString *leftSide = [[NSString alloc] init];
    leftSide = [self getLeftSideOfEquation:equation];
    NSString *rightSide = [[NSString alloc] init];
    rightSide = [self getRightSideOfEquation:equation];
    
    double xLeft = [self combineVariablesInEquation:leftSide];
    double cLeft = [self combineConstantTermsInEquation:leftSide];
    
    double xRight = [self combineVariablesInEquation:rightSide];
    double cRight = [self combineConstantTermsInEquation:rightSide];
    
    double totalX = xLeft - (xRight);
    double totalConstant = cRight - (cLeft);
    
    double valueOfX = totalConstant / totalX;
    
    if (totalX < 0) {
        
        if ([sign isEqual:@"<"]) {
            sign = @">";
        } else if ([sign isEqual:@">"]) {
            sign = @"<";
        } else if ([sign isEqual:@"<="]) {
            sign = @"=>";
        } else if ([sign isEqual:@"=>"]) {
            sign = @"<=";
        }
    }
    
    NSString *answer = [NSString stringWithFormat:@"x %@ %.3f",sign,valueOfX];
    
    answer = [answer stringByReplacingOccurrencesOfString:@".000"
                                               withString:@""];
    
    answerBox.text = answer;
    
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self configureKeyboardToolbars];
    
    [inputBox becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

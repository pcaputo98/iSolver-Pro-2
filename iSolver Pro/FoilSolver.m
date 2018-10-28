//
//  FoilSolver.m
//  iSolver Pro
//
//  Created by Parker Caputo on 1/22/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "FoilSolver.h"
#import "StandardQuadSolver.h"

@interface FoilSolver ()

@end

@implementation FoilSolver
@synthesize is, exampleButton, solveButton, inputBox, answerBox, graphArea;


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
                         
                         [[UIBarButtonItem alloc] initWithTitle:@"("
                          
                                                          style:UIBarButtonItemStyleBordered
                          
                                                         target:self
                          
                                                         action:@selector(barButtonAddText:)],
                         
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                          
                                                                       target:nil
                          
                                                                       action:nil],
                         
                         [[UIBarButtonItem alloc] initWithTitle:@")"
                          
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

- (IBAction)backgroundTouched:(id)sender {
    [self.view endEditing:YES];
}

- (NSString*)getStandardFromBinomials:(NSString *)eq {
    
    is = [[ISolve alloc] init];
    
    NSString *leftSide = [self extractLeftSideInString:eq];
    NSString *rightSide = [self extractRightSideInString:eq];
    
    double x1 = [self getXinString:leftSide];
    double c1 = [self getConstantInString:leftSide];
    
    double x2 = [self getXinString:rightSide];
    double c2 = [self getConstantInString:rightSide];
    
    double a = x1 * x2;
    double b = (x1 * c2) + (c1 * x2);
    double c = c1 * c2;
    
    
    NSString *standardForm = [NSString stringWithFormat:@"%fx^2+%fx+%f",a,b,c];
    standardForm = [standardForm stringByReplacingOccurrencesOfString:@"+-"
                                               withString:@"-"];
    return standardForm;
}

- (NSString*)getInputData {
    return [inputBox text];
}

- (double)getConstantInString:(NSString *)str {
    is = [[ISolve alloc] init];
    NSString *getConstant = [is getSingleMatchWithPattern:@"(?!\\d+\\.?\\d*)(?!x)([\\+|-]?\\d+\\.?\\d*)(?!\\d+\\.?\\d*)" inString:str];
    return [getConstant doubleValue];
    
}

- (double)getXinString:(NSString *)str {
    is = [[ISolve alloc] init];
    NSString *getX = [is getSingleMatchWithPattern:@"([\\+|-]?\\d+\\.?\\d*?)?[\\+|-]?[x]" inString:str];

    if ([getX isEqual:@"-x"]) {
        getX = @"-1";
    } else if ([getX isEqual:@"+x"] | [getX isEqual:@"x"]) {
        getX = @"1";
    }
    return [getX doubleValue];
}

- (NSString*)extractLeftSideInString:(NSString *)str {
    
    is = [[ISolve alloc] init];
    NSString *leftSide = [is getMatchWithPattern:@"[(](.*)[)][(](.*)[)]" inString:str atIndex:1];
    return leftSide;
}

- (NSString*)extractRightSideInString:(NSString *)str {
    
    is = [[ISolve alloc] init];
    NSString *rightSide = [is getMatchWithPattern:@"[(](.*)[)][(](.*)[)]" inString:str atIndex:2];
    return rightSide;
}


- (IBAction)calculateFoil {
    
    [[graphArea subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)]; // Clear up the memory and reduce lag
    
    NSString *inputData = [[NSString alloc] init];
    inputData = [self getInputData];
    
    double x1 = [self getXinString:[self extractLeftSideInString:inputData]];
    double c1 = [self getConstantInString:[self extractLeftSideInString:inputData]];
    
    double x2 = [self getXinString:[self extractRightSideInString:inputData]];
    double c2 = [self getConstantInString:[self extractRightSideInString:inputData]];
    
    double a = x1 * x2;
    double b = (x1 * c2) + (c1 * x2);
    double c = c1 * c2;
    
    StandardQuadSolver *sq = [[StandardQuadSolver alloc] init];
    NSMutableArray *pointsToGraph = [sq generatePointsWith:a andB:b andC:c];
    [graphArea graphLineWithArray:pointsToGraph];
    [graphArea setNeedsDisplay];
    
    NSString *answer = [NSString stringWithFormat:@"%.3fx^2+%.3fx+%.3f",a,b,c];
    
    answer = [answer stringByReplacingOccurrencesOfString:@"+-"
                                               withString:@"-"];
    
    answer = [answer stringByReplacingOccurrencesOfString:@".000"
                                               withString:@""];
    
    if (abs(a) && abs(b) != 11) {
        answer = [answer stringByReplacingOccurrencesOfString:@"1x"
                                                   withString:@"x"];
    }
    
    answerBox.text = answer;
    
    [inputBox resignFirstResponder];
    
}


- (IBAction)exampleTime:(id)sender {
    inputBox.text = @"(x-3)(x-5)";
    [self performSelector:@selector(calculateFoil)];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
	is = [[ISolve alloc] init];
    
    graphArea = [graphArea initWithFrame:CGRectMake(0, 0, graphArea.graphWidth, graphArea.graphHeight)];
    
    [graphArea setBackgroundColor:[UIColor blackColor]];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // toolbar for default keyboard appearance
    
    [self configureKeyboardToolbars];
    
    [inputBox becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

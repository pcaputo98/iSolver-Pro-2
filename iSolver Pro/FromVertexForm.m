//
//  FromVertexForm.m
//  iSolver Pro
//
//  Created by Parker Caputo on 1/25/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "FromVertexForm.h"

@interface FromVertexForm ()

@end

@implementation FromVertexForm
@synthesize exampleButton, solveButton, inputBox, answerBox, graphArea, sqs, fs, is;

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
                         
                         
                         [[UIBarButtonItem alloc] initWithTitle:@"^2"
                          
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

- (NSString*)getDualBinomial {
    NSString *binomial = [is getMatchWithPattern:@"^(?:([\\+|-]?\\d+\\.?\\d*?|[-])?)([(](?:.*)[)])[\\^][2]([\\+|-]?\\d+\\.?\\d*)?$" inString:[self getInputData] atIndex:2];
    NSString *dualBinomial = [NSString stringWithFormat:@"%@%@",binomial,binomial];
    return dualBinomial;
}

- (NSString*)getStandardFormOfEquationFromVertexForm:(NSString *)eq {
    
    is = [[ISolve alloc] init];
    fs = [[FoilSolver alloc] init];
    
    NSString *leftSide = [is getSingleMatchWithPattern:@"[(](.*)[)]" inString:eq];
    NSString *rightSide = [is getSingleMatchWithPattern:@"[(](.*)[)]" inString:eq];
    
    NSString *getTheA = [is getSingleMatchWithPattern:@"^([\\+|-]?\\d+\\.?\\d*|-)?" inString:eq]; double theA = [getTheA doubleValue]; NSLog(@"THE A:%f",theA);
    
    double x1 = [fs getXinString:leftSide];
    double c1 = [fs getConstantInString:leftSide];
    
    double x2 = [fs getXinString:rightSide];
    double c2 = [fs getConstantInString:rightSide];
    
    double a = (x1 * x2) * theA;
    double b = ((x1 * c2) + (c1 * x2)) * theA;
    double c = ((c1 * c2) * theA);
    
    
    NSString *standardForm = [NSString stringWithFormat:@"%.3fx^2+%.3fx+%.3f",a,b,c];
    
    return standardForm;
}

- (double)getAfromEquation {
    NSString *theA = [is getSingleMatchWithPattern:@"^(?:([\\+|-]?\\d+\\.?\\d*|[-])?)" inString:[self getInputData]];
    if ([theA isEqual:@""] || [theA isEqual:@"+"]) {
        theA = @"1";
    } else if ([theA isEqual:@"-"]) {
        theA = @"-1";
    }
    return [theA doubleValue];
    
}

- (double)getKfromEquation {
    NSString *theK = [is getSingleMatchWithPattern:@"([\\+|-]?\\d+\\.?\\d*)?$" inString:[self getInputData]];
    if ([theK isEqual:@""]) {
        theK = @"0";
    }
    
    NSLog(@"K is:%@",theK);
    return [theK doubleValue];
}

- (NSString*)cleanFinalAnswer:(NSString *)str {
    
    double a = [sqs getA:[self getStandardFormOfEquationFromVertexForm:[self getInputData]]];
    double b = [sqs getB:[self getStandardFormOfEquationFromVertexForm:[self getInputData]]];
    
    str = [str stringByReplacingOccurrencesOfString:@".000"
                                               withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"+-"
                                         withString:@"-"];
    if (a != 11 || b != 11) {
        str = [str stringByReplacingOccurrencesOfString:@"1x"
                                             withString:@"x"];
    }
    
    return str;
}


- (IBAction)calculateFromVertex {
    
    if (![[self getDualBinomial]  isEqual: @""]) {
        
    [[graphArea subviews]
         makeObjectsPerformSelector:@selector(removeFromSuperview)]; // Clear up the memory and reduce lag
    
    NSString *standardForm = [[NSString alloc] init];
        
    standardForm = [fs getStandardFromBinomials:[self getDualBinomial]];
    
    double aToMultiply = [self getAfromEquation];
    double kToAdd = [self getKfromEquation];
    
    double a = [sqs getA:standardForm];
    double b = [sqs getB:standardForm];
    double c = [sqs getC:standardForm];
    
    double realA = (a * aToMultiply);
    double realB = (b * aToMultiply);
    double realC = (c * aToMultiply) + kToAdd;
    
    NSString *quad = [NSString stringWithFormat:@"%.3fx^2+%.3fx+%.3f",realA,realB,realC];
    NSString *answer = [[NSString alloc] init];
    answer = [self cleanFinalAnswer:quad];
    
    answerBox.text = answer;
    
    [graphArea graphLineWithArray:[sqs generatePointsWith:realA andB:realB andC:realC]];
    [graphArea setNeedsDisplay];
    
    [inputBox resignFirstResponder];
    } else {
        
        [[is generateAlertWithMessage:@"Not in vertex form"] show];
    }
    
}


- (IBAction)exampleTime:(id)sender {
    inputBox.text = @"-4(x-8)^2+5";
    [self performSelector:@selector(calculateFromVertex)];
}


- (IBAction)backgroundTouched:(id)sender {
    [inputBox endEditing:YES];
}

- (NSString*)getInputData {
    return [inputBox text];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor blackColor];
    sqs = [[StandardQuadSolver alloc] init];
    fs = [[FoilSolver alloc] init];
    is = [[ISolve alloc] init];
    
    graphArea = [graphArea initWithFrame:CGRectMake(0, 0, graphArea.graphWidth, graphArea.graphHeight)];
    [graphArea setBackgroundColor:[UIColor blackColor]];
    
    [self configureKeyboardToolbars];
    
    [inputBox becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

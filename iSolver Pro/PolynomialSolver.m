//
//  PolynomialSolver.m
//  iSolver Pro
//
//  Created by Parker Caputo on 1/8/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "PolynomialSolver.h"
#import "iExponet.h"
#import "gPoint.h"
#import "Graph.h"


@interface PolynomialSolver ()

@end

@implementation PolynomialSolver
@synthesize inputBox, solveButton, exampleButton, graphArea;


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
                         
                         
                         [[UIBarButtonItem alloc] initWithTitle:@"^"
                          
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
    [inputBox resignFirstResponder];
}

- (IBAction)exampleTime:(id)sender {
    inputBox.text = @"x^5+x^4+x^3+x^2+x";
    [self performSelector:@selector(calculatePolynomial)];
}


- (BOOL)validatePoly:(NSString *)str {
    NSString *pattern = @"(x\\^\\d)";
    NSRegularExpression *run = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:NULL];
    NSTextCheckingResult *match = [run firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
    
    if (match) {
        return TRUE;
    } else {
        return FALSE;
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    graphArea = [graphArea initWithFrame:CGRectMake(0, 0, graphArea.graphWidth, graphArea.graphHeight)];
    
    [graphArea setBackgroundColor:[UIColor blackColor]];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self configureKeyboardToolbars];
    
    [inputBox becomeFirstResponder];}


- (NSString*)getInputData {
    return inputBox.text;
}



- (IBAction)calculatePolynomial {
    
    [[graphArea subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)]; // Clear up the memory and reduce lag
    
    if ([self validatePoly:[self getInputData]] == FALSE) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Not a valid polynomial" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    } else {
    
    NSMutableArray *pointsToGraph = [[NSMutableArray alloc] init];
    pointsToGraph = [self addDegreeOneToArray:[self getExponetsWithEquation:[self getInputData]]];
    
    [graphArea graphLineWithArray:[self generatePointsWithEquation:pointsToGraph]];

    [graphArea setNeedsDisplay];
    [inputBox resignFirstResponder];
    }
}

- (double)caputureConstantInPoly:(NSString *)str {
    
    NSString *pattern = @"(?!x|x^|\\d|[\\+|-]\\d*x)(?!x$)([\\+|-]?\\d+\\.?\\d*)";
    NSRegularExpression *run = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:NULL];
    NSTextCheckingResult *match = [run firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
    
    if (match) {
        NSString *capturedNumber = [str substringWithRange:[match rangeAtIndex:1]];
        return [capturedNumber doubleValue];
    } else {
        return 0;
    }
    
}

- (NSMutableArray*)addDegreeOneToArray:(NSMutableArray *)arry {
    NSMutableArray *refinedExponets = [[NSMutableArray alloc] init];
    refinedExponets = arry;
    
    NSString *str = [[NSString alloc] init];
    str = [self getInputData];
    str = [str stringByReplacingOccurrencesOfString:@"x^"
                                         withString:@"p"];
    NSString *pattern = @"(?:([\\+|-]?\\d+\\.?\\d*|[\\+|-])?[x](?!p$))";
    NSRegularExpression *secondRun = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:NULL];
    NSTextCheckingResult *match = [secondRun firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
    
    
    
    if (!match) {
        
        return refinedExponets;
    } else if (match) {
        NSString *capturedCoefficient = [str substringWithRange:[match rangeAtIndex:1]];
        double theCo = [capturedCoefficient doubleValue];
        
        if ([capturedCoefficient isEqual:@""] | [capturedCoefficient isEqual:@"+"]) {
            theCo = 1;
        } else if ([capturedCoefficient isEqual:@"-"]) {
            theCo = -1;
        }
        
        iExponet *myExpo = [[iExponet alloc] init];
        myExpo.coefficient = theCo;
        myExpo.power = 1;
        NSLog(@"The Co: %f",theCo);
        [refinedExponets addObject:myExpo];
        
    }
    
    
    return refinedExponets;
}

- (NSMutableArray*)getExponetsWithEquation:(NSString *)str {
    
    str = [str stringByReplacingOccurrencesOfString:@"x^"
                                         withString:@"p"];
  
    
    NSString *expPattern = @"(?:[\\A]|([\\+|-]?\\d+\\.?\\d*|[\\+|-])?)[p]([\\+|-]?\\d+\\.?\\d*)";
    NSRegularExpression *expo = [[NSRegularExpression alloc] initWithPattern:expPattern options:0 error:NULL];
    NSArray *occurances = [expo matchesInString:str options:0 range:NSMakeRange(0, [str length])];
    NSMutableArray *exponets = [[NSMutableArray alloc] init];
    

    
    for (NSTextCheckingResult *txtChk in occurances) { // Break out all the exponets into pieces (coefficient & exponet)
        
        NSString *stringToParse = [str substringWithRange:[txtChk rangeAtIndex:0]];
 
        NSString *secondPattern = @"(?:([\\+|-]?\\d+\\.?\\d*|[\\+|-]|[\\^]?))[p]([\\+|-]?\\d+\\.?\\d*)";
        NSRegularExpression *secondRun = [[NSRegularExpression alloc] initWithPattern:secondPattern options:0 error:NULL];
        NSTextCheckingResult *match = [secondRun firstMatchInString:stringToParse options:0 range:NSMakeRange(0, [stringToParse length])];
        
        NSString *capturedCoefficient = [stringToParse substringWithRange:[match rangeAtIndex:1]];
        NSString *exponet = [stringToParse substringWithRange:[match rangeAtIndex:2]];
        
        iExponet *myExpo = [[iExponet alloc] init];
        if ([capturedCoefficient isEqual:@""] | [capturedCoefficient isEqual:@"+"]) { // If its blank...then it's a one
            myExpo.coefficient = 1;
        } else if ([capturedCoefficient isEqual:@"-"]) {
            myExpo.coefficient = -1;
        } else {
        myExpo.coefficient = [capturedCoefficient doubleValue];
        }
        myExpo.power = [exponet doubleValue];
        [exponets addObject:myExpo];
        
    }

    return exponets;
    
}



- (NSMutableArray*)generatePointsWithEquation:(NSMutableArray*)arry { // Assumes array of Exponet objects ;)
    
    NSMutableArray *pointsArray = [[NSMutableArray alloc] init];
    
    
    for (double i = -10; i <= 10; i+= .25) {
        
        double y = 0;
        
        for (iExponet *exp in arry) {
            
            double raised = pow((i), exp.power);
            double coeff = raised * exp.coefficient;
            
            
            y = y + coeff;
            
            
        }
        
        double constant = [self caputureConstantInPoly:[self getInputData]];
       
        y = y + constant;
        
        
        gPoint *point = [[gPoint alloc] init];
        point.x = i;
        point.y = y;
        
       
        
        [pointsArray addObject:point];
        
    }
    
    return pointsArray;
    
    
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
   
}

@end

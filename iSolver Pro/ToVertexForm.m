//
//  ToVertexForm.m
//  iSolver Pro
//
//  Created by Parker Caputo on 1/25/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "ToVertexForm.h"

@interface ToVertexForm ()

@end

@implementation ToVertexForm
@synthesize exampleButton, solveButton, answerBox, graphArea, inputBox;

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


- (NSString*)getAnswerWithX:(double)x andY:(double)y andA:(double)a {
    
    NSString *theAnswer = [[NSString alloc] init];
    
    if (y != 0) {
        theAnswer = [NSString stringWithFormat:@"%.3f(x-%.3f)^2+%.3f",a,x,y];
    } else {
        theAnswer = [NSString stringWithFormat:@"%.3f(x-%.3f)^2",a,x];
    }
    
    theAnswer = [theAnswer stringByReplacingOccurrencesOfString:@".000"
                                                     withString:@""];
    
    theAnswer = [theAnswer stringByReplacingOccurrencesOfString:@"-0"
                                                     withString:@""];
    
    theAnswer = [theAnswer stringByReplacingOccurrencesOfString:@"0"
                                                     withString:@""];
    
    theAnswer = [theAnswer stringByReplacingOccurrencesOfString:@"--"
                                                     withString:@"+"];
    
    theAnswer = [theAnswer stringByReplacingOccurrencesOfString:@"+-"
                                                     withString:@"-"];
    
    theAnswer = [theAnswer stringByReplacingOccurrencesOfString:@"(x-)"
                                                     withString:@"x"];
    
    theAnswer = [theAnswer stringByReplacingOccurrencesOfString:@"(x)"
                                                     withString:@"x"];
    
    if (a != 11 || a != 111 || a != 1111) {
        theAnswer = [theAnswer stringByReplacingOccurrencesOfString:@"1(x"
                                                         withString:@"(x"];
    }
    
    return theAnswer;
    
}

- (NSString*)getInputData {
    return [inputBox text];
}

- (double)getXvalueOfVertexWithA:(double)a andB:(double)b {
    double Xvertex = -(b)/(2*a);
    return Xvertex;
}

- (double)getYvalueWithA:(double)a andB:(double)b andC:(double)c andX:(double)x {
    double yValue = (a*(x*x)) + (b*x) + c;
    return yValue;
    
}
- (IBAction)backgroundTouched:(id)sender {
    [self.view endEditing:YES];
}


- (IBAction)exampleTime:(id)sender {
    inputBox.text = @"x^2+10x+33";
    [self performSelector:@selector(calculateToVertex)];
}


- (IBAction)calculateToVertex {
    
    [[graphArea subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)]; // Clear up the memory and reduce lag
    
    double a = [sqs getA:[self getInputData]];
    double b = [sqs getB:[self getInputData]];
    double c = [sqs getC:[self getInputData]];
    
    double xVertex = [self getXvalueOfVertexWithA:a andB:b];
    double yVertex = [self getYvalueWithA:a andB:b andC:c andX:xVertex];
    
    NSString *answer = [[NSString alloc] init];
    answer = [self getAnswerWithX:xVertex andY:yVertex andA:a];
    answerBox.text = answer;
    
    
    [graphArea graphLineWithArray:[sqs generatePointsWith:a andB:b andC:c]];
    [graphArea setNeedsDisplay];
    
    [inputBox resignFirstResponder];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	sqs = [[StandardQuadSolver alloc] init];
    
    graphArea = [graphArea initWithFrame:CGRectMake(0, 0, graphArea.graphWidth, graphArea.graphHeight)];
    
    [graphArea setBackgroundColor:[UIColor blackColor]];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self configureKeyboardToolbars];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  Circle_CenterAndRadius.m
//  iSolver Pro
//
//  Created by Parker Caputo on 2/10/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "Circle_CenterAndRadius.h"

@interface Circle_CenterAndRadius ()

@end

@implementation Circle_CenterAndRadius
@synthesize centerBox, radius, exampleButton, solveButton, answerBox, graphArea, is;

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
    
    toolBar.items =   @[ [[UIBarButtonItem alloc] initWithTitle:@"/"
                          
                                                          style:UIBarButtonItemStyleBordered
                          
                                                         target:self
                          
                                                         action:@selector(barButtonAddText:)],
                         
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                          
                                                                       target:nil
                          
                                                                       action:nil],
                         [[UIBarButtonItem alloc] initWithTitle:@"√"
                          
                                                          style:UIBarButtonItemStyleBordered
                          
                                                         target:self
                          
                                                         action:@selector(barButtonAddText:)],
                         
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                          
                                                                       target:nil
                          
                                                                       action:nil],
                         
                         [[UIBarButtonItem alloc] initWithTitle:@","
                          
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
    
    
    
    self.centerBox.inputAccessoryView = toolBar;
    self.radius.inputAccessoryView = toolBar;
    
    
}

-(IBAction)barButtonAddText:(UIBarButtonItem*)sender

{
    
    if (self.radius.isFirstResponder)
        
    {
        
        [self.radius insertText:sender.title];
        
    }
    
    if (self.centerBox.isFirstResponder)
        
    {
        
        [self.centerBox insertText:sender.title];
        
    }
    
    
    
}

- (IBAction)backgroundTouched:(id)sender {
    [self.view endEditing:YES];
}


- (gPoint*)getCenterText:(NSString *)str {
    
    gPoint *g = [[gPoint alloc] init];
    NSString *capturedX = [is getMatchWithPattern:@"[(]?(.*)[,](.*)[)]?" inString:[centerBox text] atIndex:1];
    NSString *capturedY = [is getMatchWithPattern:@"[(]?(.*)[,](.*)[)]?" inString:[centerBox text] atIndex:2];
    
    double capX = 0; double capY = 0;
    
    capturedX = [is scanAndConvertFraction:capturedX]; capturedY = [is scanAndConvertFraction:capturedY];
    capX = [capturedX doubleValue]; capY = [capturedY doubleValue];
    
    g.x = capX * -1;
    g.y = capY * -1;
    
    return g;
    
}

- (double)getRadiusFromText:(NSString *)str {
    
    if ([str rangeOfString:@"√"].location == NSNotFound) {
        str = [is scanAndConvertFraction:str];
        return [str doubleValue] * [str doubleValue];
    } else {
    
    str = [str stringByReplacingOccurrencesOfString:@"√"
                                         withString:@""];
    str = [is scanAndConvertFraction:str];
        return [str doubleValue];
    }
    
    return [str doubleValue];
    
}

- (IBAction)calculateCircleCenterRadius {
    
    [[graphArea subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)]; // Clear up the memory and reduce lag
    
    double rad = [self getRadiusFromText:[radius text]];
    gPoint *xy = [self getCenterText:[centerBox text]];
    
    NSString *answer = [NSString stringWithFormat:@"(x+%.3f)^2 + (y+%.3f)^2 = %.3f",xy.x,xy.y,rad];
    answer = [answer stringByReplacingOccurrencesOfString:@".000"
                                         withString:@""];
    answer = [answer stringByReplacingOccurrencesOfString:@"+-"
                                         withString:@"-"];
    answer = [answer stringByReplacingOccurrencesOfString:@"+0"
                                               withString:@""];
    answer = [answer stringByReplacingOccurrencesOfString:@"-0"
                                               withString:@""];
    answerBox.text = answer;
    
    xy.x = xy.x * -1; xy.y = xy.y * -1;
    [graphArea requestCircleWithCenter:xy andRadius:sqrt(rad)];
    [graphArea setNeedsDisplay];
    
    [self.view endEditing:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    is = [[ISolve alloc] init];
    
    [self configureKeyboardToolbars];
     self.view.backgroundColor = [UIColor blackColor];

    [centerBox becomeFirstResponder];
    
    graphArea = [graphArea initWithFrame:CGRectMake(0, 0, graphArea.graphWidth, graphArea.graphHeight)];
    
    [graphArea setBackgroundColor:[UIColor blackColor]];
    
    
	
}

- (IBAction)exampleTime:(id)sender {
    centerBox.text = @"(0,3)";
    radius.text = @"3";
    [self performSelector:@selector(calculateCircleCenterRadius)];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

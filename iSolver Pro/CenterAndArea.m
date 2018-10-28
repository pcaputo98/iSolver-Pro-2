//
//  CenterAndArea.m
//  iSolver Pro
//
//  Created by Parker Caputo on 2/17/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "CenterAndArea.h"

@interface CenterAndArea ()

@end

@implementation CenterAndArea

@synthesize answerBox, centerBox, areaBox, exampleButton, solveButton, graphArea, is, ed;

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
                         [[UIBarButtonItem alloc] initWithTitle:@"π"
                          
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
    self.areaBox.inputAccessoryView = toolBar;
    
    
}

-(IBAction)barButtonAddText:(UIBarButtonItem*)sender

{
    
    if (self.centerBox.isFirstResponder)
        
    {
        
        [self.centerBox insertText:sender.title];
        
    }
    
    if (self.areaBox.isFirstResponder)
        
    {
        
        [self.areaBox insertText:sender.title];
        
    }
    
    
    
}

- (IBAction)backgroundTouched:(id)sender {
    [self.view endEditing:YES];
}


- (BOOL)stringHasPi:(NSString*)pi {
    is = [[ISolve alloc] init];
    NSString *doesPiExist = [is getSingleMatchWithPattern:@"(π)" inString:pi];
    
    if ([doesPiExist isEqual:@"π"]) {
        return TRUE;
    } else {
        return FALSE;
    }
}

- (double)getRadiusWithoutPi:(double)area {
    double radius = area / M_PI;
    return radius;
}

- (double)getOriginalRadius:(NSString *)rad {
    
    rad = [rad stringByReplacingOccurrencesOfString:@"π"
                                               withString:@""];
    double radius = [rad doubleValue];
    return radius;
    
}

- (IBAction)exampleTime:(id)sender {
    centerBox.text = @"-11,-14";
    areaBox.text = @"16π";
    [self performSelector:@selector(calculateCenterAndArea)];
}


- (IBAction)calculateCenterAndArea {
    
    double radiusFinal;
    
    if ([self stringHasPi:[areaBox text]] == TRUE) {
        radiusFinal = [self getOriginalRadius:[areaBox text]];
    } else {
        radiusFinal = [self getRadiusWithoutPi:[self getOriginalRadius:[areaBox text]]];
    }
    
    gPoint *center = [ed extractPointsFromText:[centerBox text]];
    
    NSString *answer = [NSString stringWithFormat:@"(x+%.3f)^2 + (y+%.3f)^2 = %.3f",center.x *-1,center.y*-1,radiusFinal];
    answer = [answer stringByReplacingOccurrencesOfString:@".000"
                                               withString:@""];
    answer = [answer stringByReplacingOccurrencesOfString:@"+-"
                                               withString:@"-"];
    answer = [answer stringByReplacingOccurrencesOfString:@"+0"
                                               withString:@""];
    answer = [answer stringByReplacingOccurrencesOfString:@"-0"
                                               withString:@""];
    
    answerBox.text = answer;
    
    [graphArea requestCircleWithCenter:center andRadius:sqrt(radiusFinal)];
    [graphArea setNeedsDisplay];
    
    [self.view endEditing:YES];
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    is = [[ISolve alloc] init];
    ed = [[EndsOfDiameter alloc] init];
    
    [self configureKeyboardToolbars];
    
	self.view.backgroundColor = [UIColor blackColor];
    
    [centerBox becomeFirstResponder];
    
    graphArea = [graphArea initWithFrame:CGRectMake(0, 0, graphArea.graphWidth, graphArea.graphHeight)];
    
    [graphArea setBackgroundColor:[UIColor blackColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

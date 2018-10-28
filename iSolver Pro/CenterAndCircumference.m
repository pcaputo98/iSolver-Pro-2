//
//  CenterAndCircumference.m
//  iSolver Pro
//
//  Created by Parker Caputo on 2/18/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "CenterAndCircumference.h"

@interface CenterAndCircumference ()

@end

@implementation CenterAndCircumference

@synthesize answerBox, exampleButton, centerBox, solveButton, graphArea, is, ed, ca, circumferenceBox;

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
    self.circumferenceBox.inputAccessoryView = toolBar;
    
    
}

-(IBAction)barButtonAddText:(UIBarButtonItem*)sender

{
    
    if (self.centerBox.isFirstResponder)
        
    {
        
        [self.centerBox insertText:sender.title];
        
    }
    
    if (self.circumferenceBox.isFirstResponder)
        
    {
        
        [self.circumferenceBox insertText:sender.title];
        
    }
    
    
    
}

- (IBAction)backgroundTouched:(id)sender {
    [self.view endEditing:YES];
}

- (double)getRadiusFromCircumference:(NSString *)str {
    
    double radius = [ca getOriginalRadius:[circumferenceBox text]];
    
    NSLog(@"Rad cir:%.3f",radius);
    return radius / 2;
}

- (double)getRadiusWithOutPi:(NSString *)str {
    
    double radius = [ca getOriginalRadius:[circumferenceBox text]];
    
    return radius / (2 * M_1_PI);
    
}

- (IBAction)calculateCenterCircumference {
    
    double radius;
    
    if ([ca stringHasPi:[circumferenceBox text]] == TRUE) {
        
        radius = [self getRadiusFromCircumference:[circumferenceBox text]];
        
    } else {
        radius = [self getRadiusWithOutPi:[circumferenceBox text]];
    }
    
    gPoint *center = [ed extractPointsFromText:[centerBox text]];
    
    NSString *answer = [NSString stringWithFormat:@"(x+%.3f)^2 + (y+%.3f)^2 = %.3f",center.x *-1,center.y*-1,radius*radius];
    answer = [answer stringByReplacingOccurrencesOfString:@".000"
                                               withString:@""];
    answer = [answer stringByReplacingOccurrencesOfString:@"+-"
                                               withString:@"-"];
    answer = [answer stringByReplacingOccurrencesOfString:@"+0"
                                               withString:@""];
    answer = [answer stringByReplacingOccurrencesOfString:@"-0"
                                               withString:@""];
    
    answerBox.text = answer;
    
    [graphArea requestCircleWithCenter:center andRadius:radius];
    [graphArea setNeedsDisplay];
    
}


- (IBAction)exampleTime:(id)sender {
    centerBox.text = @"-5,12";
    circumferenceBox.text = @"8π";
    [self performSelector:@selector(calculateCenterCircumference)];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
	is = [[ISolve alloc] init];
    ed = [[EndsOfDiameter alloc] init];
    ca = [[CenterAndArea alloc] init];
    
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

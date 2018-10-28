//
//  VertAndCoVert.m
//  iSolver Pro
//
//  Created by Parker Caputo on 2/19/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "VertAndCoVert.h"

@interface VertAndCoVert ()

@end

@implementation VertAndCoVert

@synthesize lineOne, lineTwo, addSign, equalsOne, xBox, yBox, numX, numY;
@synthesize vertOne, vertTwo, coVertOne, coVertTwo, exampleButton, solveButton, is;


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
    
    
    
    self.vertOne.inputAccessoryView = toolBar;
    self.vertTwo.inputAccessoryView = toolBar;
    self.coVertOne.inputAccessoryView = toolBar;
    self.coVertTwo.inputAccessoryView = toolBar;
    
    
}

-(IBAction)barButtonAddText:(UIBarButtonItem*)sender

{    // Vertices
    
    if (self.vertOne.isFirstResponder)
        
    {
        
        [self.vertOne insertText:sender.title];
        
    }
    
    if (self.vertTwo.isFirstResponder)
        
    {
        
        [self.vertTwo insertText:sender.title];
        
    }
    
    // Co Vertices
    
    if (self.coVertOne.isFirstResponder)
        
    {
        
        [self.coVertOne insertText:sender.title];
        
    }
    
    if (self.coVertTwo.isFirstResponder)
        
    {
        
        [self.coVertTwo insertText:sender.title];
        
    }
    
    
    
}


- (void)showAnswer {
    lineOne.hidden = FALSE; lineTwo.hidden = FALSE; addSign.hidden = FALSE; equalsOne.hidden = FALSE;
    xBox.hidden = FALSE; yBox.hidden = FALSE; numX.hidden = FALSE; numY.hidden = FALSE;
}

- (void)hideAnswer {
    lineOne.hidden = TRUE; lineTwo.hidden = TRUE; addSign.hidden = TRUE; equalsOne.hidden = TRUE;
    xBox.hidden = TRUE; yBox.hidden = TRUE; numX.hidden = TRUE; numY.hidden = TRUE;
}

- (BOOL)validateIsVertAndCoVert {
    
    gPoint *v1 = [is getCoordinatesFromString:[vertOne text]];
    gPoint *v2 = [is getCoordinatesFromString:[vertTwo text]];
    gPoint *cv1 = [is getCoordinatesFromString:[coVertOne text]];
    gPoint *cv2 = [is getCoordinatesFromString:[coVertTwo text]];
    
    if ( ((v1.x == 0 && v2.x == 0) || (v1.y == 0 && v2.y == 0)) && ((cv1.x == 0 && cv2.x == 0) || (cv1.y == 0 && cv2.y == 0))) {
        return TRUE;
    } else {
        return FALSE;
    }
    
}

- (IBAction)exampleTime:(id)sender {
    vertOne.text = @"10,0"; vertTwo.text = @"-10,0";
    coVertOne.text = @"0,9"; coVertTwo.text = @"0,-9";
    [self performSelector:@selector(calculateVertAndCoVert)];
}


- (IBAction)calculateVertAndCoVert {
    
    if ([self validateIsVertAndCoVert] == TRUE) {
    
    Conics *cs = [[Conics alloc] init];
    
    gPoint *vertPointOne = [is getCoordinatesFromString:[vertOne text]];
    gPoint *coVertPointOne = [is getCoordinatesFromString:[coVertOne text]];
    
    double underX; double underY;
    
    if ([cs majorOnXaxiswithVert:vertPointOne andCoVert:coVertPointOne] == TRUE) {
        
        underX = vertPointOne.x * vertPointOne.x;
        underY = coVertPointOne.y * coVertPointOne.y;
    } else {
        
        underX = coVertPointOne.x * coVertPointOne.x;
        underY = vertPointOne.y * vertPointOne.y;
    }
    
    xBox.text = @"x^2"; yBox.text = @"y^2";
    numX.text = [NSString stringWithFormat:@"%.3f",underX];
    numY.text = [NSString stringWithFormat:@"%.3f",underY];
    [self showAnswer];
    } else {
        [[is generateAlertWithMessage:@"Ellipse must be centered at 0,0"] show];
    }
    
    
    
    
}



- (IBAction)backgroundTouched:(id)sender {
    [self.view endEditing:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	is = [[ISolve alloc] init];
    
    [self hideAnswer];
    [self configureKeyboardToolbars];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [vertOne becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  VertAndFoci.m
//  iSolver Pro
//
//  Created by Parker Caputo on 2/19/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "VertAndFoci.h"

@interface VertAndFoci ()

@end

@implementation VertAndFoci
@synthesize lineOne, lineTwo, addSign, equalsOne, xBox, yBox, numX, numY, solveButton, exampleButton, is, vertOne, vertTwo, fociOne, fociTwo;


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
    self.fociOne.inputAccessoryView = toolBar;
    self.fociTwo.inputAccessoryView = toolBar;
    
    
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
    
    if (self.fociOne.isFirstResponder)
        
    {
        
        [self.fociOne insertText:sender.title];
        
    }
    
    if (self.fociTwo.isFirstResponder)
        
    {
        
        [self.fociTwo insertText:sender.title];
        
    }
    
    
    
}

- (IBAction)backgroundTouched:(id)sender {
    [self.view endEditing:YES];
}


- (IBAction)calculateVertFoci {
    
    
    
    
}

- (IBAction)exampleButton:(id)sender {
}

- (void)showAnswer {
    lineOne.hidden = FALSE; lineTwo.hidden = FALSE; addSign.hidden = FALSE; equalsOne.hidden = FALSE;
    xBox.hidden = FALSE; yBox.hidden = FALSE; numX.hidden = FALSE; numY.hidden = FALSE;
}

- (void)hideAnswer {
    lineOne.hidden = TRUE; lineTwo.hidden = TRUE; addSign.hidden = TRUE; equalsOne.hidden = TRUE;
    xBox.hidden = TRUE; yBox.hidden = TRUE; numX.hidden = TRUE; numY.hidden = TRUE;
}



- (void)viewDidLoad
{
    [super viewDidLoad]
    ;
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

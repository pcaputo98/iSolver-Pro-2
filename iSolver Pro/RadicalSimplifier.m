//
//  RadicalSimplifier.m
//  iSolver Pro
//
//  Created by Parker Caputo on 1/22/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "RadicalSimplifier.h"
#import "ISolve.h"

@interface RadicalSimplifier ()

@end

@implementation RadicalSimplifier
@synthesize is, inputBox, answerBox, solveButton, exampleButton;



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
    
    toolBar.items =   @[ [[UIBarButtonItem alloc] initWithTitle:@"√"
                          
                                                          style:UIBarButtonItemStyleBordered
                          
                                                         target:self
                          
                                                         action:@selector(barButtonAddText:)],
                         
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                          
                                                                       target:nil
                          
                                                                       action:nil],
                         
                         
                         
                         [[UIBarButtonItem alloc] initWithTitle:@""
                          
                                                          style:UIBarButtonItemStyleBordered
                          
                                                         target:self
                          
                                                         action:@selector(barButtonAddText:) ]];
    
    
    
    self.inputBox.inputAccessoryView = toolBar;
    
    
    
}

- (IBAction)exampleTime:(id)sender {
    inputBox.text = @"√80";
    [self performSelector:@selector(calculateRadical)];
}


-(IBAction)barButtonAddText:(UIBarButtonItem*)sender

{
    
    if (self.inputBox.isFirstResponder)
        
    {
        
        [self.inputBox insertText:sender.title];
        
    }
    
}

- (int)findPerfectSquareInNumber:(int)num {
    
    int i = 2;
    int largestPerfect = 0;
    
    while (i < num) {
        NSLog(@"%i",i);
        if (num % (i * i) == 0) {
            largestPerfect = i * i;
        }
        
        i++;
        
    }
    return largestPerfect;
}

- (BOOL)validateRadicalInString:(NSString *)str {
    
    NSString *radical = [is getSingleMatchWithPattern:@"(√)" inString:str];
    NSLog(@"Radical:%@",radical);
    if (![radical  isEqual: @""]) {
        return TRUE;
    } else {
        return FALSE;
    }
}

- (int)getNumber {
    
    NSString *str = [[self getInputData] stringByReplacingOccurrencesOfString:@"√"
                                         withString:@""];
    return [str doubleValue];
}

- (NSString*)getInputData {
    return [inputBox text];
}

- (IBAction)calculateRadical {
    
    if ([self validateRadicalInString:[self getInputData]] == FALSE) {
        
        [[is generateAlertWithMessage:@"Not a valid radical"] show];
        
    } else { // Continue calculating
        
        NSString *theAnswer = [[NSString alloc] init];
        int theNumber = [self getNumber];
        int perfectSquare = [self findPerfectSquareInNumber:[self getNumber]];
        
        int otherNumber = theNumber / perfectSquare;
        double sqrtOfNum = (sqrt(otherNumber));
        
        if (fmod(sqrtOfNum, 1) == 0) {
            int ans = (int)(sqrt(perfectSquare) * sqrtOfNum);
            theAnswer = [NSString stringWithFormat:@"%i",ans];
        } else {
            int ans = (int)sqrt(perfectSquare);
            theAnswer = [NSString stringWithFormat:@"%i√%i",ans,otherNumber];
        }
        
        if ([theAnswer isEqual:@"0"]) {
            theAnswer = [NSString stringWithFormat:@"Cannot reduce"];
        }
        
        answerBox.text = theAnswer;
        
    }
    
}


- (IBAction)backgroundTouched:(id)sender {
    [self.view endEditing:YES];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.view.backgroundColor = [UIColor blackColor];
    
    [self configureKeyboardToolbars];
    
    [inputBox becomeFirstResponder];
    
    is = [[ISolve alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

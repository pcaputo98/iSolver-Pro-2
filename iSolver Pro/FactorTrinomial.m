//
//  FactorTrinomial.m
//  iSolver Pro
//
//  Created by Parker Caputo on 1/23/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "FactorTrinomial.h"


@interface FactorTrinomial ()

@end

@implementation FactorTrinomial
@synthesize qs, answerBox, exampleButton, inputBox, solveButton, is;


- (NSString*)getInputData {
    return [inputBox text];
}

- (IBAction)exampleTime:(id)sender {
    inputBox.text = @"x^2-5x+6";
    [self performSelector:@selector(calculateFactorTrinomial)];
}


- (IBAction)backgroundTouched:(id)sender {
    [self.view endEditing:YES];
}


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

- (int)getGreatestCommonFactorWith:(int)f1 and:(int)f2 {
    
    int i = 1;
    int greatestFactor = 1;
    
    while (i <= f1 && i <=f2) {
        
        if (f1 % i == 0 && f2 % i == 0) {
            greatestFactor = i;
        }
        i++;
    }
    return greatestFactor;
    
}


- (FactorObject*)findFactorsOf:(int)num1 thatAddToBe:(int)num2 andMultiplyToBe:(int)num3 {
    
    FactorObject *obj = [[FactorObject alloc] init];

    int i = 1;
    
    while (i<=abs(num1)) {

        if (abs(num1) % i == 0) {
            
            int x = num1 / i;
            
            if (x + i == num2) {
                if (x * i == num3) {
                    obj.factor1 = i; obj.factor2 = x;
                    return obj;
                }
            } else if (i - x == num2) {
                if (-x * i == num3) {
                    obj.factor1 = i; obj.factor2 = -x;
                    return obj;
                }
            } else if (-x - i == num2) {
                if (-x * -i == num3) {
                    obj.factor1 = -i; obj.factor2 = -x;
                    return obj;
                }
            } else if (x - i == num2) {
                if (x * - i == num3) {
                    obj.factor1 = - i; obj.factor2 = x;
                    return obj;
                }
            }
            
        }
        i++;
    }
    
    return nil;
}

- (IBAction)calculateFactorTrinomial {
    
    
    if ([qs regexValidateQuadraticWithString:[self getInputData]] == FALSE) {
        
        [[is generateAlertWithMessage:@"Not a quadratic!"] show];
        
    } else {
        
        int a = [qs getA:[self getInputData]];
        int b = [qs getB:[self getInputData]];
        int c = [qs getC:[self getInputData]];

        
        FactorObject *realFactors = [[FactorObject alloc] init];
        realFactors = [self findFactorsOf:(a*c) thatAddToBe:b andMultiplyToBe:(a*c)];
        
        double realFactor1 = realFactors.factor1; double realFactor2 = realFactors.factor2;
        
        
        int fac1 = [self getGreatestCommonFactorWith:abs(a) and:abs(realFactor2)];
        if (a < 0) {fac1 = fac1 * -1;};
        int fac2 = [self getGreatestCommonFactorWith:abs(realFactor1) and:abs(c)];
        if (realFactor1 < 0) {fac2 = fac2 * -1;};
        int fac3 = [self getGreatestCommonFactorWith:abs(a) and:abs(realFactor1)];
        if (a < 0) {fac3 = fac3 * -1;};
        int fac4 = [self getGreatestCommonFactorWith:abs(realFactor2) and:abs(c)];
        if (realFactor2 < 0) {fac4 = fac4 * -1;};
        
        NSString *answer = [NSString stringWithFormat:@"(%ix+%i)(%ix+%i)",fac1,fac2,fac3,fac4];
        
        if (abs(fac1) && abs(fac3) != 11) {
        answer = [answer stringByReplacingOccurrencesOfString:@"1x"
                                             withString:@"x"];
        }
        
        answer = [answer stringByReplacingOccurrencesOfString:@"+-"
                                                   withString:@"-"];
        
        answerBox.text = answer;
        
    }
    
    
    
}


-(IBAction)barButtonAddText:(UIBarButtonItem*)sender

{
    
    if (self.inputBox.isFirstResponder)
        
    {
        
        [self.inputBox insertText:sender.title];
        
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    qs = [[StandardQuadSolver alloc] init];
    is = [[ISolve alloc] init];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self configureKeyboardToolbars];
    
    [inputBox becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

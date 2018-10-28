//
//  StandardQuadSolver.m
//  iSolver Pro
//
//  Code adapter from original iSolver
//  Created by Parker Caputo on 11/20/14.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "StandardQuadSolver.h"

#import "gPoint.h"

#import <math.h>

#import <CoreGraphics/CoreGraphics.h>



@interface StandardQuadSolver ()



@end



@implementation StandardQuadSolver

@synthesize  inputBox, solveButton, answerBox, graphArea;


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



- (void)viewDidLoad

{
    
    [super viewDidLoad];
    
    graphArea = [graphArea initWithFrame:CGRectMake(0, 0, graphArea.graphWidth, graphArea.graphHeight)];
    
    [graphArea setBackgroundColor:[UIColor blackColor]];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // toolbar for default keyboard appearance
    
    [self configureKeyboardToolbars];
    
    [inputBox becomeFirstResponder];
    
    
}





-(IBAction)barButtonAddText:(UIBarButtonItem*)sender

{
    
    if (self.inputBox.isFirstResponder)
        
    {
        
        [self.inputBox insertText:sender.title];
        
    }
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return NO;
    
}

// Keep that keyboard from getting in the way

- (IBAction)backgroundTouched:(id)sender {
    [self.view endEditing:YES];
}



- (IBAction)showExample:(id)sender {
    inputBox.text = @"x^2+3x+2";
    [self performSelector:@selector(calculateQuadratic)];
}


- (NSString*)getInputData {
    return inputBox.text;
}



- (IBAction)calculateQuadratic {
    
    [[graphArea subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)]; // Clear up the memory and reduce lag
    
    NSString *quadratic = [self getInputData];
    
    if ([self doubleSignDetection:quadratic] == true) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Double sign detected" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    } else if ([self regexValidateQuadraticWithString:quadratic] == false) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Not a quadratic" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else { // Countine to calculate
        
        NSLog(@"Keep going");
        
        double a = [self getA:quadratic];
        double b = [self getB:quadratic];
        double c = [self getC:quadratic];
        
        NSLog(@"A:%f B:%f C:%f",a,b,c);
        
        double x1;
        double x2;
        
        if (b == 0) {
         double x1Pre = sqrt(-4*a*c);
            x1 = x1Pre / (2*a);
            x2 = -x1;
            NSLog(@"X1:%f",x1);
        } else {
            NSLog(@"Normal way");
        x1 = ( (-b + sqrt((b * b) - 4*a*c))) / (2*a);
        
        x2 = ( (-b - sqrt((b * b) - 4*a*c))) / (2*a);
        
        }
        
        if (isnan(x1) && isnan(x2)) {
            
            NSLog(@"Or not");
            
            answerBox.text = [NSString stringWithFormat:@"No solution"];
            
        } else {
            
            NSLog(@"Show the answer");
            
            NSString *answer = [NSString stringWithFormat:@"X = %.3f, %.3f",x1,x2];
            
            answer = [answer stringByReplacingOccurrencesOfString:@".000"
                                                       withString:@""];
            answer = [answer stringByReplacingOccurrencesOfString:@"-0"
                                                       withString:@"0"];
            
            answerBox.text = answer;
        
        [graphArea graphLineWithArray:[self generatePointsWith:a andB:b andC:c]];
        
        [graphArea setNeedsDisplay];
            
        }
    
        [inputBox resignFirstResponder];
        
        
    
    
    }
}

- (double)getA:(NSString *)quad {
    
      NSString *patternA = @"^[(]?([-]?[\\d+\\.?\\d*]?[\\d+\\.?\\d*]?[\\d+\\.?\\d*]?[\\d+\\.?\\d*]?)[x][\\^][2]";
    
      NSRegularExpression *regexA = [[NSRegularExpression alloc] initWithPattern:patternA options:0 error:NULL];
      NSTextCheckingResult *matchA = [regexA firstMatchInString:quad options:0 range:NSMakeRange(0, [quad length])];
    
      NSString *checkA = [quad substringWithRange:[matchA rangeAtIndex:1]];
    
    NSLog(@"A is %@",checkA);
      if ([checkA isEqual:@"-"]) {
          
          return [@"-1" doubleValue];
          
      } else if ([checkA isEqual:@""]) {
          
          return [@"1" doubleValue];
          
      }
    
      else {
          
          return [checkA doubleValue];
          
      }
    
    
}

- (double)getB:(NSString *)quad {
    
    NSString *patternB = @"[\\+|-]?[x^2](?:([\\+|-]\\d+\\.?\\d*|\\+|-)x)";
    
    NSRegularExpression *regexB = [[NSRegularExpression alloc] initWithPattern:patternB options:0 error:NULL];
    NSTextCheckingResult *matchB = [regexB firstMatchInString:quad options:0 range:NSMakeRange(0, [quad length])];
    
    NSString *checkBvalue = [quad substringWithRange:[matchB rangeAtIndex:1]];
    
    NSLog(@"B is %@",checkBvalue);
    
    if ([checkBvalue isEqual:@"+"]) {
        return 1;
    } else if ([checkBvalue isEqual:@"-"]) {
        return -1;
    }
    else if (![checkBvalue isEqual:@""]) {
        
        return [checkBvalue doubleValue];
        
    } else return 0;
    
}

- (double)getC:(NSString *)quad {
    
    NSString *patternC = @"(\\+|-)(\\d+\\.?\\d*)?[)]?$";
    
    NSRegularExpression *regexC = [[NSRegularExpression alloc] initWithPattern:patternC options:0 error:NULL];
    NSTextCheckingResult *matchC = [regexC firstMatchInString:quad options:0 range:NSMakeRange(0, [quad length])];
    
    NSString *checkCvalue = [quad substringWithRange:[matchC rangeAtIndex:0]];
    
    NSLog(@"C is %@",checkCvalue);

    
    if ([checkCvalue isEqual:@""]) {
        
        return [@"0" doubleValue];
        
    }  else if (![checkCvalue isEqual:@""]) {
        
        return [checkCvalue doubleValue];
        
    }
    else return 0;
}


- (BOOL)doubleSignDetection:(NSString *)quad {
    // Check for double signs
    NSString *dsc = @"[^[0-9][x][\\^]]{2,}";
    NSRegularExpression *checkDouble = [[NSRegularExpression alloc] initWithPattern:dsc options:0 error:NULL];
    NSUInteger doesDoubleExist = [checkDouble numberOfMatchesInString:quad options:0 range:NSMakeRange(0, quad.length)];
    if (doesDoubleExist > 0) {
        
        return true;
    }
    else return false;
}



- (BOOL)regexValidateQuadraticWithString:(NSString *)quad {
    
    NSString *validateQuadratic = @"^[(]?([-]?[\\d+\\.?\\d*]?[\\d+\\.?\\d*]?[\\d+\\.?\\d*]?[\\d+\\.?\\d*]?)[x][\\^][2]";
    NSRegularExpression *checkQuad = [[NSRegularExpression alloc] initWithPattern:validateQuadratic options:0 error:NULL];
    
    NSUInteger isaQuadratic = [checkQuad numberOfMatchesInString:quad options:0 range:NSMakeRange(0, quad.length)];
    
    if (isaQuadratic < 1) {
        return false;
    }
    
    else return true;
    
}





- (NSMutableArray*)generatePointsWith:(double)a andB:(double)b andC:(double)c {
    
    NSMutableArray *pointsArray = [[NSMutableArray alloc] init];
    
    for (double i = -10; i <= 10; i+= .25) {
        
        double y = (a * (i * i)) + (b * i) + c;
        
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
    
    // Dispose of any resources that can be recreated.
    graphArea = nil;
    
}




@end

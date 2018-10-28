//
//  VertexFocusEquation.m
//  iSolver Pro
//
//  Created by Parker Caputo on 1/27/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "VertexFocusEquation.h"

@interface VertexFocusEquation ()

@end

@implementation VertexFocusEquation
@synthesize focusBox, exampleButton, solveButton, vertexBox, answerBox, fvf, is, toStandard, toVertex, toConic;


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
    
    
    
    self.vertexBox.inputAccessoryView = toolBar;
    self.focusBox.inputAccessoryView = toolBar;
    
    
}

-(IBAction)barButtonAddText:(UIBarButtonItem*)sender

{
    
    if (self.vertexBox.isFirstResponder)
        
    {
        
        [self.vertexBox insertText:sender.title];
        
    }
    
    if (self.focusBox.isFirstResponder)
        
    {
        
        [self.focusBox insertText:sender.title];
        
    }
        
    
    
}

- (IBAction)backgroundTouched:(id)sender {
    [self.view endEditing:YES];
}


- (IBAction)toStandardLand:(id)sender {
    
    NSString *vertex = [self convertToVertexFormWithConic:[self writeEquationInConicForm] isNormal:[self determineVerticalWithPoints:[self getVertex] and:[self getFocus]]];
    
    NSString *answer = [fvf getStandardFormOfEquationFromVertexForm:vertex];
    answer = [self cleanAnswer:answer];
    answerBox.text = answer;
    
    toConic.enabled = TRUE; toConic.backgroundColor = [UIColor blueColor];
    toStandard.enabled = FALSE; toStandard.backgroundColor = [UIColor grayColor];
    toVertex.enabled = TRUE; toVertex.backgroundColor = [UIColor blueColor];
    
}

- (IBAction)toVertexLand:(id)sender {
    
    NSString *answer = [self convertToVertexFormWithConic:[self writeEquationInConicForm] isNormal:[self determineVerticalWithPoints:[self getVertex] and:[self getFocus]]];
    answer = [self cleanAnswer:answer];
    
    answerBox.text = answer;
    
    toConic.enabled = TRUE; toConic.backgroundColor = [UIColor blueColor];
    toStandard.enabled = TRUE; toStandard.backgroundColor = [UIColor blueColor];
    toVertex.enabled = FALSE; toVertex.backgroundColor = [UIColor grayColor];
    
}

- (IBAction)backToConicLand:(id)sender {

    [self performSelector:@selector(calculateVertexFocus)];
    
    toConic.enabled = FALSE; toConic.backgroundColor = [UIColor grayColor];
    toStandard.enabled = TRUE; toStandard.backgroundColor = [UIColor blueColor];
    toVertex.enabled = TRUE; toVertex.backgroundColor = [UIColor blueColor];
    
}



- (BOOL)determineVerticalWithPoints:(gPoint *)vertex and:(gPoint *)focus {
    if (vertex.x == focus.x) {
        return TRUE;
    } else {
        return FALSE;
    }
}

- (gPoint*)getVertex {
    
    gPoint *g = [[gPoint alloc] init];
    NSString *capturedX = [is getMatchWithPattern:@"[(]?(.*)[,](.*)[)]?" inString:[vertexBox text] atIndex:1];
    NSString *capturedY = [is getMatchWithPattern:@"[(]?(.*)[,](.*)[)]?" inString:[vertexBox text] atIndex:2];
    
    double capX = 0; double capY = 0;
    
    capturedX = [is scanAndConvertFraction:capturedX]; capturedY = [is scanAndConvertFraction:capturedY];
    capX = [capturedX doubleValue]; capY = [capturedY doubleValue];
    
    g.x = capX;
    g.y = capY;
    
    return g;
}

- (gPoint*)getFocus {
    
    gPoint *g = [[gPoint alloc] init];
    NSString *capturedX = [is getMatchWithPattern:@"[(]?(.*)[,](.*)[)]?" inString:[focusBox text] atIndex:1];
    NSString *capturedY = [is getMatchWithPattern:@"[(]?(.*)[,](.*)[)]?" inString:[focusBox text] atIndex:2];
    
    double capX = 0; double capY = 0;
    
    capturedX = [is scanAndConvertFraction:capturedX]; capturedY = [is scanAndConvertFraction:capturedY];
    capX = [capturedX doubleValue]; capY = [capturedY doubleValue];
    
    g.x = capX;
    g.y = capY;
    
    return g;
    
}

 // This is where the magic happens ;)
- (IBAction)calculateVertexFocus {
    
    NSString *conicForm = [self writeEquationInConicForm];
    conicForm = [self cleanAnswer:conicForm];
    answerBox.text = conicForm;
    
    toConic.enabled = FALSE; toConic.backgroundColor = [UIColor grayColor];
    toStandard.enabled = TRUE; toStandard.backgroundColor = [UIColor blueColor];
    toVertex.enabled = TRUE; toVertex.backgroundColor = [UIColor blueColor];
    
}


- (NSString*)convertToVertexFormWithConic:(NSString *)conic isNormal:(BOOL)isNorm {
    
    if (!isNorm) {
        
        NSString *get4Ph = [is getMatchWithPattern:@"([\\+|-]?\\d+\\.?\\d*?)[(][x](?:[\\+|-]?\\d+\\.?\\d*?)[)]" inString:conic atIndex:1];
        NSString *getHh = [is getMatchWithPattern:@"(?:[\\+|-]?\\d+\\.?\\d*?)[(][x]([\\+|-]?\\d+\\.?\\d*?)[)]" inString:conic atIndex:1];
        NSString *getKh = [is getMatchWithPattern:@"[=][(][y]([\\+|-]?\\d+\\.?\\d*?)[)]" inString:conic atIndex:1];
        
        double a = 1 / [get4Ph doubleValue]; double h = [getHh doubleValue]; double k = [getKh doubleValue];
        
        if ( [self getFocus].y < [self getVertex].y) {
            a = a * -1;
        }
        
        NSString *answer = [NSString stringWithFormat:@"%.3f(y+%.3f)^2-%.3f",a,k,h];
        answer = [self cleanAnswer:answer];
        return answer;
        
    } else {
        
        NSString *get4P = [is getSingleMatchWithPattern:@"([\\+|-]?\\d+\\.?\\d*?)[(][y][\\+|-][?\\d+\\.?\\d*?][)]" inString:conic];
        NSString *getK = [is getSingleMatchWithPattern:@"(?:[\\+|-]?\\d+\\.?\\d*?)[(][y]([\\+|-][?\\d+\\.?\\d*?])[)]" inString:conic];
        NSString *getH = [is getSingleMatchWithPattern:@"[=][(][x]([\\+|-][?\\d+\\.?\\d*?])[)]" inString:conic];
        
        
        double a = 1 / [get4P doubleValue]; double h = [getH doubleValue]; double k = [getK doubleValue];
        if ( [self getFocus].y < [self getVertex].y) {
            a = a * -1;
        }
        
         NSLog(@"A:%f, H:%f, K:%f",a,h,k);
        NSString *answer = [NSString stringWithFormat:@"%.3f(x-%.3f)^2+%.3f",a,h,k];
        answer = [self cleanAnswer:answer];
        return answer;
    }
    
}

- (NSString*)cleanAnswer:(NSString *)ans {
    
    ans = [ans stringByReplacingOccurrencesOfString:@".000"
                                               withString:@""];
    ans = [ans stringByReplacingOccurrencesOfString:@"+-"
                                               withString:@"-"];
    ans = [ans stringByReplacingOccurrencesOfString:@"--"
                                               withString:@"+"];
    ans = [ans stringByReplacingOccurrencesOfString:@"-0x-0"
                                         withString:@""];
    ans = [ans stringByReplacingOccurrencesOfString:@"-0x+0"
                                         withString:@""];
    ans = [ans stringByReplacingOccurrencesOfString:@"-0x"
                                         withString:@""];
    ans = [ans stringByReplacingOccurrencesOfString:@"+0x"
                                         withString:@""];
    ans = [ans stringByReplacingOccurrencesOfString:@"-0"
                                         withString:@""];
    ans = [ans stringByReplacingOccurrencesOfString:@"+0"
                                         withString:@""];
    return ans;
}


- (NSString*)writeEquationInConicForm {
    
    double vx = [self getVertex].x; double vy = [self getVertex].y;
    double fx = [self getFocus].x; double fy = [self getFocus].y;
    
    double p = 0;
    
    if ([self determineVerticalWithPoints:[self getVertex] and:[self getFocus]]) { // If it's verticle do it this way
        
        if (vy > fy) {
            p = vy - fy;
        } else {
            p = fy - vy;
        }
        
        p = p * 4; // Making it 4p
        
        NSString *answer = [NSString stringWithFormat:@"%.3f(y-%.3f)=(x-%.3f)^2",p,vy,vx];
        
        answer = [answer stringByReplacingOccurrencesOfString:@".000"
                                             withString:@""];
        answer = [answer stringByReplacingOccurrencesOfString:@"+-"
                                             withString:@"-"];
        answer = [answer stringByReplacingOccurrencesOfString:@"--"
                                                   withString:@"+"];
        
        return answer;
        
    } else { // Else its horizontal :(
        
        if (fx > vx) {
            p = fx - vx;
        } else {
            p = vx - fx;
        }
        
        p = p * 4;
        
        NSString *answer = [NSString stringWithFormat:@"%.3f(x-%.3f)=(y-%.3f)^2",p,vx,vy];
        
        answer = [answer stringByReplacingOccurrencesOfString:@".000"
                                                   withString:@""];
        answer = [answer stringByReplacingOccurrencesOfString:@"+-"
                                                   withString:@"-"];
        answer = [answer stringByReplacingOccurrencesOfString:@"--"
                                                   withString:@"+"];
        
        answerBox.text = answer;
        
        [[is generateMessageWithTitle:@"Just so you know" andMessage:@"This is the equation of a horizontal parabola!" andButtonTxt:@"OK!"] show];
        
        return answer;
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	fvf = [[FromVertexForm alloc] init];
    is = [[ISolve alloc] init];
    
    toConic.enabled = FALSE; toConic.backgroundColor = [UIColor grayColor];
    toStandard.enabled = FALSE; toStandard.backgroundColor = [UIColor grayColor];
    toVertex.enabled = FALSE; toVertex.backgroundColor = [UIColor grayColor];
    
    [self configureKeyboardToolbars];
    
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

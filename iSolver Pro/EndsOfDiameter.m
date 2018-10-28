//
//  EndsOfDiameter.m
//  iSolver Pro
//
//  Created by Parker Caputo on 2/16/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "EndsOfDiameter.h"

@interface EndsOfDiameter ()

@end

@implementation EndsOfDiameter

@synthesize answerBox, pointOne, pointTwo, exampleButton, solveButton, graphArea, is;


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
    
    
    
    self.pointOne.inputAccessoryView = toolBar;
    self.pointTwo.inputAccessoryView = toolBar;
    
    
}

-(IBAction)barButtonAddText:(UIBarButtonItem*)sender

{
    
    if (self.pointOne.isFirstResponder)
        
    {
        
        [self.pointOne insertText:sender.title];
        
    }
    
    if (self.pointTwo.isFirstResponder)
        
    {
        
        [self.pointTwo insertText:sender.title];
        
    }
    
    
    
}

- (IBAction)backgroundTouched:(id)sender {
    [self.view endEditing:YES];
}


- (double)getRadiusFromMidPoints:(gPoint *)points andPointOnCircle:(gPoint *)rndPoint {
    
    if (points.x == 0) {
        points.x = .0000000000001;
    }
    if (points.y == 0) {
        points.y = .0000000000001;
    }
    
    double radiusSquared = ((rndPoint.x - points.x)*(rndPoint.x - points.x) + ((rndPoint.y - points.y)*(rndPoint.y - points.y)));
    
    NSLog(@"Rad squared:%.3f",radiusSquared);
    
    return radiusSquared;
}

- (gPoint*)getMidPointFromPoints:(gPoint *)one and:(gPoint *)two {
    
    gPoint *g = [[gPoint alloc] init];
    
    double midX = ((one.x + two.x) / 2);
    double midY = ((one.y + two.y) / 2);
    
    g.x = midX; g.y = midY;
    
    
    return g;
}

- (gPoint*)extractPointsFromText:(NSString*)str {
    
    gPoint *g = [[gPoint alloc] init];
    is = [[ISolve alloc] init];
    NSString *capturedX = [is getMatchWithPattern:@"[(]?(.*)[,](.*)[)]?" inString:str atIndex:1];
    NSString *capturedY = [is getMatchWithPattern:@"[(]?(.*)[,](.*)[)]?" inString:str atIndex:2];
    
    double capX = 0; double capY = 0;
    
    capturedX = [is scanAndConvertFraction:capturedX]; capturedY = [is scanAndConvertFraction:capturedY];
    capX = [capturedX doubleValue]; capY = [capturedY doubleValue];
    
    g.x = capX; g.y = capY;
    
    return g;
}

- (IBAction)exampleTime:(id)sender {
    
    pointOne.text = @"-17,-9";
    pointTwo.text = @"-19,-9";
    [self performSelector:@selector(calculateCircleWithDiameter)];
    
}

- (IBAction)calculateCircleWithDiameter {
    
    gPoint *gPointOne = [self extractPointsFromText:[pointOne text]];
    gPoint *gPointTwo = [self extractPointsFromText:[pointTwo text]];
    
    gPoint *center = [self getMidPointFromPoints:gPointOne and:gPointTwo];
    
    NSLog(@"X:%.3f, Y:%.3f",center.x, center.y);
    
    double radius = [self getRadiusFromMidPoints:center andPointOnCircle:gPointOne];
    center.x = center.x * -1; center.y = center.y * -1;
    
    NSString *answer = [NSString stringWithFormat:@"(x+%.3f)^2 + (y+%.3f)^2 = %.3f",center.x,center.y,radius];
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
    
    [self.view endEditing:YES];
                      
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	is = [[ISolve alloc] init];
    
    [self configureKeyboardToolbars];
    self.view.backgroundColor = [UIColor blackColor];
    
    [pointOne becomeFirstResponder];
    
    graphArea = [graphArea initWithFrame:CGRectMake(0, 0, graphArea.graphWidth, graphArea.graphHeight)];
    
    [graphArea setBackgroundColor:[UIColor blackColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

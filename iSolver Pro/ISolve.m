//
//  ISolve.m
//  iSolver Pro
//
//  Created by Parker Caputo on 1/17/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "ISolve.h"

@implementation ISolve

- (NSString*)evaluateBasicExpression:(NSString *)str {
    
    NSString *result = [[NSString alloc] init];
    
    @try {
        NSExpression *ex = [NSExpression expressionWithFormat:str];
        ex = [ex expressionValueWithObject:nil context:nil];
        result = [NSString stringWithFormat:@"%@",ex];
    }
    @catch (NSException *e) {
        NSLog(@"%@",e);
        result = str;
    }
    
    return result;
}



- (NSArray*)getMatchesWithPattern:(NSString *)str inString:(NSString *)toFind {
    
    NSRegularExpression *expo = [[NSRegularExpression alloc] initWithPattern:str options:0 error:NULL];
    NSArray *occurances = [expo matchesInString:toFind options:0 range:NSMakeRange(0, [toFind length])];
    
    return occurances;
}

- (NSString*)getSingleMatchWithPattern:(NSString *)str inString:(NSString *)theString {
    
    
    NSRegularExpression *run = [[NSRegularExpression alloc] initWithPattern:str options:0 error:NULL];
    NSTextCheckingResult *match = [run firstMatchInString:theString options:0 range:NSMakeRange(0, [theString length])];
    
    if (match) {
        NSString *captured = [theString substringWithRange:[match rangeAtIndex:0]];
        return captured;
    } else {
        return @"";
    }
    
}

- (NSString*)getMatchWithPattern:(NSString *)str inString:(NSString *)theString atIndex:(int)index {
    
    NSRegularExpression *run = [[NSRegularExpression alloc] initWithPattern:str options:0 error:NULL];
    NSTextCheckingResult *match = [run firstMatchInString:theString options:0 range:NSMakeRange(0, [theString length])];
    
    if (match) {
        NSString *captured = [theString substringWithRange:[match rangeAtIndex:index]];
        return captured;
    } else {
        return @"";
    }
}

- (UIAlertView*)generateAlertWithMessage:(NSString *)str {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    return alert;
}

- (UIAlertView*)generateMessageWithTitle:(NSString *)title andMessage:(NSString *)msg andButtonTxt:(NSString *)buttonTxt {
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:buttonTxt otherButtonTitles:nil, nil];
    return message;
}

- (double)getDistanceBetween:(gPoint *)pt2 and:(gPoint *)pt1 {
    
    double x2 = (pt2.x - pt1.x)*(pt2.x - pt1.x);
    double y2 = (pt2.y - pt1.y)*(pt2.y - pt1.y);
    
    double distance = sqrt(x2 + y2);
    return fabs(distance);
}

- (gPoint*)getCoordinatesFromString:(NSString *)str {
        
        gPoint *g = [[gPoint alloc] init];
        NSString *capturedX = [self getMatchWithPattern:@"[(]?(.*)[,](.*)[)]?" inString:str atIndex:1];
        NSString *capturedY = [self getMatchWithPattern:@"[(]?(.*)[,](.*)[)]?" inString:str atIndex:2];
        
        double capX = 0; double capY = 0;
        
        capturedX = [self scanAndConvertFraction:capturedX]; capturedY = [self scanAndConvertFraction:capturedY];
        capX = [capturedX doubleValue]; capY = [capturedY doubleValue];
        
        g.x = capX;
        g.y = capY;
        
        return g;
        
    
}

- (NSString*)scanAndConvertRadical:(NSString *)str {
    
    NSString *coefficient = [self getSingleMatchWithPattern:@"(\\d+\\.?\\d*)[√]" inString:str];
    NSString *radical = [self getSingleMatchWithPattern:@"[√](\\d+\\.?\\d*)" inString:str];
    
    if (![radical isEqual:@""] && ![coefficient isEqual:@""]) {
    
   coefficient = [coefficient stringByReplacingOccurrencesOfString:@"√"
                                      withString:@""];
    radical = [radical stringByReplacingOccurrencesOfString:@"√"
                                      withString:@""];
    
    double coeff = [coefficient doubleValue];
    double rad = [radical doubleValue];
    
    if (coeff != 0) {
        double final = coeff * sqrt(rad);
        str = [NSString stringWithFormat:@"%.3f",final];
    } else {
        
        double reduced = sqrt(rad);
        str = [NSString stringWithFormat:@"%.3f",reduced];
    }
}

    return str;
    
}


- (NSString*)scanAndConvertFraction:(NSString *)str {
    
    NSString *numPattern = [NSString stringWithFormat:@"(-?\\d+\\.?\\d*)[\\/](?:-?\\d+\\.?\\d*)"];
    NSString *dePattern = [NSString stringWithFormat:@"(?:-?\\d+\\.?\\d*)[\\/](-?\\d+\\.?\\d*)"];
    
    NSArray *howMany = [self getMatchesWithPattern:numPattern inString:str];
    
    for (int i=0; i < howMany.count + 1; i++) {
        
    NSRegularExpression *runNum = [[NSRegularExpression alloc] initWithPattern:numPattern options:0 error:NULL];
    NSTextCheckingResult *matchNum = [runNum firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
    
    NSRegularExpression *runDe = [[NSRegularExpression alloc] initWithPattern:dePattern options:0 error:NULL];
    NSTextCheckingResult *matchDe = [runDe firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
    
    
    if (matchNum && matchDe) {
        
        NSString *numerator = [str substringWithRange:[matchNum rangeAtIndex:1]];
        NSString *denominator = [str substringWithRange:[matchDe rangeAtIndex:1]];
        
        int numInt = [numerator intValue]; int deInt = [denominator intValue];
        NSString *toReplace = [NSString stringWithFormat:@"%i/%i",numInt, deInt];
        
        
        double value = [numerator doubleValue] / [denominator doubleValue];
        NSString *stringValue = [NSString stringWithFormat:@"%f",value];
        str = [str stringByReplacingOccurrencesOfString:toReplace
                                             withString:stringValue];
        
    }
}

return str;
    
}

@end

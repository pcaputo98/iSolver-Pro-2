//
//  MathParser.m
//  iSolver Pro
//
//  Created by Parker Caputo on 2/22/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "MathParser.h"


@implementation MathParser

- (NSString*)removeCapturedPiece:(NSString *)toRemove fromString:(NSString*)str withString:(NSString *)replace {
    
    NSRange replaceRange = [str rangeOfString:toRemove];
    if (replaceRange.location != NSNotFound){
        NSString *final = [str stringByReplacingCharactersInRange:replaceRange withString:replace];
        NSLog(@"Final String:%@",final);
        return final;
        
    } else {
        NSLog(@"Str:%@",str);
        return str;
    }
}

- (NSString*)iterateThroughParenthesisMatch:(NSString *)fullMatch withArrayOfSubMatches:(NSMutableArray *)arry withMode:(NSString *)mode {
    
    BasicMath *bm = [[BasicMath alloc] init];
    ISolve *is = [[ISolve alloc] init];
    
    NSLog(@"Full Match Prior:%@",fullMatch);
    
    for (int i = (unsigned)(long)arry.count -1; i >= 0; i--) {
        NSLog(@"Nunber is..%i",i);
        
        NSString *tmpStr = [[NSString alloc] init]; tmpStr = [arry objectAtIndex:i];
        NSString *strToRemove = [[NSString alloc] init]; strToRemove = tmpStr;
        tmpStr = [self evaluateExpression:tmpStr withMode:mode];
        
        fullMatch = [self removeCapturedPiece:strToRemove fromString:fullMatch withString:tmpStr];
    }
    
    NSLog(@"Full match post:%@",fullMatch);
    
    fullMatch = [bm scanAndConvertParenthesisMultiplication:fullMatch];
    fullMatch = [is evaluateBasicExpression:fullMatch]; // Basic add/subtract/multiply/divide :)
    
    return fullMatch;
}
/*
- (NSString*)simplifyParenthesis:(NSString *)parenthesis withMode:(NSString *)mode {

    ISolve *is = [[ISolve alloc] init];
    BasicMath *bm = [[BasicMath alloc] init];
    LogsAndExponets *le = [[LogsAndExponets alloc] init];
    TrigFunctions *tf = [[TrigFunctions alloc] init];
    
    NSMutableArray *timesOccured = [[NSMutableArray alloc] init];
    
    NSString *moddedString = [[NSString alloc] init]; moddedString = parenthesis;
    NSString *pattern = [[NSString alloc] init]; pattern = [NSString stringWithFormat:@"([(](.*)[)])"];
    
    NSString *parenthesisOccur = [is getSingleMatchWithPattern:pattern inString:parenthesis];
    NSLog(@"First par match:%@",parenthesisOccur);
    NSString *cap = [[NSString alloc] init];
    
        NSRegularExpression *secondRun = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:NULL];
        NSTextCheckingResult *match = [secondRun firstMatchInString:parenthesisOccur options:0 range:NSMakeRange(0, [parenthesisOccur length])];
        
        NSString *captured = [parenthesisOccur substringWithRange:[match rangeAtIndex:1]];
        cap = captured;
        NSString *secondLevel = [parenthesisOccur substringWithRange:[match rangeAtIndex:2]];
        NSString *secondIteration = [is getSingleMatchWithPattern:pattern inString:secondLevel];
        // Keep scanning the sub match of the inital match for parenthesis :)
        
        while (![secondIteration isEqual:@""]) {
            
            [timesOccured addObject:secondIteration];
            
            NSRegularExpression *runAgain = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:NULL];
            NSTextCheckingResult *mtch = [runAgain firstMatchInString:secondIteration options:0 range:NSMakeRange(0, [secondIteration length])];
            secondIteration = [secondIteration substringWithRange:[mtch rangeAtIndex:2]];
            
            NSLog(@"Second iteration:%@",secondIteration);
        }
    
    cap = [self iterateThroughParenthesisMatch:cap withArrayOfSubMatches:timesOccured withMode:mode];
    cap = [NSString stringWithFormat:@"(%@)",cap];
    parenthesis = [self removeCapturedPiece:parenthesisOccur fromString:parenthesis withString:cap];
    
    changes = 1;
    while (changes > 0) {
        
    NSString *parPrior = [// Loop through parenthesis multiplication ;)]
                          parenthesis = [bm scanAndConvertParenthesisMultiplication:parenthesis];
        
    NSLog(@"Simplified Parenthesis:%@",parenthesis);
    }
    return parenthesis;
}
*/
- (void)compareStrings:(NSString *)currentExpression and:(NSString *)expression {
    if (expression != currentExpression) {

        changes++;
    }
}

- (NSString*)evaluateTrigFunctionsWithExpression:(NSString *)exp andMode:(NSString *)mode {
    
    TrigFunctions *tf = [[TrigFunctions alloc] init];
    NSString *currentExpression = exp;
    
    // Trig functions
    
    while (changes > 0) {
    
    currentExpression = exp;
    exp = [tf scanAndConvertSin:exp withMode:mode];
    [self compareStrings:currentExpression and:exp];
    
    currentExpression = exp;
    exp = [tf scanAndConvertCos:exp withMode:mode];
    [self compareStrings:currentExpression and:exp];
    
    currentExpression = exp;
    exp = [tf scanAndConvertTan:currentExpression withMode:mode];
    [self compareStrings:currentExpression and:exp];
    
    // Inverse Trig Functions
    
    currentExpression = exp;
    exp = [tf scanAndConvertArcSin:currentExpression withMode:mode];
    [self compareStrings:currentExpression and:exp];
    
    currentExpression = exp;
    exp = [tf scanAndConvertArcCos:currentExpression withMode:mode];
    [self compareStrings:currentExpression and:exp];
    
    currentExpression = exp;
    exp = [tf scanAndConvertArcTan:currentExpression withMode:mode];
    [self compareStrings:currentExpression and:exp];
    
        changes--;
    }
    return exp;
    
}

- (NSString*)evaluateExpression:(NSString *)expression withMode:(NSString *)mode{
    
    expression = [expression stringByReplacingOccurrencesOfString:@"√("
                                               withString:@"sqrt("];
    expression = [expression stringByReplacingOccurrencesOfString:@"e"
                                                       withString:@"(2.7182818284590452353602875)"];
    expression = [expression stringByReplacingOccurrencesOfString:@"π"
                                                       withString:@"(3.14159265359)"];
    
    
    // Needs to evaluate parenthesis first...and also need to know how to multiply against parenthesis lol
    // fuck
    
    NSString *currentExpression = expression;
    changes = 1;
    
    BasicMath *bm = [[BasicMath alloc] init];
    LogsAndExponets *le = [[LogsAndExponets alloc] init];
    ISolve *is = [[ISolve alloc] init];
    
    while (changes > 0) {
        
        // Exponets, logs, radicals, scientific notation
        
        currentExpression = expression;
        expression = [self simplifyParenthesis:expression withMode:mode];
        [self compareStrings:currentExpression and:expression];
        
        currentExpression = expression;
        expression = [le scanAndConvertExponets:expression];
        [self compareStrings:currentExpression and:expression];
        
        currentExpression = expression;
        expression = [le scanAndConvertLogs:expression];
        [self compareStrings:currentExpression and:expression];
        
        currentExpression = expression;
        expression = [bm scanAndConvertSquareRoot:expression];
        [self compareStrings:currentExpression and:expression];
        
        currentExpression = expression;
        expression = [bm scanAndConvertScientificNotation:expression];
        [self compareStrings:currentExpression and:expression];
        
        // Multiplication and division
        currentExpression = expression;
        expression = [bm scanAndConvertParenthesisMultiplication:expression];
        [self compareStrings:currentExpression and:expression];
                      
        currentExpression = expression;
        expression = [is evaluateBasicExpression:expression];
        [self compareStrings:currentExpression and:expression];
        
       expression = [self evaluateTrigFunctionsWithExpression:expression andMode:mode];
        
        NSLog(@"Changes!%i",changes);
        changes--;
    }
    
    expression = [expression stringByReplacingOccurrencesOfString:@"+"
                                                       withString:@""];
    
    @try {
        NSExpression *ex = [NSExpression expressionWithFormat:expression];
        ex = [ex expressionValueWithObject:nil context:nil];
        expression = [NSString stringWithFormat:@"%@",ex];
    }
    @catch (NSException *e) {
        NSLog(@"%@",e);
        expression = @"Error Syntax";
    }
    
    
    NSLog(@"Expression:%@",expression);
    
    return expression;
}

@end


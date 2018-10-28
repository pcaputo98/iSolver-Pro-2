//
//  MathParser.h
//  iSolver Pro
//
//  Created by Parker Caputo on 2/22/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrigFunctions.h"
#import "LogsAndExponets.h"
#import "BasicMath.h"
#import "ISolve.h"

// Basically puts all conversion methods together...sorts parenthesis etc

@interface MathParser : NSObject {
    int changes;
}

- (NSString*)removeCapturedPiece:(NSString*)toRemove fromString:(NSString*)str withString:(NSString*)replace;

- (NSString*)simplifyParenthesis:(NSString*)parenthesis withMode:(NSString*)mode; // Simplifies parenthesis of all levels
- (NSString*)iterateThroughParenthesisMatch:(NSString*)fullMatch withArrayOfSubMatches:(NSMutableArray*)arry withMode:(NSString*)mode;

- (NSString*)evaluateExpression:(NSString*)expression withMode:(NSString*)mode;
- (void)compareStrings:(NSString*)currentExpression and:(NSString*)expression;
- (NSString*)evaluateTrigFunctionsWithExpression:(NSString*)exp andMode:(NSString*)mode;

@end

//
//  TrigFunctions.h
//  iSolver Pro
//
//  Created by Parker Caputo on 2/25/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISolve.h"
#import "MathParser.h"

@class MathParser;

@interface TrigFunctions : NSObject


// Sine
- (NSString*)scanAndConvertArcSin:(NSString*)str withMode:(NSString*)mode;
- (NSString*)scanAndConvertSin:(NSString*)str withMode:(NSString*)mode;

// Cosine

- (NSString*)scanAndConvertArcCos:(NSString*)str withMode:(NSString*)mode;
- (NSString*)scanAndConvertCos:(NSString*)str withMode:(NSString*)mode;

// Tangent

- (NSString*)scanAndConvertArcTan:(NSString*)str withMode:(NSString*)mode;
- (NSString*)scanAndConvertTan:(NSString*)str withMode:(NSString*)mode;

@end

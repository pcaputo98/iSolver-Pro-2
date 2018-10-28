//
//  BasicMath.h
//  iSolver Pro
//
//  Created by Parker Caputo on 2/25/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MathParser.h"

@interface BasicMath : NSObject

- (NSString*)scanAndConvertParenthesisMultiplication:(NSString*)str;

- (NSString*)scanAndConvertScientificNotation:(NSString*)str;
- (NSString*)scanAndConvertSquareRoot:(NSString*)str;

- (NSString*)scanAndConvertMultplicationAndDivision:(NSString*)str;
- (NSString*)scanAndConvertAdditionSubtraction:(NSString*)str;

@end

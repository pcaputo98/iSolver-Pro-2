//
//  ISolve.h
//  iSolver Pro
//
//  Created by Parker Caputo on 1/17/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "gPoint.h"

@interface ISolve : NSObject

- (NSString*)evaluateBasicExpression:(NSString*)str; // Good for (only) evaluating BASIC multiplication, division, addition and subtraction

- (NSArray*)getMatchesWithPattern:(NSString*)str inString:(NSString*)toFind; // Returns an array of NSTextCheckingResults

- (NSString*)getSingleMatchWithPattern:(NSString*)str inString:(NSString*)theString; // Returns the match ;)

- (NSString*)getMatchWithPattern:(NSString*)str inString:(NSString*)theString atIndex:(int)index;

- (UIAlertView*)generateAlertWithMessage:(NSString*)str; // Throw an alert ^.^

- (UIAlertView*)generateMessageWithTitle:(NSString*)title andMessage:(NSString*)msg andButtonTxt:(NSString*)buttonTxt; // Same as above but with more customization

- (double)getDistanceBetween:(gPoint*)pt2 and:(gPoint*)pt1; // Solves distance between two points
- (gPoint*)getCoordinatesFromString:(NSString*)str; // Extracts coordinates in (x,y) form

- (NSString*)scanAndConvertFraction:(NSString*)str; // Scans and converts fractions...deprecated
- (NSString*)scanAndConvertRadical:(NSString*)str; // Scans and converts radicals...deprecated



@end

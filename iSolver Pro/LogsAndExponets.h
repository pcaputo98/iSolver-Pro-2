//
//  LogsAndExponets.h
//  iSolver Pro
//
//  Created by Parker Caputo on 2/25/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MathParser.h"

@class MathParser;

@interface LogsAndExponets : NSObject

- (NSString*)scanAndConvertExponets:(NSString*)str;
- (NSString*)scanAndConvertLogs:(NSString*)str;
- (NSString*)scanAndConvertNaturalLogs:(NSString*)str;

@end

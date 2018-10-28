//
//  LogsAndExponets.m
//  iSolver Pro
//
//  Created by Parker Caputo on 2/25/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "LogsAndExponets.h"

@implementation LogsAndExponets

- (NSString*)scanAndConvertExponets:(NSString *)str {
    
    ISolve *is = [[ISolve alloc] init];
    MathParser *mp = [[MathParser alloc] init];
    
    NSString *exponetsOccur = [is getSingleMatchWithPattern:@"(-?\\d?+\\.?\\d*)[\\^][(]?(-?\\d?+\\.?\\d*)[)]?" inString:str];
    NSString *moddedString = [[NSString alloc] init];
    moddedString = str; // Set it to the original :)
    
    if (![exponetsOccur isEqual:@""]) {
        
        while (![exponetsOccur isEqual:@""]) {
            
            NSRegularExpression *secondRun = [[NSRegularExpression alloc] initWithPattern:@"(-?\\d?+\\.?\\d*)[\\^](-?\\d?+\\.?\\d*)" options:0 error:NULL];
            NSTextCheckingResult *match = [secondRun firstMatchInString:exponetsOccur options:0 range:NSMakeRange(0, [exponetsOccur length])];
            
            NSString *capturedCoefficient = [exponetsOccur substringWithRange:[match rangeAtIndex:1]];
            NSString *exponet = [exponetsOccur substringWithRange:[match rangeAtIndex:2]];
            
            double capCo = [capturedCoefficient doubleValue];
            double capExpo = [exponet doubleValue];
            
            double replaceNumber = pow(capCo, capExpo);
            NSString *stringReplace = [NSString stringWithFormat:@"%f",replaceNumber];
            
            NSString *modifiedString = [[NSString alloc] init];
            modifiedString = [mp removeCapturedPiece:exponetsOccur fromString:moddedString withString:stringReplace];
            
            moddedString = modifiedString;
            
            exponetsOccur = [is getSingleMatchWithPattern:@"(-?\\d?+\\.?\\d*)[\\^](-?\\d?+\\.?\\d*)" inString:modifiedString];
            
        }
        moddedString = [NSString stringWithFormat:@"%@",moddedString];
        return moddedString;
    } else {
        return str;
    }
    
    
} 

- (NSString*)scanAndConvertLogs:(NSString *)str {
    
    ISolve *is = [[ISolve alloc] init];
    MathParser *mp = [[MathParser alloc] init];
    
    NSString *pattern = @"(-?\\d?+\\.?\\d*)[l][o][g][(](-?\\d?+\\.?\\d*)[)]";
    
    NSString *logsOccur = [is getSingleMatchWithPattern:pattern inString:str];
    NSString *moddedString = [[NSString alloc] init];
    moddedString = str; // Set it to the original :)
    
    if (![logsOccur isEqual:@""]) {
        
        while (![logsOccur isEqual:@""]) {
            
            NSRegularExpression *secondRun = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:NULL];
            NSTextCheckingResult *match = [secondRun firstMatchInString:logsOccur options:0 range:NSMakeRange(0, [logsOccur length])];
            
            NSString *coefficient = [logsOccur substringWithRange:[match rangeAtIndex:1]];
            NSString *capturedLog = [logsOccur substringWithRange:[match rangeAtIndex:2]];
            
            if ([coefficient isEqual:@""]) {
                coefficient = @"1";
            }
            
            double replaceLog = log10([capturedLog doubleValue]);
            replaceLog = replaceLog * [coefficient doubleValue];
            
            NSString *stringReplace = [NSString stringWithFormat:@"%f",replaceLog];
            
            NSString *modifiedString = [[NSString alloc] init];
            modifiedString = [mp removeCapturedPiece:logsOccur fromString:moddedString withString:stringReplace];
            
            moddedString = modifiedString;
            
            logsOccur = [is getSingleMatchWithPattern:pattern inString:modifiedString];
            
        }
        moddedString = [NSString stringWithFormat:@"%@",moddedString];
        return moddedString;
    } else {
        return str;
    }
    
    
}

- (NSString*)scanAndConvertNaturalLogs:(NSString *)str {
    
    ISolve *is = [[ISolve alloc] init];
    MathParser *mp = [[MathParser alloc] init];
    
    NSString *pattern = @"(-?\\d?+\\.?\\d*)[l][n][(](-?\\d?+\\.?\\d*)[)]";
    
    NSString *logsOccur = [is getSingleMatchWithPattern:pattern inString:str];
    NSString *moddedString = [[NSString alloc] init];
    moddedString = str; // Set it to the original :) STRING
    
    if (![logsOccur isEqual:@""]) {
        
        while (![logsOccur isEqual:@""]) {
            
            NSRegularExpression *secondRun = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:NULL];
            NSTextCheckingResult *match = [secondRun firstMatchInString:logsOccur options:0 range:NSMakeRange(0, [logsOccur length])];
            
            NSString *capturedCoefficient = [logsOccur substringWithRange:[match rangeAtIndex:1]];
            NSString *capturedLog = [logsOccur substringWithRange:[match rangeAtIndex:2]];
            
            if ([capturedCoefficient isEqual:@""]) {
                capturedCoefficient = @"1";
            }
            
            double replaceLog = log([capturedLog doubleValue]);
            replaceLog = replaceLog * [capturedCoefficient doubleValue];
            
            NSString *stringReplace = [NSString stringWithFormat:@"%f",replaceLog];
            
            NSString *modifiedString = [[NSString alloc] init];
            modifiedString = [mp removeCapturedPiece:logsOccur fromString:moddedString withString:stringReplace];
            
            moddedString = modifiedString;
            
            logsOccur = [is getSingleMatchWithPattern:pattern inString:modifiedString];
            
        }
        moddedString = [NSString stringWithFormat:@"%@",moddedString];
        return moddedString;
    } else {
        return str;
    }
    
}

@end

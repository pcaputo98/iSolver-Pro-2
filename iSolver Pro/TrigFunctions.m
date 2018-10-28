//
//  TrigFunctions.m
//  iSolver Pro
//
//  Created by Parker Caputo on 2/25/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "TrigFunctions.h"

@implementation TrigFunctions

#pragma trig functions // Lol

- (NSString*)scanAndConvertArcSin:(NSString *)str withMode:(NSString *)mode {
    
    ISolve *is = [[ISolve alloc] init];
    MathParser *mp = [[MathParser alloc] init];
    NSString *pattern = [NSString stringWithFormat:@"(-?\\d?+\\.?\\d*)?[a][r][c][s][i][n][(](-?\\d?+\\.?\\d*)[)]"];
    
    NSString *arcSinOccur = [is getSingleMatchWithPattern:pattern inString:str];
    NSString *moddedString = [[NSString alloc] init];
    moddedString = str; // Set it to the original :)
    
    if (![arcSinOccur isEqual:@""]) {
        
        while (![arcSinOccur isEqual:@""]) {
            
            NSRegularExpression *secondRun = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:NULL];
            NSTextCheckingResult *match = [secondRun firstMatchInString:arcSinOccur options:0 range:NSMakeRange(0, [arcSinOccur length])];
            
            NSString *capturedCoefficient = [arcSinOccur substringWithRange:[match rangeAtIndex:1]];
            NSString *capturedLog = [arcSinOccur substringWithRange:[match rangeAtIndex:2]];
            
            double replaceArcSign = asin(([capturedLog doubleValue]));
            NSLog(@"ArcSin:%f",replaceArcSign);
            
            if ([mode isEqual:@"Degrees"]) {
                replaceArcSign = ((replaceArcSign) * (180.0 / M_PI));
            }
            if ([capturedCoefficient isEqual:@""]) {
                capturedCoefficient = @"1";
            }
            
            replaceArcSign = replaceArcSign * [capturedCoefficient doubleValue];
            
            NSString *stringReplace = [NSString stringWithFormat:@"%f",replaceArcSign];
            
            NSString *modifiedString = [[NSString alloc] init];
            modifiedString = [mp removeCapturedPiece:arcSinOccur fromString:moddedString withString:stringReplace];
            
            moddedString = modifiedString;
            
            arcSinOccur = [is getSingleMatchWithPattern:pattern inString:modifiedString];
            
        }
        moddedString = [NSString stringWithFormat:@"(%@)",moddedString];
        return moddedString;
    } else {
        return str;
    }
}

- (NSString*)scanAndConvertSin:(NSString *)str withMode:(NSString *)mode {
    
    ISolve *is = [[ISolve alloc] init];
    MathParser *mp = [[MathParser alloc] init];
    
    NSString *pattern = [NSString stringWithFormat:@"(-?\\d?+\\.?\\d*)?[s][i][n][(](-?\\d?+\\.?\\d*)[)]"];
    // Add support for multiples :) ;)
    
    NSString *sinOccur = [is getSingleMatchWithPattern:pattern inString:str];
    NSString *moddedString = [[NSString alloc] init];
    moddedString = str; // Set it to the original :)
    
    if (![sinOccur isEqual:@""]) {
        
        while (![sinOccur isEqual:@""]) {
            
            NSRegularExpression *secondRun = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:NULL];
            NSTextCheckingResult *match = [secondRun firstMatchInString:sinOccur options:0 range:NSMakeRange(0, [sinOccur length])];
            
            NSString *capturedLog = [sinOccur substringWithRange:[match rangeAtIndex:2]];
            NSString *capturedCoefficient = [sinOccur substringWithRange:[match rangeAtIndex:1]];
            
            if ([capturedCoefficient isEqual:@""]) {
                capturedCoefficient = @"1";
            }
            
            double replaceSign = sin(([capturedLog doubleValue]));
            
            if ([mode isEqual:@"Degrees"]) {
                replaceSign = (sin([capturedLog doubleValue]*(M_PI/180)));
            }
            
            replaceSign = replaceSign * [capturedCoefficient doubleValue];
            
            
            NSString *stringReplace = [NSString stringWithFormat:@"%f",replaceSign];
            
            NSString *modifiedString = [[NSString alloc] init];
            modifiedString = [mp removeCapturedPiece:sinOccur fromString:moddedString withString:stringReplace];
            
            moddedString = modifiedString;
            
            sinOccur = [is getSingleMatchWithPattern:pattern inString:modifiedString];
            
        }
        moddedString = [NSString stringWithFormat:@"(%@)",moddedString];
        return moddedString;
    } else {
        return str;
    }
}


- (NSString*)scanAndConvertArcCos:(NSString *)str withMode:(NSString *)mode {
    
    ISolve *is = [[ISolve alloc] init];
    MathParser *mp = [[MathParser alloc] init];
    
    NSString *pattern = [NSString stringWithFormat:@"(-?\\d?+\\.?\\d*)?[a][r][c][c][o][s][(](-?\\d?+\\.?\\d*)[)]"];
    
    NSString *arcCosOccur = [is getSingleMatchWithPattern:pattern inString:str];
    NSString *moddedString = [[NSString alloc] init];
    moddedString = str; // Set it to the original :)
    
    if (![arcCosOccur isEqual:@""]) {
        
        while (![arcCosOccur isEqual:@""]) {
            
            NSRegularExpression *secondRun = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:NULL];
            NSTextCheckingResult *match = [secondRun firstMatchInString:arcCosOccur options:0 range:NSMakeRange(0, [arcCosOccur length])];
            
            NSString *capturedLog = [arcCosOccur substringWithRange:[match rangeAtIndex:2]];
            NSString *capturedCoefficient = [arcCosOccur substringWithRange:[match rangeAtIndex:1]];
            
            double replaceSign = acos(([capturedLog doubleValue]));
            
            if ([mode isEqual:@"Degrees"]) {
                replaceSign = ((replaceSign) * (180.0 / M_PI));
            }
            if ([capturedCoefficient isEqual:@""]) {
                capturedCoefficient = @"1";
            }
            
            replaceSign = replaceSign * [capturedCoefficient doubleValue];
            
            NSString *stringReplace = [NSString stringWithFormat:@"%f",replaceSign];
            
            NSString *modifiedString = [[NSString alloc] init];
            modifiedString = [mp removeCapturedPiece:arcCosOccur fromString:moddedString withString:stringReplace];
            
            moddedString = modifiedString;
            
            arcCosOccur = [is getSingleMatchWithPattern:pattern inString:modifiedString];
            
        }
        moddedString = [NSString stringWithFormat:@"(%@)",moddedString];
        return moddedString;
    } else {
        return str;
    }
    
}

- (NSString*)scanAndConvertCos:(NSString *)str withMode:(NSString *)mode {
    
    ISolve *is = [[ISolve alloc] init];
    MathParser *mp = [[MathParser alloc] init];
    
    NSString *pattern = [NSString stringWithFormat:@"(-?\\d?+\\.?\\d*)?[c][o][s][(](-?\\d?+\\.?\\d*)[)]"];
    
    NSString *cosOccur = [is getSingleMatchWithPattern:pattern inString:str];
    NSString *moddedString = [[NSString alloc] init];
    moddedString = str; // Set it to the original :)
    
    if (![cosOccur isEqual:@""]) {
        
        while (![cosOccur isEqual:@""]) {
            
            NSRegularExpression *secondRun = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:NULL];
            NSTextCheckingResult *match = [secondRun firstMatchInString:cosOccur options:0 range:NSMakeRange(0, [cosOccur length])];
            
            NSString *capturedLog = [cosOccur substringWithRange:[match rangeAtIndex:2]];
            NSString *capturedCoefficient = [cosOccur substringWithRange:[match rangeAtIndex:1]];
            
            double replaceSign = cos(([capturedLog doubleValue]));
            
            if ([mode isEqual:@"Degrees"]) {
                replaceSign = cos([capturedLog doubleValue]*(M_PI/180));
            }
            if ([capturedCoefficient isEqual:@""]) {
                capturedCoefficient = @"1";
            }
            
            replaceSign = replaceSign * [capturedCoefficient doubleValue];
            
            NSString *stringReplace = [NSString stringWithFormat:@"%f",replaceSign];
            
            NSString *modifiedString = [[NSString alloc] init];
            modifiedString = [mp removeCapturedPiece:cosOccur fromString:moddedString withString:stringReplace];
            
            moddedString = modifiedString;
            
            cosOccur = [is getSingleMatchWithPattern:pattern inString:modifiedString];
            
        }
        moddedString = [NSString stringWithFormat:@"(%@)",moddedString];
        return moddedString;
    } else {
        return str;
    }
}

- (NSString*)scanAndConvertArcTan:(NSString *)str withMode:(NSString *)mode {
    
    ISolve *is = [[ISolve alloc] init];
    MathParser *mp = [[MathParser alloc] init];
    
    NSString *pattern = [NSString stringWithFormat:@"(-?\\d?+\\.?\\d*)?[a][r][c][t][a][n][(](-?\\d?+\\.?\\d*)[)]"];
    
    NSString *arcTanOccur = [is getSingleMatchWithPattern:pattern inString:str];
    NSString *moddedString = [[NSString alloc] init];
    moddedString = str; // Set it to the original :)
    
    if (![arcTanOccur isEqual:@""]) {
        
        while (![arcTanOccur isEqual:@""]) {
            
            NSRegularExpression *secondRun = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:NULL];
            NSTextCheckingResult *match = [secondRun firstMatchInString:arcTanOccur options:0 range:NSMakeRange(0, [arcTanOccur length])];
            
            NSString *capturedLog = [arcTanOccur substringWithRange:[match rangeAtIndex:2]];
            NSString *capturedCoefficient = [arcTanOccur substringWithRange:[match rangeAtIndex:1]];
            
            double replaceSign = atan(([capturedLog doubleValue]));
            
            if ([mode isEqual:@"Degrees"]) {
                replaceSign = ((replaceSign) * (180.0 / M_PI));
            }
            if ([capturedCoefficient isEqual:@""]) {
                capturedCoefficient = @"1";
            }
            
            replaceSign = replaceSign * [capturedCoefficient doubleValue];
            
            NSString *stringReplace = [NSString stringWithFormat:@"%f",replaceSign];
            
            NSString *modifiedString = [[NSString alloc] init];
            modifiedString = [mp removeCapturedPiece:arcTanOccur fromString:moddedString withString:stringReplace];
            
            moddedString = modifiedString;
            
            arcTanOccur = [is getSingleMatchWithPattern:pattern inString:modifiedString];
            
        }
        moddedString = [NSString stringWithFormat:@"(%@)",moddedString];
        return moddedString;
    } else {
        return str;
    }
    
}

- (NSString*)scanAndConvertTan:(NSString *)str withMode:(NSString *)mode {
    ISolve *is = [[ISolve alloc] init];
    MathParser *mp = [[MathParser alloc] init];
    
    NSString *pattern = [NSString stringWithFormat:@"(-?\\d?+\\.?\\d*)?[t][a][n][(](-?\\d?+\\.?\\d*)[)]"];
    
    NSString *cosOccur = [is getSingleMatchWithPattern:pattern inString:str];
    NSString *moddedString = [[NSString alloc] init];
    moddedString = str; // Set it to the original :)
    
    if (![cosOccur isEqual:@""]) {
        
        while (![cosOccur isEqual:@""]) {
            
            NSRegularExpression *secondRun = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:NULL];
            NSTextCheckingResult *match = [secondRun firstMatchInString:cosOccur options:0 range:NSMakeRange(0, [cosOccur length])];
            
            NSString *capturedLog = [cosOccur substringWithRange:[match rangeAtIndex:2]];
            NSString *capturedCoefficient = [cosOccur substringWithRange:[match rangeAtIndex:1]];
            
            double replaceSign = tan(([capturedLog doubleValue]));
            
            if ([mode isEqual:@"Degrees"]) {
                replaceSign = tan([capturedLog doubleValue]*(M_PI/180));
            }
            if ([capturedCoefficient isEqual:@""]) {
                capturedCoefficient = @"1";
            }
            
            NSString *stringReplace = [NSString stringWithFormat:@"%f",replaceSign];
            
            NSString *modifiedString = [[NSString alloc] init];
            modifiedString = [mp removeCapturedPiece:cosOccur fromString:moddedString withString:stringReplace];
            
            moddedString = modifiedString;
            
            cosOccur = [is getSingleMatchWithPattern:pattern inString:modifiedString];
            
        }
        moddedString = [NSString stringWithFormat:@"(%@)",moddedString];
        return moddedString;
    } else {
        return str;
    }

}

@end

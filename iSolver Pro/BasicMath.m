//
//  BasicMath.m
//  iSolver Pro
//
//  Created by Parker Caputo on 2/25/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "BasicMath.h"

@implementation BasicMath

- (NSString*)scanAndConvertParenthesisMultiplication:(NSString *)str {
    ISolve *is = [[ISolve alloc] init];
    MathParser *mp = [[MathParser alloc] init];
    NSString *pattern = [[NSString alloc] init];
    pattern = [NSString stringWithFormat:@"([-|+]?\\d?+\\.?\\d*)(?:[(]+?)([-|+]?\\d?+\\.?\\d*)(?:[)]+?)"];
    NSString *multOccur = [is getSingleMatchWithPattern:pattern inString:str];
    NSString *moddedString = [[NSString alloc] init];
    moddedString = str; // Set it to the original :)
    
    if (![multOccur isEqual:@""]) {
        
        while (![multOccur isEqual:@""]) {
            
            NSLog(@"Mults that occur:%@",multOccur);
            NSRegularExpression *secondRun = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:NULL];
            NSTextCheckingResult *match = [secondRun firstMatchInString:multOccur options:0 range:NSMakeRange(0, [multOccur length])];
            
            NSString *capturedCoefficient = [multOccur substringWithRange:[match rangeAtIndex:1]];
            NSString *insideParenthesis = [multOccur substringWithRange:[match rangeAtIndex:2]];
            
            if ([capturedCoefficient isEqual:@""]) {
                capturedCoefficient = @"1";
            } else if ([capturedCoefficient isEqual:@"-"]) {
                capturedCoefficient = @"-1";
            }
            
            double capCo = [capturedCoefficient doubleValue];
            double capParNum = [insideParenthesis doubleValue];
            
            capParNum = capParNum * capCo;
            
            NSString *stringReplace = [NSString stringWithFormat:@"%f",capParNum];
            
            if (capParNum >= 0) {
                stringReplace = [NSString stringWithFormat:@"+%f",capParNum];
            }
            
            NSString *modifiedString = [[NSString alloc] init];
            modifiedString = [mp removeCapturedPiece:multOccur fromString:moddedString withString:stringReplace];
            moddedString = modifiedString;
            
            multOccur = [is getSingleMatchWithPattern:pattern inString:modifiedString];
            
        }
        
        moddedString = [is evaluateBasicExpression:moddedString];
        moddedString = [NSString stringWithFormat:@"%@",moddedString];
        NSLog(@"Returned:%@",moddedString);
        return moddedString;
    } else {
        return str;
    }
}


- (NSString*)scanAndConvertScientificNotation:(NSString *)str {
    
    ISolve *is = [[ISolve alloc] init];
    MathParser *mp = [[MathParser alloc] init];
    
    NSString *sciNoOccur = [is getSingleMatchWithPattern:@"[(]?(-?\\d?+\\.?\\d*)[)]?[E][(]?(-?\\d?+\\.?\\d*)[)]?" inString:str];
    NSString *moddedString = [[NSString alloc] init];
    moddedString = str; // Set it to the original :)
    
    if (![sciNoOccur isEqual:@""]) {
        
        while (![sciNoOccur isEqual:@""]) {
            
            NSRegularExpression *secondRun = [[NSRegularExpression alloc] initWithPattern:@"[(]?(-?\\d?+\\.?\\d*)[)]?[E][(]?(-?\\d?+\\.?\\d*)[)]?" options:0 error:NULL];
            NSTextCheckingResult *match = [secondRun firstMatchInString:sciNoOccur options:0 range:NSMakeRange(0, [sciNoOccur length])];
            
            NSString *capturedCoefficient = [sciNoOccur substringWithRange:[match rangeAtIndex:1]];
            NSString *exponet = [sciNoOccur substringWithRange:[match rangeAtIndex:2]];
            
            double capCo = [capturedCoefficient doubleValue];
            double capExpo = [exponet doubleValue];
            
            NSString *tmpString = [NSString stringWithFormat:@"%fe%f",capCo, capExpo];
            
            NSDecimalNumber *replaceNumber = [NSDecimalNumber decimalNumberWithString:tmpString];
            
            NSString *stringReplace = [NSString stringWithFormat:@"%@",replaceNumber];
            
            NSString *modifiedString = [[NSString alloc] init];
            modifiedString = [mp removeCapturedPiece:sciNoOccur fromString:moddedString withString:stringReplace];
            
            moddedString = modifiedString;
            
            sciNoOccur = [is getSingleMatchWithPattern:@"[(]?(-?\\d?+\\.?\\d*)[)]?[E][(]?(-?\\d?+\\.?\\d*)[)]?" inString:modifiedString];
            
        }
        moddedString = [NSString stringWithFormat:@"%@",moddedString];
        return moddedString;
    } else {
        return str;
    }
}

- (NSString*)scanAndConvertSquareRoot:(NSString *)str {
    
    ISolve *is = [[ISolve alloc] init];
    MathParser *mp = [[MathParser alloc] init];
    NSString *pattern = [[NSString alloc] init];
    pattern = [NSString stringWithFormat:@"(-?\\d?+\\.?\\d*)[s][q][r][t][(](-?\\d?+\\.?\\d*)[)]"];
    
    NSString *radOccur = [is getSingleMatchWithPattern:pattern inString:str];
    NSString *moddedString = [[NSString alloc] init];
    moddedString = str; // Set it to the original :)
    
    if (![radOccur isEqual:@""]) {
        
        while (![radOccur isEqual:@""]) {
            
            NSRegularExpression *secondRun = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:NULL];
            NSTextCheckingResult *match = [secondRun firstMatchInString:radOccur options:0 range:NSMakeRange(0, [radOccur length])];
            
            NSString *capturedCoefficient = [radOccur substringWithRange:[match rangeAtIndex:1]];
            NSString *radical = [radOccur substringWithRange:[match rangeAtIndex:2]];
            
            if ([capturedCoefficient isEqual:@""]) {
                capturedCoefficient = @"1";
            }
            
            double capCo = [capturedCoefficient doubleValue];
            double capRad = [radical doubleValue];
            
            capRad = sqrt(capRad) * capCo;
            
            NSString *stringReplace = [NSString stringWithFormat:@"%f",capRad];
            
            NSString *modifiedString = [[NSString alloc] init];
            modifiedString = [mp removeCapturedPiece:radOccur fromString:moddedString withString:stringReplace];
            
            moddedString = modifiedString;
            
            radOccur = [is getSingleMatchWithPattern:pattern inString:modifiedString];
            
        }
        moddedString = [NSString stringWithFormat:@"%@",moddedString];
        return moddedString;
    } else {
        return str;
    }
    
}

- (NSString*)scanAndConvertMultplicationAndDivision:(NSString *)str {
    
    ISolve *is = [[ISolve alloc] init];
    MathParser *mp = [[MathParser alloc] init];
    NSString *pattern = [NSString stringWithFormat:@"(?:(?:[(]?(-?\\d?+\\.?\\d*)[)]?[\\/][(]?(-?\\d?+\\.?\\d*)[)]?)|(?:[(]?(-?\\d?+\\.?\\d*)[)]?[*][(]?(-?\\d?+\\.?\\d*)[)]?))"];
    
    NSString *multiplyDivide = [is getSingleMatchWithPattern:pattern inString:str];
    
    NSString *moddedString = [[NSString alloc] init];
    moddedString = str; // Set it to the original :)
    
    if (![multiplyDivide isEqual:@""]) {
        
        while (![multiplyDivide isEqual:@""]) {
            
            NSRegularExpression *secondRun = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:NULL];
            NSTextCheckingResult *match = [secondRun firstMatchInString:multiplyDivide options:0 range:NSMakeRange(0, [multiplyDivide length])];
            
            double replaceNumber = 0;
            
            if (!([match rangeAtIndex:1].location == NSNotFound) && !([match rangeAtIndex:2].location == NSNotFound)) { // Then divison is first
                
                NSString *numerator = [multiplyDivide substringWithRange:[match rangeAtIndex:1]];
                NSString *denominator = [multiplyDivide substringWithRange:[match rangeAtIndex:2]];
                
                double num = [numerator doubleValue]; double denom = [denominator doubleValue];
                replaceNumber = num/denom;
                
                
            } else if (!([match rangeAtIndex:3].location == NSNotFound) && !([match rangeAtIndex:4].location == NSNotFound)) { // Then multiplication is first
                
                NSString *t1 = [multiplyDivide substringWithRange:[match rangeAtIndex:3]];
                NSString *t2 = [multiplyDivide substringWithRange:[match rangeAtIndex:4]];
                
                double tOne = [t1 doubleValue]; double tTwo = [t2 doubleValue];
                replaceNumber = tOne * tTwo;
            }
            
            NSString *stringReplace = [NSString stringWithFormat:@"%f",replaceNumber];
            
            NSString *modifiedString = [[NSString alloc] init];
            NSLog(@"This is gay");
            modifiedString = [mp removeCapturedPiece:multiplyDivide fromString:moddedString withString:stringReplace];
            
            moddedString = modifiedString;
            
            multiplyDivide = [is getSingleMatchWithPattern:pattern inString:modifiedString];
            
        }
        moddedString = [NSString stringWithFormat:@"%@",moddedString];
        return moddedString;
    } else {
        return str;
    }
}

- (NSString*)scanAndConvertAdditionSubtraction:(NSString *)str {
    ISolve *is = [[ISolve alloc] init];
    MathParser *mp = [[MathParser alloc] init];
    NSString *pattern = [NSString stringWithFormat:@"(?:(?:[(]?(\\d?+\\.?\\d*)[)]?[+][(]?(\\d?+\\.?\\d*)[)]?)|(?:[(]?(\\d?+\\.?\\d*)[)]?[-][(]?(\\d?+\\.?\\d*)[)]?))"];
    
    NSString *addSubtract = [is getSingleMatchWithPattern:pattern inString:str];
    
    NSString *moddedString = [[NSString alloc] init];
    moddedString = str; // Set it to the original :)
    
    if (![addSubtract isEqual:@""]) {
        
        while (![addSubtract isEqual:@""]) {
            
            NSRegularExpression *secondRun = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:NULL];
            NSTextCheckingResult *match = [secondRun firstMatchInString:addSubtract options:0 range:NSMakeRange(0, [addSubtract length])];
            
            double replaceNumber = 0;
            
            if (!([match rangeAtIndex:1].location == NSNotFound) || !([match rangeAtIndex:2].location == NSNotFound)) { // Then addition first
                
                NSString *t1 = [addSubtract substringWithRange:[match rangeAtIndex:1]];
                NSString *t2 = [addSubtract substringWithRange:[match rangeAtIndex:2]];
                
                double num = [t1 doubleValue]; double denom = [t2 doubleValue];
                replaceNumber = num+denom;
                
                
                
            } else if (!([match rangeAtIndex:3].location == NSNotFound) || !([match rangeAtIndex:4].location == NSNotFound)) { // Then subtraction first
                
                NSString *t1 = [addSubtract substringWithRange:[match rangeAtIndex:3]];
                NSString *t2 = [addSubtract substringWithRange:[match rangeAtIndex:4]];
                
                
                double tOne = [t1 doubleValue]; double tTwo = [t2 doubleValue];
                replaceNumber = tOne-tTwo;
                
            } else {
                
            }
            
            NSString *stringReplace = [NSString stringWithFormat:@"%f",replaceNumber];
            
            NSLog(@"Replace w/:%@",stringReplace);
            
            NSString *modifiedString = [[NSString alloc] init];
            modifiedString = [mp removeCapturedPiece:addSubtract fromString:moddedString withString:stringReplace];
            NSLog(@"Modded string:%@",moddedString);
            moddedString = modifiedString;
            
            
            addSubtract = [is getSingleMatchWithPattern:pattern inString:modifiedString];
            
        }
        moddedString = [NSString stringWithFormat:@"%@",moddedString];
        return moddedString;
    } else {
        return str;
    }
}

@end

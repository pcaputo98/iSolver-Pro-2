//
//  iExponet.h
//  iSolver Pro
//
//  Created by Parker Caputo on 1/15/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iExponet : NSObject {
    NSString *sign;
    double coefficient;
    double xTerm;
    double power;
}
@property NSString *sign;
@property double coefficient;
@property double xTerm;
@property double power;

@end

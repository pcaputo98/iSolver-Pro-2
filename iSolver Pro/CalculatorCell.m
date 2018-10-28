//
//  CalculatorCell.m
//  iSolver Pro
//
//  Created by Parker Caputo on 3/2/15.
//  Copyright (c) 2015 Pumplead Studios LLC. All rights reserved.
//

#import "CalculatorCell.h"

@implementation CalculatorCell

@synthesize equation, answer;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

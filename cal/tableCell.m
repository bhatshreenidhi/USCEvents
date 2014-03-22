//
//  tableCell.m
//  cal
//
//  Created by Shreenidhi Bhat on 3/21/14.
//  Copyright (c) 2014 Shreenidhi Bhat. All rights reserved.
//

#import "tableCell.h"


@implementation tableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

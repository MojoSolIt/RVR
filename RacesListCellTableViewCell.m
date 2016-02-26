//
//  RacesListCellTableViewCell.m
//  RVR
//
//  Created by Muhammad Faraz on 24/02/2016.
//  Copyright © 2016 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import "RacesListCellTableViewCell.h"


@implementation RacesListCellTableViewCell

@synthesize Description,start_date,end_date,remaing_days,Name;



- (void)awakeFromNib

{
    // Initialization code
}

- (id)initWithStyle:(UITableViewStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
        
        
    {
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

//
//  RacesListCellTableViewCell.h
//  RVR
//
//  Created by Muhammad Faraz on 24/02/2016.
//  Copyright © 2016 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RacesListCellTableViewCell : UITableViewCell



@property(nonatomic,weak)IBOutlet UILabel *Name;
@property(nonatomic,weak)IBOutlet UILabel *Description;
@property(nonatomic,weak)IBOutlet UILabel *start_date;
@property(nonatomic,weak)IBOutlet UILabel *end_date;
@property(nonatomic,weak)IBOutlet UILabel *remaing_days;


@end

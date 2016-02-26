//
//  RacesListViewController.h
//  RVR
//
//  Created by Muhammad Faraz on 24/02/2016.
//  Copyright © 2016 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RacesListCellTableViewCell.h"
#import "RacesList.h"

@interface RacesListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *JSONARRAY;
@property (nonatomic,strong) NSMutableArray *RacesArray;

@property (strong, nonatomic) IBOutlet UITableView *RaceslistTableView;


-(void)retrievedata;




@end

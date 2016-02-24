//
//  BasicInfoViewController.h
//  RVR
//
//  Created by Muhammad Faraz on 06/02/2016.
//  Copyright © 2016 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import <DownPicker/DownPicker.h>

//#import <DownPicker 5.56.22 AM/>

@interface BasicInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UIButton *selectGender;
@property (weak, nonatomic) IBOutlet UITableView *genderDropDown;
@property(copy, nonatomic)NSArray *genderData;
- (IBAction)selectGenderAction:(id)sender;


@end

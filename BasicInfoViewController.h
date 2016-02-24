//
//  BasicInfoViewController.h
//  RVR
//
//  Created by Muhammad Faraz on 06/02/2016.
//  Copyright © 2016 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIDownPicker.h>


//#import <DownPicker/DownPicker.h>

//#import <DownPicker 5.56.22 AM/>

@interface BasicInfoViewController : UIViewController





@property (weak, nonatomic) IBOutlet UITextField *distancetxtField;
@property (weak, nonatomic) IBOutlet UITextField *gendertxtField;
@property (weak, nonatomic) IBOutlet UITextField *agetxtField;


@property (nonatomic) DownPicker *distancePicker;
@property (nonatomic) DownPicker *genderPicker;
@property (nonatomic) DownPicker *agePicker;
- (IBAction)saveMyInfo:(id)sender;

@end

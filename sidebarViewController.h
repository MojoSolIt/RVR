//
//  sidebarViewController.h
//  KidFit
//
//  Created by Muhammad Faraz on 24/11/2015.
//  Copyright © 2015 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <UIKit/UIKit.h>

@interface sidebarViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIButton *Logout;



-(IBAction)Logout:(id)sender;


@property (strong,nonatomic)NSString *UserImageTextv ;
@property (strong,nonatomic)NSString *UserNameTextv;



@end

//
//  LeadershipBoardViewController.m
//  RVR
//
//  Created by Muhammad Faraz on 04/02/2016.
//  Copyright © 2016 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import "LeadershipBoardViewController.h"
#import "SWRevealViewController.h"

@interface LeadershipBoardViewController ()

@end

@implementation LeadershipBoardViewController

- (void)viewDidLoad


{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
        
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    UITabBarController *tabBarController = (UITabBarController *)self.tabBarController;
    [tabBarController.tabBar setTintColor:[UIColor whiteColor]];
    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

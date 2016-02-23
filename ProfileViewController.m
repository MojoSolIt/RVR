//
//  ProfileViewController.m
//  RVR
//
//  Created by Muhammad Faraz on 05/02/2016.
//  Copyright © 2016 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import "ProfileViewController.h"
#import "SWRevealViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize name;

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
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    NSString *currentLevelKey = @"currentlevel";
    
    if ([preferences objectForKey:currentLevelKey] == nil)
    {
        
        
        
    }
    else
    {
        //  Get current level
        
        NSString *currentLevel = [preferences stringForKey:@"name"];
        
        name.text = currentLevel;
    }

}

- (void)didReceiveMemoryWarning


{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}









-(void)viewWillAppear:(BOOL)animated

{
    
    
    // [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    
    NSString *nameL = [ preferences
                       stringForKey:@"name"];
   
    self.name.text=nameL;
   
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    [super viewWillAppear:YES];
}


@end

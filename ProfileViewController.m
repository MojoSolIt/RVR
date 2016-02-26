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

@property(weak,nonatomic)NSString *profileImageUrl;

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
    NSUserDefaults *preferencesImage = [NSUserDefaults standardUserDefaults];
    self.profileImageUrl = [preferencesImage stringForKey:@"picture"];
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

    

    
    
    
    NSURL *url = [NSURL URLWithString:self.profileImageUrl];
    
    NSData *data = [NSMutableData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    
    
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
    self.profileImage.clipsToBounds = YES;
    self.profileImage.layer.borderWidth = 1.0f;
    self.profileImage.layer.cornerRadius = 30.0f;
    self.profileImage.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.profileImage.image = image;
    
    
    
    
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

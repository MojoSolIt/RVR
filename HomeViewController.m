//
//  HomeViewController.m
//  RVR
//
//  Created by Muhammad Faraz on 04/02/2016.
//  Copyright © 2016 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import "HomeViewController.h"
#import "sidebarViewController.h"


@interface HomeViewController ()

@end

@implementation HomeViewController

NSString *nameOfLoginUser  ,*imageStringOfLoginUser;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning

{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    UITabBarController *tabBarController = (UITabBarController *)self.tabBarController;
    [tabBarController.tabBar setTintColor:[UIColor whiteColor]];
    
}

-(void)viewWillAppear:(BOOL)animated


{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:YES];
}


- (IBAction)SocailLogin:(id)sender

{
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult  *result, NSError *error)
    
    {
         if (error)
         
         {
             NSLog(@"Process error");
         } else if (result.isCancelled)
         
         {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
[self performSegueWithIdentifier:@"social_login" sender:self];
             
             
             if ([FBSDKAccessToken currentAccessToken]) {
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields" : @"id,name,picture.width(100).height(100)"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                     if (!error) {
                       
                         nameOfLoginUser = [result valueForKey:@"name"];
                         imageStringOfLoginUser = [[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"];
                         
                         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                         [defaults setValue:nameOfLoginUser forKey:@"name"];
                         [defaults setValue:imageStringOfLoginUser forKey:@"picture"];

                         
                     }
                 }];
             }
             
         }
        
     }];
  
    
    
    
    
}



- (IBAction)howItWork:(UIButton *)sender {
    NSString *myurl=@"https://www.google.com";
    NSURL *url = [NSURL URLWithString:myurl];
    [[UIApplication sharedApplication] openURL:url];
}

@end

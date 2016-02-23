//
//  TermsnConditionsViewController.m
//  RVR
//
//  Created by Muhammad Faraz on 04/02/2016.
//  Copyright © 2016 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import "TermsnConditionsViewController.h"

@interface TermsnConditionsViewController ()

@end

@implementation TermsnConditionsViewController

- (void)viewDidLoad


{
    [super viewDidLoad];
    
    
    self.title=@"Terms & Conditions";
    [self.myScrollView setContentSize:CGSizeMake(320, 568)];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated


{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [super viewWillAppear:YES];
}

@end

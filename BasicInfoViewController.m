//
//  BasicInfoViewController.m
//  RVR
//
//  Created by Muhammad Faraz on 06/02/2016.
//  Copyright © 2016 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import "BasicInfoViewController.h"

@interface BasicInfoViewController ()


@end

@implementation BasicInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    
    NSArray *distanceUnit = @[@"Miles", @"Kilometers"];
    self.distancePicker = [[DownPicker alloc] initWithTextField:self.distancetxtField withData:distanceUnit];
    
    NSArray *gender = @[@"Male", @"Female"];
    self.genderPicker = [[DownPicker alloc] initWithTextField:self.gendertxtField withData:gender];

    
    
    NSArray *ageArray = @[@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",@"60",@"61",@"62",@"63",@"64",@"65",@"66",@"67",@"68",@"69",@"70",@"71",@"72",@"73",@"74",@"75",@"76",@"77",@"78",@"79",@"80",@"81",@"82",@"83",@"84",@"85",@"86",@"87",@"88",@"89",@"90",@"91",@"92",@"93",@"94",@"95",@"96",@"97",@"98",@"99",@"100"];
    
    self.agePicker = [[DownPicker alloc] initWithTextField:self.agetxtField withData:ageArray];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animate
{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    
    [super viewWillAppear:YES];
    
}


- (IBAction)saveMyInfo:(id)sender
{
    
    if ([self.gendertxtField.text  isEqual:@""])
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Gender not selected"
                                                                       message:@"Please select a gender "
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
    
    else if ([self.distancetxtField.text  isEqual:@""])
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Distance Unit not selected"
                                                                       message:@"Please select a distance unit "
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ([self.agetxtField.text  isEqual:@""])
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Age not selected"
                                                                       message:@"Please select age "
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
    [self performSegueWithIdentifier:@"gototabview" sender:self];
}
@end

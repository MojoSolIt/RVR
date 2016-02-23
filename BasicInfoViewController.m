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
    // Do any additional setup after loading the view.
    
    
    
//    NSArray *el = @[@"Miles.", @"Kilometer"];
//    self.picker = [[DownPicker alloc] initWithTextField:self.textField withData:el];
//    
//    NSArray *el2 = @[@"Male", @"Female"];
//    self.picker2 = [[DownPicker alloc] initWithTextField:self.textField2 withData:el2];
//    
//    NSArray *el3 = @[@"15",@"16",@"17",@"18",@"19",@"20"];
//    
//    (void)[self.downPicker initWithData:el3];
//    
//    NSArray *el4 = @[@"Dream Theater", @"Stratovarius", @"Tool", @"A Perfect Circle", @"Shadow Gallery"];
//    (void)[self.downPicker2 initWithData:el4];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//
//- (IBAction)distanceUnit:(id)sender
//{
//    NSArray *distanceUnit = @[@"name",@"logout"];
//    [sender distanceUnit:self];
//}
@end

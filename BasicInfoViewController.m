//
//  BasicInfoViewController.m
//  RVR
//
//  Created by Muhammad Faraz on 06/02/2016.
//  Copyright © 2016 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import "BasicInfoViewController.h"

@interface BasicInfoViewController ()
@property (weak, nonatomic) IBOutlet UIView *genderView;

@end

@implementation BasicInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.genderData = [[NSArray alloc]initWithObjects:@"Male",@"Female", nil];
    
    self.genderDropDown.delegate=self;
    self.genderDropDown.dataSource=self;
    self.genderDropDown.hidden=YES;
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    // Return the number of rows in the section.
    return self.genderData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier =@"simpleTableIdentifier";
    UITableViewCell *cell;
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }

    cell.textLabel.text = self.genderData[indexPath.row];
    return cell;
    

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    UITableViewCell *cell = [self.genderDropDown cellForRowAtIndexPath:indexPath];
    [self.selectGender setTitle:cell.textLabel.text forState:UIControlStateNormal];
    
    
    self.genderDropDown.hidden=YES;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row;
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

//
//{
//    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    cell.backgroundColor  = [UIColor clearColor];
//    cell.textLabel.textColor = [UIColor orangeColor];
//    
//    if ([CellIdentifier isEqualToString:@"fullname"])
//    {
//        cell = [tableView dequeueReusableCellWithIdentifier:[menuItems objectAtIndex:0]];
//        
//        cell.backgroundColor  = [UIColor clearColor];
//
//        
//    }
//    return cell;
//}




- (IBAction)selectGenderAction:(id)sender
{
    if (self.genderDropDown.hidden==YES)
    {
        
        self.genderDropDown.hidden=NO;
    }
    else
    {
        self.genderDropDown.hidden=YES;
        
        
    }
}
@end

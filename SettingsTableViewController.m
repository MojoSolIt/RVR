//
//  SettingsTableViewController.m
//  RVR
//
//  Created by Muhammad Faraz on 06/02/2016.
//  Copyright © 2016 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "SWRevealViewController.h"
#import "sidebarViewController.h"
#import "HomeViewController.h"

@interface SettingsTableViewController ()

@property(strong,nonatomic)NSString *userName;
@property(strong,nonatomic)NSString *userPicture;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation SettingsTableViewController

{
    NSArray *menuItems;
   // NSString *userName;
    
}


- (void)viewDidLoad

{
    [super viewDidLoad];
    
    menuItems = @[@"fullname",@"gender",@"distance",@"location",@"aboutrvr"];

    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
        
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.jpg"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    
    UITabBarController *tabBarController = (UITabBarController *)self.tabBarController;
    [tabBarController.tabBar setTintColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning

{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    // Return the number of rows in the section.
    return menuItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath


{
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor  = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor orangeColor];
    
    if ([CellIdentifier isEqualToString:@"fullname"])
    {
        cell = [tableView dequeueReusableCellWithIdentifier:[menuItems objectAtIndex:0]];
        
        cell.backgroundColor  = [UIColor clearColor];
        NSUserDefaults *prefrecense = [NSUserDefaults standardUserDefaults];
        
        self.userName = [prefrecense  stringForKey:@"name"];
  
        cell.textLabel.text = @"Full Name";
        cell.detailTextLabel.text = self.userName;

        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    return cell;
}


//{
//    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
//
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    UITableViewCell *cell1;
//    UITableViewCell *cell2;
//    
//    //cell.backgroundColor = cell.contentView.backgroundColor;
//    
//    
//    
//    if ([CellIdentifier isEqualToString:@"fullname"])
//    {
//        
//        
//        cell1= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[menuItems objectAtIndex:0]];
//       
//   
//        NSUserDefaults *prefrecense = [NSUserDefaults standardUserDefaults];
//        
//    self.userName = [prefrecense stringForKey:@"name"];
//       // self.userPicture = [prefrecense stringForKey:@"picture"];
//       // self.userNameLabel.text = self.userName;
//   cell1.backgroundColor = cell1.contentView.backgroundColor;
//        
//        
//        cell1.textLabel.text = @"Full Name";
//        //cell.textLabel.textColor = [UIColor colorWithHue:.255 saturation:.267 brightness:1.0 alpha:0.1];
//        //cell.detailTextLabel.textColor = [ UIColor colorWithHue:.255 saturation:.267 brightness:1.0 alpha:0.1];
//        cell1.detailTextLabel.text = self.userName;
//        //cell.textLabel.textColor = [UIColor orangeColor];
//        //cell.textLabel.textAlignment = [];
//        
//        
//        //return cell1;
////
////        NSURL *url = [NSURL URLWithString:self.userPicture];
////        
////        NSData *data = [NSMutableData dataWithContentsOfURL:url];
////        UIImage *image = [UIImage imageWithData:data];
////
////        
////        
////        cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width / 2;
////        cell.imageView.clipsToBounds = YES;
////        cell.imageView.layer.borderWidth = 1.0f;
////        cell.imageView.layer.cornerRadius = 40.0f;
////        cell.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
////        
////        cell.imageView.image = image;
//
//    
//        return cell1;

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    [self.tabBarController setSelectedIndex:1];
    
    
}


 
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 
 
 {
 
// if (indexPath.row == 0){
// return 60.0;
// }
// else  if (indexPath.row == 1){
// return 70.0;
// }
// else  if (indexPath.row == 2){
// return 70.0;
// }
// else  if (indexPath.row == 3){
// return 70.0;
// }
// else  if (indexPath.row == 4){
// return 70.0;
// }
// else
 return 80.0;
 }

 
 
 
 
 
@end

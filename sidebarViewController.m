//
//  sidebarViewController.m
//  KidFit
//
//  Created by Muhammad Faraz on 24/11/2015.
//  Copyright © 2015 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import "sidebarViewController.h"
#import "SWRevealViewController.h"
#import "HomeViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface sidebarViewController ()


@end

@implementation sidebarViewController


{
    NSArray *menuItems;

}

@synthesize Logout;


@synthesize UserNameTextv,UserImageTextv;


- (void)viewDidLoad

{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    menuItems = @[@"name",@"races",@"profile",@"settings",@"logout"];
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.jpg"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    

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
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if ([CellIdentifier isEqualToString:@"name"])
    {
        cell = [tableView dequeueReusableCellWithIdentifier:[menuItems objectAtIndex:0]];
       

        NSUserDefaults *prefrecense = [NSUserDefaults standardUserDefaults];
        
        UserNameTextv = [prefrecense  stringForKey:@"name"];
        UserImageTextv = [prefrecense stringForKey:@"picture"];
        
        
        
        
        cell.textLabel.text = UserNameTextv;
       // cell.textLabel.textColor = [UIColor colorWithCGColor:@"BE9B3A"];
        cell.textLabel.textColor = [UIColor whiteColor];


        
        NSURL *url = [NSURL URLWithString:UserImageTextv];
        
        NSData *data = [NSMutableData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];

        
        
        cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width / 2;
        cell.imageView.clipsToBounds = YES;
        cell.imageView.layer.borderWidth = 1.0f;
        cell.imageView.layer.cornerRadius = 40.0f;
        cell.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        
        cell.imageView.image = image;


        

        
        
        


   
    }
    
    return cell;
}









-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
        [self.tabBarController setSelectedIndex:1];
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath


{
    
    if (indexPath.row == 0){
        return 85.0;
    }
    else  if (indexPath.row == 1){
        return 70.0;
    }
    else  if (indexPath.row == 2){
        return 70.0;
    }
    else  if (indexPath.row == 3){
        return 70.0;
    }
    else  if (indexPath.row == 4){
        return 70.0;
    }
        else
        return 85.0;
}

    



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{
    
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    
    destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    // Set the photo if it navigates to the PhotoView
    if ([segue.identifier isEqualToString:@"show"])
        
    {
        UINavigationController *navController = segue.destinationViewController;
        
        HomeViewController *homeController = [navController childViewControllers].firstObject;
        
//NSString *photoFilename = [NSString stringWithFormat:@"%@_photo", [menuItems objectAtIndex:indexPath.row]];
        
        //homeController.photoFilename = photoFilename;
    }
}


-(void)viewWillAppear:(BOOL)animated


{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:YES];
}


@end

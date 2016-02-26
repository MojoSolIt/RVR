//
//  RacesListViewController.m
//  RVR
//
//  Created by Muhammad Faraz on 24/02/2016.
//  Copyright © 2016 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import "RacesListViewController.h"
#import "RacesListCellTableViewCell.h"
#import "RacesList.h"


#define JSON_URL @"http://mojosol.com/mojodev/RVR/Info.php"

@interface RacesListViewController ()

@end

@implementation RacesListViewController

@synthesize RaceslistTableView,RacesArray,JSONARRAY;

- (void)viewDidLoad

{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.jpg"]];
    [tempImageView setFrame:self.RaceslistTableView.frame];
    
    self.RaceslistTableView.backgroundView = tempImageView;
    
    self.RaceslistTableView.delegate = self;
    self.RaceslistTableView.dataSource = self;
    

    
    [self retrievedata];

     
}

- (void)didReceiveMemoryWarning

{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.RacesArray count];
    
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//
//    if(tableView  == self.searchDisplayController.searchResultsTableView) {
//        self.mSelectedCat = self.filteredArrayList[indexPath.row];    }
//    else {
//        self.mSelectedCat = self.playlistARRAY[indexPath.row];
//    }
//
//    [self performNavigation];
//    //   self.selected = self.nearbyVenues[indexPath.row];
//    // [self performSegueWithIdentifier:@"detail" sender:self.view];
//
//}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *simpleTableIdentifier = @"cell";
    
    NSLog(@"Custom Cell is Working:%@",RacesArray);
    
    RacesListCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if(cell == nil)
    
    {
        //cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    }
    cell.backgroundColor = cell.contentView.backgroundColor;
    
        RacesList *raceobject = RacesArray[indexPath.row];
    
    
    
    //cell.textLabel.text = raceobject.RaceId;
    cell.Name.text=raceobject.RaceName;
    cell.Description.text=raceobject.RaceDescription;
    cell.start_date.text=raceobject.Racestart_date;
    cell.end_date.text=raceobject.Raceend_date;
    cell.remaing_days.text=raceobject.Raceremaing_days;

    
  // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}





//- (void)performNavigation
//
//{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    PlaylistViewController *venueDetail = [storyboard instantiateViewControllerWithIdentifier:@"preMixedCat"];
//    venueDetail.title =self.mSelectedCat.PreMixMusCatname;
//    venueDetail.catID = self.mSelectedCat.PreMixMusCatid;
//    [self.navigationController pushViewController:venueDetail animated:YES];
//}


-(void)retrievedata
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Loading" message:@"Please Wait" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        NSURL *url = [NSURL URLWithString:JSON_URL ];
        NSData *data =[NSData dataWithContentsOfURL:url];
        
        JSONARRAY = [[NSJSONSerialization JSONObjectWithData:data options:(kNilOptions) error:nil] valueForKey:@"races"];
        
        RacesArray=[[NSMutableArray alloc]init];
        
        int i = 0;
        for (NSDictionary *races in JSONARRAY)
            
        {
            if(JSONARRAY.count!=i+1)
                
            {
                NSString *Id = races [@"races_id"];
                NSString *Name = races[@"races_name"];
                NSString *Description = races[@"description"];
                NSString *start_date = races[@"start_date"];
                NSString *end_date = races[@"end_date"];
                NSString *remaing_days = races[@"remaing_days"];
                

                
    [RacesArray addObject:[[RacesList alloc] initwithId:Id Name:Name Description:Description start_date:start_date end_date:end_date remaing_days:remaing_days]];
                i++;
    
               
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{ // 2
            [alert dismissWithClickedButtonIndex:alert.cancelButtonIndex animated:YES];
            
            [self.RaceslistTableView reloadData];
        });
        
        // filteredArrayList = [NSMutableArray arrayWithCapacity:[playlistARRAY count]];
    });
    
}




@end

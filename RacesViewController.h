//
//  RacesViewController.h
//  RVR
//
//  Created by Muhammad Faraz on 04/02/2016.
//  Copyright © 2016 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MZTimerLabel.h"
#import "Location.h"
//#import "Workout.h"


@interface RacesViewController : UIViewController <MKMapViewDelegate,MZTimerLabelDelegate>

{
  MZTimerLabel *timer4;
}


@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UILabel *DistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *Time;
@property (weak, nonatomic) IBOutlet UILabel *Pace;
@property (weak, nonatomic) IBOutlet UIButton *Miles;
@property (weak, nonatomic) IBOutlet UILabel *MilesKm;
@property (weak, nonatomic) IBOutlet UIButton *GPSenable;
@property (weak, nonatomic) IBOutlet UIButton *StartRun;
@property (weak, nonatomic) IBOutlet UIButton *PauseRun;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Location *locations;







-(IBAction)Miles:(id)sender;
-(IBAction)GPSenable:(id)sender;
-(IBAction)StartRun:(id)sender;
-(IBAction)PauseRun:(id)sender;

@end

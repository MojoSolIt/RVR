//
//  RacesViewController.m
//  RVR
//
//  Created by Muhammad Faraz on 04/02/2016.
//  Copyright © 2016 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import "RacesViewController.h"
#import "SWRevealViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "MZTimerLabel.h"
#import "AppDelegate.h"
#import "Location.h"
#import "MathController.h"
#import "Run.h"
#import "MultiColorPolyline.h"
#import "Badge.h"
#import "BadgeController.h"
#import "BadgeAnnotation.h"
#import "ActivityViewController.h"


static NSString * const detailSegueName = @"RunDetails";

@interface RacesViewController () <CLLocationManagerDelegate,UIActionSheetDelegate,MKMapViewDelegate>

@property (strong, nonatomic) NSArray *runArray;
@property int seconds;
@property float distance;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) Run *run;

@end

@implementation RacesViewController

@synthesize mapView,locationManager,DistanceLabel,Time,Pace,GPSenable,Miles,StartRun,locations;

bool Miles=false,GPSenable=false,StartRun=false;




- (void)viewDidLoad

{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        self.StartRun.hidden=NO;
    self.PauseRun.hidden=YES;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    _managedObjectContext = [appDelegate managedObjectContext];
    
    timer4 = [[MZTimerLabel alloc] initWithLabel:Time andTimerType:MZTimerLabelTypeStopWatch];
    timer4.timeFormat = @"HH:mm:ss SS";
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        
    {
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined )
            
        {
            // We never ask for authorization. Let's request it.
            [self.locationManager requestWhenInUseAuthorization];
        } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse ||
                   [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)
        {
            // We have authorization. Let's update location.
            [self.locationManager startUpdatingLocation];
        } else {
            // If we are here we have no pormissions.
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No athorization"
                                                                message:@"Please, enable access to your location"
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"Open Settings", nil];
            [alertView show];
        }
    } else {
        // This is iOS 7 case.
        [self.locationManager startUpdatingLocation];
    }

    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
        
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
     self.mapView.delegate = self;
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    mapView.showsCompass = YES;
    mapView.rotateEnabled = YES;
    
    }

- (void)didReceiveMemoryWarning


{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error

{
    NSLog(@"Location manager did fail with error %@", error);
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status

{
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse)
    
    {
        [manager startUpdatingLocation];
    }
}




- (void)setupMapForLocatoion:(CLLocation *)newLocation

{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.010;
    span.longitudeDelta = 0.010;
    CLLocationCoordinate2D location;
    location.latitude = newLocation.coordinate.latitude;
    location.longitude = newLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [self.mapView setRegion:region animated:YES];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation

{
    [self.locationManager stopUpdatingLocation];
   
    [self setupMapForLocatoion:newLocation];
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
    float spanX = 0.00125;
    float spanY = 0.00125;
    MKCoordinateRegion region;
    region.center.latitude = self.mapView.userLocation.coordinate.latitude;
    region.center.longitude = self.mapView.userLocation.coordinate.longitude;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    
    [self.mapView setRegion:region animated:YES];
    [self.mapView setShowsUserLocation:YES];
}






-(void)viewWillAppear:(BOOL)animated

{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Run"inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
    [fetchRequest setSortDescriptors:@[sortDesc]];
    self.runArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
  //  Miles=false,GPSenable=false;
    
    
}



-(IBAction)Miles:(id)sender
{
    

    if (!Miles)
    
    {
        [Miles setTitle:@"Miles" forState:UIControlStateNormal];
        Miles=false;
    }
    
    else
    {
        [Miles setTitle:@"KM" forState:UIControlStateNormal];
       // Miles=true;
    }


}
-(IBAction)GPSenable:(id)sender
{
    
    if (!GPSenable)
        
    {
        [GPSenable setTitle:@"GPS Enable" forState:UIControlStateNormal];
        
        // GPSenable = true;
    }
    
    else
        
    {
        [GPSenable setTitle:@"GPS Disable" forState:UIControlStateNormal];
        
       //  GPSenable=false;
    }

}


-(IBAction)StartRun:(id)sender

{
    
    //    if (!StartRun)
//
//    {
//[StartRun setImage:[UIImage imageNamed:@"btn_start.png"] forState:UIControlStateNormal];
    
        self.seconds = 0;
        self.distance = 0;
        self.locations = [NSMutableArray array];
       
        [self startLocationUpdates];
    
        [self.mapView removeOverlays:self.mapView.overlays];
    
[self.mapView setRegion: MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.coordinate, 500, 500)];
    
     [timer4 start];
        
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateLabelsEachSecond) userInfo:nil repeats:YES];
    if ([self.StartRun isEnabled])
    {
        self.StartRun.hidden=YES;
        self.PauseRun.hidden = NO;
        
    }


 
    
    }
    
//    else
//        
//    {
//        
//        [StartRun setImage:[UIImage imageNamed:@"btn_pause.png"] forState:UIControlStateNormal];
//        [self.timer invalidate];
//        [self.locationManager stopUpdatingLocation];
//
//    }
//    
//    if([timer4 counting])
//    
//    {
//        [timer4 pause];
//         }
//    else
//    {
//        [timer4 start];
//       
//    }
//    
    
    
    
//}

- (IBAction)PauseRun:(id)sender


{
   
    
    [timer4 pause];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"RUN VIRTUAL RACES" delegate:self
                                                    cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Save", @"Discard", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
    if ([self.PauseRun isEnabled])
    {
        
        self.PauseRun.hidden=NO;
    }
    
    else
    {
        self.StartRun.hidden =YES;
    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.locationManager stopUpdatingLocation];
    
    // save
    if (buttonIndex == 0)
    
    {
        [self saveRun];
        [self performSegueWithIdentifier:detailSegueName sender:nil];
        
        // discard
    } else if (buttonIndex == 1)
    
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    
    if([timer4 counting])
        
            {
                [timer4 pause];
                 }
            else
            {
                [timer4 start];
               
            }
    
    
        
}


#pragma mark - Map / Run

- (void)saveRun

{
    Run *newRun = [NSEntityDescription insertNewObjectForEntityForName:@"Run" inManagedObjectContext:self.managedObjectContext];
    newRun.distance = [NSNumber numberWithFloat:self.distance];
    newRun.duration = [NSNumber numberWithInt:self.seconds];
    newRun.timestamp = [NSDate date];
    
    NSMutableArray *locationArr = [NSMutableArray array];
    for (CLLocation *location in self.locations)
        
    {
        Location *loc = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:self.managedObjectContext];
        loc.timestamp = location.timestamp;
        loc.latitude = [NSNumber numberWithDouble:location.coordinate.latitude];
        loc.longitude = [NSNumber numberWithDouble:location.coordinate.longitude];
        [locationArr addObject:loc];
    }
    
    newRun.locations = [NSOrderedSet orderedSetWithArray:locationArr];
    self.run = newRun;
    
    NSError *error;
    if (![self.managedObjectContext save:&error])
    {
        NSLog(@"error in saving. error msg: %@", [error userInfo]);
        abort();
    }
}



#pragma mark - Timer

- (void)updateLabelsEachSecond

{
    self.seconds++;
    
    self.Time.text = [NSString stringWithFormat:@"Time: %@", [MathController stringForSeconds:self.seconds usingLongFormat:NO]];
    self.DistanceLabel.text = [NSString stringWithFormat:@"Distance: %@", [MathController stringForDistance:self.distance]];
    self.Pace.text = [NSString stringWithFormat:@"Pace: %@", [MathController stringForAvgPaceFromDist:self.distance overTime:self.seconds]];
}



//
//#pragma mark - Location Updates
//
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
//    for (CLLocation *location in locations)
//        
//    {
//        NSDate *date = location.timestamp;
//        NSTimeInterval howRecent = [date timeIntervalSinceNow];
//        
//        if (fabs(howRecent) < 10.0 && location.horizontalAccuracy < 20 && [self.locations count] > 0)
//            
//        {
//            self.distance += [location distanceFromLocation:[self.locations lastObject]];
//            
//            CLLocationCoordinate2D coord[2];
//            CLLocation *loc = [self.locations lastObject];
//            coord[0] = loc.coordinate;
//            coord[1] = location.coordinate;
//            
//            // center map region on most recent locaiton point made and update line
//      MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500);
//            [self.mapView setRegion:region];
//            [self.mapView addOverlay:[MKPolyline polylineWithCoordinates:coord count:2]];
//        }        [self.locations addObject:location];
//    }
//}
//

- (CLLocationManager *)locationManager

{
    if (!locationManager)
    
    
    {
        locationManager = [[CLLocationManager alloc] init];
    }
    return locationManager;
}

- (void)startLocationUpdates
{
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.activityType = CLActivityTypeFitness;
    self.locationManager.distanceFilter = 10; // in meters
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startMonitoringSignificantLocationChanges];
    [self.locationManager startUpdatingLocation];
}




- (MKCoordinateRegion)mapRegion {
    MKCoordinateRegion region;
    Location *initialLoc = self.run.locations.firstObject;
    
    float minLat = initialLoc.latitude.floatValue;
    float minLng = initialLoc.longitude.floatValue;
    float maxLat = initialLoc.latitude.floatValue;
    float maxLng = initialLoc.longitude.floatValue;
    
    for (Location *location in self.run.locations) {
        if (location.latitude.floatValue < minLat) {
            minLat = location.latitude.floatValue;
        }
        if (location.longitude.floatValue < minLng) {
            minLng = location.longitude.floatValue;
        }
        if (location.latitude.floatValue > maxLat) {
            maxLat = location.latitude.floatValue;
        }
        if (location.longitude.floatValue > maxLng) {
            maxLng = location.longitude.floatValue;
        }
    }
    
    region.center.latitude = (minLat + maxLat) / 2.0f;
    region.center.longitude = (minLng + maxLng) / 2.0f;
    
    region.span.latitudeDelta = (maxLat - minLat) * 1.1f; // 10% padding
    region.span.longitudeDelta = (maxLng - minLng) * 1.1f; // 10% padding
    
    return region;
}


// if map gets request to add overlay, check it is
// MKPolyLine and make line black and width 3

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MultiColorPolyline class]]) {
        MultiColorPolyline *polyLine = (MultiColorPolyline *)overlay;
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:polyLine];
        renderer.strokeColor = polyLine.color;
        renderer.lineWidth = 5;
        return renderer;
    }
    return nil;
}

- (MKPolyline *)polyline {
    CLLocationCoordinate2D coord[self.run.locations.count];
    for (int i = 0; i < self.run.locations.count; i++) {
        Location *location = [self.run.locations objectAtIndex:i];
        coord[i] = CLLocationCoordinate2DMake(location.latitude.doubleValue, location.longitude.doubleValue);
    }
    return [MKPolyline polylineWithCoordinates:coord count:self.run.locations.count];
}

- (void)loadMap {
    if (self.run.locations.count > 0) {
        self.mapView.hidden = NO;
        [self.mapView setRegion:[self mapRegion]];
        NSArray *colorSegmentArr = [MathController colorSegmentsForLocations:self.run.locations.array];
        [self.mapView addOverlays:colorSegmentArr];
        [self.mapView addAnnotations:[[BadgeController defaultController] annotationsForRun:self.run]];
    } else {
        self.mapView.hidden = YES;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Sorry, this run has no locations saved." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation

{
    MKAnnotationView* annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                                    reuseIdentifier:@"MyCustomAnnotation"];
    annotationView.image = [UIImage imageNamed:@"map_point.png"];
    return annotationView;
    
    BadgeAnnotation *badgeAnnotation = (BadgeAnnotation *)annotation;
    MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"checkpt"];
    
    if (!annoView)
    
    {
        annoView = [[MKAnnotationView alloc] initWithAnnotation:badgeAnnotation reuseIdentifier:@"checkpt"];
        annoView.image = [UIImage imageNamed:@"map_point.png"];
        annoView.canShowCallout = YES;
    }
    
    UIImageView *badgeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 75, 50)];
    badgeImageView.image = [UIImage imageNamed:badgeAnnotation.imageName];
    badgeImageView.contentMode = UIViewContentModeScaleAspectFit;
    annoView.leftCalloutAccessoryView = badgeImageView;
    
    return annoView;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{
    [[segue destinationViewController] setRun:self.run];
}










@end

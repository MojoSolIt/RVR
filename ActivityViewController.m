//
//  ActivityViewController.m
//  RVR
//
//  Created by Muhammad Faraz on 06/02/2016.
//  Copyright © 2016 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import "ActivityViewController.h"
#import <Social/Social.h>
#import <MapKit/MapKit.h>
#import "MathController.h"
#import "Run.h"
#import "Location.h"
#import "MultiColorPolyline.h"
#import "Badge.h"
//#import "BadgeController.h"
#import "BadgeAnnotation.h"
#import "AppDelegate.h"
#import "SWRevealViewController.h"

@interface ActivityViewController ()

@end

@implementation ActivityViewController

@synthesize locationManager,mapView,managedObjectContext,sidebarButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
        
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    
    
    self.title=@"ACTIVITY";
    
    [self configureView];
    
}

- (void)didReceiveMemoryWarning

{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Managing map

- (void)setRun:(Run *)run

{
    if (_run != run)
    
    {
        _run = run;
        [self configureView];
    }
}

- (void)configureView

{
    self.mapView.delegate = self;
    self.distanceLabel.text = [MathController stringForDistance:self.run.distance.floatValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    self.dateLabel.text = [formatter stringFromDate:self.run.timestamp];
    self.timeLabel.text = [NSString stringWithFormat:@" %@", [MathController stringForSeconds:self.run.duration.intValue usingLongFormat:YES]];
    self.paceLabel.text = [NSString stringWithFormat:@" %@", [MathController stringForAvgPaceFromDist:self.run.distance.floatValue overTime:self.run.duration.intValue]];
   
    //[self loadMap];
    
   
}

//
//- (MKCoordinateRegion)mapRegion
//
//{
//    MKCoordinateRegion region;
//    Location *initialLoc = self.run.locations.firstObject;
//    
//    float minLat = initialLoc.latitude.floatValue;
//    float minLng = initialLoc.longitude.floatValue;
//    float maxLat = initialLoc.latitude.floatValue;
//    float maxLng = initialLoc.longitude.floatValue;
//    
//    for (Location *location in self.run.locations)
//    {
//        if (location.latitude.floatValue < minLat)
//        {
//            minLat = location.latitude.floatValue;
//        }
//        if (location.longitude.floatValue < minLng)
//        {
//            minLng = location.longitude.floatValue;
//        }
//        if (location.latitude.floatValue > maxLat)
//        {
//            maxLat = location.latitude.floatValue;
//        }
//        if (location.longitude.floatValue > maxLng)
//        {
//            maxLng = location.longitude.floatValue;
//        }
//    }
//    
//    region.center.latitude = (minLat + maxLat) / 2.0f;
//    region.center.longitude = (minLng + maxLng) / 2.0f;
//    
//    region.span.latitudeDelta = (maxLat - minLat) * 1.1f; // 10% padding
//    region.span.longitudeDelta = (maxLng - minLng) * 1.1f; // 10% padding
//    
//    return region;
//}
//
//
//// if map gets request to add overlay, check it is
//// MKPolyLine and make line black and width 3
//
//- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
//    if ([overlay isKindOfClass:[MultiColorPolyline class]]) {
//        MultiColorPolyline *polyLine = (MultiColorPolyline *)overlay;
//        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:polyLine];
//        renderer.strokeColor = polyLine.color;
//        renderer.lineWidth = 5;
//        return renderer;
//    }
//    return nil;
//}
//
//- (MKPolyline *)polyline {
//    CLLocationCoordinate2D coord[self.run.locations.count];
//    for (int i = 0; i < self.run.locations.count; i++) {
//        Location *location = [self.run.locations objectAtIndex:i];
//        coord[i] = CLLocationCoordinate2DMake(location.latitude.doubleValue, location.longitude.doubleValue);
//    }
//    return [MKPolyline polylineWithCoordinates:coord count:self.run.locations.count];
//}
//
//- (void)loadMap
//
//{
//    if (self.run.locations.count > 0)
//    
//    {
//        self.mapView.hidden = NO;
//        [self.mapView setRegion:[self mapRegion]];
//        NSArray *colorSegmentArr = [MathController colorSegmentsForLocations:self.run.locations.array];
//        [self.mapView addOverlays:colorSegmentArr];
//       // [self.mapView addAnnotations:[[BadgeController defaultController] annotationsForRun:self.run]];
//    } else {
//        self.mapView.hidden = YES;
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Sorry, this run has no locations saved." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alertView show];
//    }
//}
//
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//
//{
//    BadgeAnnotation *badgeAnnotation = (BadgeAnnotation *)annotation;
//    MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"checkpt"];
//    
//    if (!annoView)
//    
//    {
//        
//annoView = [[MKAnnotationView alloc] initWithAnnotation:badgeAnnotation reuseIdentifier:@"checkpt"];
//        
//        annoView.image = [UIImage imageNamed:@"mapPin"];
//        
//        annoView.canShowCallout = YES;
//    }
//    
//    UIImageView *badgeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 75, 50)];
//    badgeImageView.image = [UIImage imageNamed:badgeAnnotation.imageName];
//    badgeImageView.contentMode = UIViewContentModeScaleAspectFit;
//    annoView.leftCalloutAccessoryView = badgeImageView;
//    
//    return annoView;
//}
//
//















-(IBAction)Facebook:(id)sender

{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:@"Run Virtual Race"];
        [controller addURL:[NSURL URLWithString:@"http://www.appcoda.com"]];
        [controller addImage:[UIImage imageNamed:@"socialsharing-facebook-image.jpg"]];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
    
}

-(IBAction)Twitter:(id)sender

{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Run Virtual Race"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    
}










@end

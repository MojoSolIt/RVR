//
//  RacesList.m
//  RVR
//
//  Created by Muhammad Faraz on 24/02/2016.
//  Copyright © 2016 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import "RacesList.h"

@implementation RacesList

@synthesize RaceName,Raceremaing_days,Raceend_date,Racestart_date,RaceDescription,RaceId;


-(id)init

{
    if(self)
    
    {
        
    }
    
    return self;
}

-(id)initwithId: (NSString *)Id Name:(NSString *)Name Description: (NSString *)Description start_date:(NSString *)start_date  end_date:(NSString *)end_date   remaing_days:(NSString *)remaing_days;

{
    if (self)
    {
        self.RaceId=Id;
        self.RaceDescription=Description;
        self.Racestart_date=start_date;
        self.Raceend_date=end_date;
        self.Raceremaing_days=remaing_days;
        self.RaceName=Name;

    }
    return self;
}

@end

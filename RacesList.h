//
//  RacesList.h
//  RVR
//
//  Created by Muhammad Faraz on 24/02/2016.
//  Copyright © 2016 Mojo Solutions Services (Pvt) Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RacesList : NSObject

@property(nonatomic,strong) NSString  *RaceName;
@property(nonatomic,strong) NSString  *RaceDescription;
@property(nonatomic,strong) NSString  *Racestart_date;
@property(nonatomic,strong) NSString  *Raceend_date;
@property(nonatomic,strong) NSString  *Raceremaing_days;
@property(nonatomic,strong) NSString  *RaceId;


-(id)initwithId: (NSString *)Id
        Name: (NSString *)Name
    Description: (NSString *)Description
     start_date:(NSString *)start_date
       end_date:(NSString *)end_date
   remaing_days:(NSString *)remaing_days ;

@end

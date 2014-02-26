//
//  WeatherForTheDay.h
//  MasterDetailTest
//
//  Created by Rocky Camacho on 2/25/14.
//  Copyright (c) 2014 Rocky Camacho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherForTheDay : NSObject

@property (assign) long dateTime;
@property (assign) double dayTemperature;
@property (assign) double minTemperature;
@property (assign) double maxTemperature;
@property (assign) double nightTemperature;
@property (assign) double pressure;
@property (assign) int humidity;
@property (strong) NSString *weatherMain;
@property (strong) NSString *weatherDescription;
@property (strong) NSString *weatherIcon;
@property (assign) double speed;
@property (assign) double degrees;

@end

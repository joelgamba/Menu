//
//  WeatherDetailViewController.h
//  MasterDetailTest
//
//  Created by Rocky Camacho on 2/26/14.
//  Copyright (c) 2014 Rocky Camacho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"
#import "WeatherForTheDay.h"

@interface WeatherDetailViewController : UITableViewController

@property (strong, nonatomic) City *city;

@property (strong, nonatomic) NSMutableArray *weatherData;

@end

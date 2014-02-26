//
//  MasterViewController.h
//  MasterDetailTest
//
//  Created by Rocky Camacho on 2/25/14.
//  Copyright (c) 2014 Rocky Camacho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherDetailViewController.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) WeatherDetailViewController *detailViewController;

@end

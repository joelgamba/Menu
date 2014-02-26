//
//  WeatherDetailViewController.m
//  MasterDetailTest
//
//  Created by Rocky Camacho on 2/26/14.
//  Copyright (c) 2014 Rocky Camacho. All rights reserved.
//

#import "WeatherDetailViewController.h"

@interface WeatherDetailViewController ()

@end

@implementation WeatherDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setTitle: [self.city name]];
    NSLog([NSString stringWithFormat:@"[self.city name]: %@", [self.city name]]);
    _weatherData = self.city.weatherData;
    NSLog([NSString stringWithFormat:@"weather detail: %@", _weatherData]);
    //[self.tableView reloadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return _weatherData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    WeatherForTheDay *weatherForTheDay = _weatherData[indexPath.row];
    NSLog([NSString stringWithFormat: @"%d", weatherForTheDay.dateTime]);
    NSLog([NSString stringWithFormat: @"%d", weatherForTheDay.dayTemperature]);
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:weatherForTheDay.dateTime];
    
    
    NSLog([NSString stringWithFormat:weatherForTheDay.weatherIcon]);
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setDateFormat:@"EEE, MM/dd/yyyy"];
    NSString *dateString=[_formatter stringFromDate:date];
    NSLog([NSString stringWithFormat:@"%@", dateString]);
    [cell.textLabel setText: dateString];
    [cell.detailTextLabel setText: [NSString stringWithFormat:@"%.2f℃ - %.2f℃", weatherForTheDay.minTemperature, weatherForTheDay.maxTemperature]];
    [cell.imageView setImage: [UIImage imageNamed:weatherForTheDay.weatherIcon]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end

//
//  MasterViewController.m
//  MasterDetailTest
//
//  Created by Rocky Camacho on 2/25/14.
//  Copyright (c) 2014 Rocky Camacho. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import "City.h"
#import "WeatherForTheDay.h"



@interface MasterViewController () {
    NSMutableArray *_cities;
    __weak IBOutlet UITextField *cityNameField;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];

    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSMutableArray *history = [preferences objectForKey:@"searchHistory"];
    if(!history) {
        history = [[NSMutableArray alloc]init];
    }
    NSLog([NSString stringWithFormat:@"history count: %d", [history count]]);
    if([_cities count] == 0) {
        //[self insertNewCity:@"Manila"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (City *)insertNewCity:(NSString *)name
{
    if (!_cities) {
        _cities = [[NSMutableArray alloc] init];
    }
    NSLog([NSString stringWithFormat:@"%@", name]);
    City *city = [[City alloc] initWithName:name];
    [_cities insertObject:city atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    return city;
}

- (City *)insertNewCity:(NSString *)name with:(NSMutableArray *)weatherForDays
{
    City *city = [self insertNewCity: name];
    NSLog([NSString stringWithFormat:@"city weatherForDays %@", weatherForDays]);
    city.weatherData = weatherForDays;
    return city;
}


- (NSMutableArray *)getWeatherForDays:(NSDictionary *)parsedObject
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    NSLog([NSString stringWithFormat:@"%@", parsedObject]);
    NSArray *weatherDataForDays = [parsedObject valueForKey:@"list"];
    NSMutableArray *weatherForDays = [[NSMutableArray alloc] init];
    for(NSDictionary *weatherDataForDay in weatherDataForDays) {
        WeatherForTheDay *weatherForTheDay = [[WeatherForTheDay alloc] init];
        
        NSDictionary *weather = [weatherDataForDay valueForKey:@"weather"];
        NSArray *descriptions = [weather valueForKey:@"description"];
        weatherForTheDay.weatherDescription = [descriptions firstObject];
        NSLog([NSString stringWithFormat:@"weatherForTheDay.weatherDescription : %@", weatherForTheDay.weatherDescription]);
        NSArray *icons = [weather valueForKey:@"icon"];
        weatherForTheDay.weatherIcon = [icons firstObject];
        weatherForTheDay.dateTime = [[weatherDataForDay valueForKey:@"dt"] longValue];
        
        NSDictionary *temp = [weatherDataForDay valueForKey:@"temp"];
        NSLog([NSString stringWithFormat:@"weatherForTheDay.temp : %@", temp]);
        NSLog([NSString stringWithFormat:@"day : %f", [[temp valueForKey:@"day"] doubleValue]]);
        weatherForTheDay.dayTemperature = [[temp valueForKey:@"day"] doubleValue] - 273.15;
        weatherForTheDay.minTemperature = [[temp valueForKey:@"min"] doubleValue] - 273.15;
        weatherForTheDay.maxTemperature = [[temp valueForKey:@"max"] doubleValue] - 273.15;
        weatherForTheDay.nightTemperature = [[temp valueForKey:@"eve"] doubleValue] - 273.15;
        
        [weatherForDays addObject: weatherForTheDay];
    }
    return weatherForDays;
}

- (void)insertNewObject:(id)sender
{
    NSString *name = [cityNameField text];
    [cityNameField setText: @""];
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?q=%@&mode=json", [name stringByReplacingOccurrencesOfString:@" " withString:@"_"]];
    NSLog(urlString);
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    __block MasterViewController *blockSafeSelf = self;
    __block WeatherDetailViewController *blockSafeDetailViewController = self.detailViewController;
    __block UIActivityIndicatorView *blockSafeIndicator = indicator;
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        [blockSafeIndicator startAnimating];
        if(!connectionError) {
            NSError *localError = nil;
            NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options: 0 error: &localError];
            if (localError != nil) {
                NSLog([NSString stringWithFormat:@"Error: %@", localError]);
            }
            else {
                NSMutableArray *weatherForDays = [self getWeatherForDays:parsedObject];
                NSLog([NSString stringWithFormat:@"%@", weatherForDays]);
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    City *city = [blockSafeSelf insertNewCity:name with: weatherForDays];
                    [blockSafeIndicator stopAnimating];
                    blockSafeDetailViewController.city = city;
                    blockSafeDetailViewController.weatherData = weatherForDays;
                    NSLog([NSString stringWithFormat:@"city %@", blockSafeDetailViewController.city ]);
                    NSLog([NSString stringWithFormat:@"weatherForDays %@", weatherForDays]);
                    NSLog([NSString stringWithFormat:@"current %@", blockSafeDetailViewController.weatherData]);
                    [blockSafeSelf performSegueWithIdentifier:@"showDetail" sender:blockSafeSelf ];
                });
            }
        }
        else {
        }
        [blockSafeIndicator stopAnimating];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
        NSLog([NSString stringWithFormat:@"after %@", blockSafeDetailViewController.weatherData]);
    }];
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    City *object = _cities[indexPath.row];
    cell.textLabel.text = [object name];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_cities removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        City *city = _cities[indexPath.row];
        self.detailViewController.city = city;
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        City *city = _cities[indexPath.row];
        
        if(!city.weatherData) {
            NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?q=%@&mode=json", [city.name stringByReplacingOccurrencesOfString:@" " withString:@"_"]];
            NSLog(urlString);
            NSURL *url = [[NSURL alloc] initWithString:urlString];
            
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
            indicator.center = self.view.center;
            [self.view addSubview:indicator];
            [indicator bringSubviewToFront:self.view];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
            
            __block MasterViewController *blockSafeSelf = self;
            __block WeatherDetailViewController *blockSafeDetailViewController = self.detailViewController;
            __block UIActivityIndicatorView *blockSafeIndicator = indicator;
            
            [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                [blockSafeIndicator startAnimating];
                if(!connectionError) {
                    NSError *localError = nil;
                    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options: 0 error: &localError];
                    if (localError != nil) {
                        NSLog([NSString stringWithFormat:@"Error: %@", localError]);
                    }
                    else {
                        NSMutableArray *weatherForDays = [self getWeatherForDays:parsedObject];
                        NSLog([NSString stringWithFormat:@"%@", weatherForDays]);
                        
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            city.weatherData = weatherForDays;
                            
                            [blockSafeIndicator stopAnimating];
                            //[blockSafeSelf performSegueWithIdentifier:@"showDetail" sender:blockSafeSelf ];
                            [[segue destinationViewController] setCity:city];
                        });
                    }
                }
                else {
                }
                [blockSafeIndicator stopAnimating];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
            }];
        }
        else {
            self.detailViewController.city = city;
            self.detailViewController.weatherData = city.weatherData;
            NSLog([NSString stringWithFormat:@"city: %@", city]);
            NSLog([NSString stringWithFormat:@"city.weatherData %@", city.weatherData]);
            //[segue destinationViewController];
            [[segue destinationViewController] setCity:city];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self insertNewObject:self];
    return YES;
}

@end

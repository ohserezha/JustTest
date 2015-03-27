//
//  YourCitiesTableViewController.m
//  JustTest
//
//  Created by Sergey Gorelov on 3/17/15.
//  Copyright (c) 2015 Sergey Gorelov. All rights reserved.
//

#import "YourCitiesTableViewController.h"
#import "ServerManager.h"
#import "WeatherStatus.h"
#import "WeatherDetailsViewController.h"

@interface YourCitiesTableViewController ()

@property (strong, nonatomic) NSArray *savedCities;
@property (strong, nonatomic) NSMutableArray* weatherStatusesArray;
@property (strong, nonatomic) WeatherStatus *weatherStatusOfSelectedCity;

@end

@implementation YourCitiesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.savedCities = @[@524901, @703448,@2643743];
    [self getWeatherForCitiesFromServer];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

- (void)getWeatherForCitiesFromServer {
//     NSMutableArray *wthrSts = self.weatherStatuses;
    [[ServerManager sharedServerManager]
     getWeatherByCityIDs:self.savedCities
     onSuccess:^(NSArray *forecasts){
         if (forecasts) self.weatherStatusesArray = [[NSMutableArray alloc] initWithArray:forecasts];
         [self.tableView reloadData];
     } onFailure:^(NSError *error, NSInteger statusCode) {
         NSLog(@"error = %@, code = %ld", [error localizedDescription], statusCode);
     }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.savedCities count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    //NSLog(@"\n\nweatherSs on construction: %@", self.weatherStatusesArray);
    WeatherStatus *weather = [self.weatherStatusesArray objectAtIndex:indexPath.row];
    if (weather) {
        cell.textLabel.text = weather.cityName;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ °C, %@", weather.temp, weather.commonDescription];
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"segueToWeatherDetails"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        WeatherDetailsViewController *wdvc = [segue destinationViewController];
        [wdvc setWeatherStatus:[self.weatherStatusesArray objectAtIndex:indexPath.row]];
    }
}

- (IBAction)unwindToYourCities:(UIStoryboardSegue *)segue {
    
};

@end

//
//  AddCityTableViewController.m
//  JustTest
//
//  Created by Sergey Gorelov on 3/17/15.
//  Copyright (c) 2015 Sergey Gorelov. All rights reserved.
//

#import "AddCityTableViewController.h"
#import "ServerManager.h"
#import "YourCitiesTableViewController.h"

@interface AddCityTableViewController ()
@property (strong, nonatomic) NSArray *searchResults;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@end

@implementation AddCityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.searchResults count]?[self.searchResults count]:1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReuseID" forIndexPath:indexPath];
    
    // Configure the cell...
    if ([self.searchResults count]) {
        WeatherStatus *searchResult = self.searchResults[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", searchResult.cityName, searchResult.country];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.searchResults count]) {
        [self.saveButton setEnabled:YES];
    }
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
    if ([sender isEqual:self.saveButton]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        YourCitiesTableViewController *yctvc = [segue destinationViewController];
        WeatherStatus *selectedCityWeather = self.searchResults[indexPath.row];
        // [yctvc.savedCities addObject:@(selectedCityWeather.cityID)];
        [yctvc addCityIDToUsersList:@(selectedCityWeather.cityID)];
    }
}

#pragma mark - UISearchBar delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self getCitiesFromServerByRequest:searchBar.text];
    [searchBar resignFirstResponder];
}

#pragma mark - API

- (void)getCitiesFromServerByRequest:(NSString *)cityName {
    [[ServerManager sharedServerManager] searchCityByName:cityName onSuccess:^(NSArray *cityIDs){
         if (cityIDs) self.searchResults = [NSArray arrayWithArray:cityIDs];
         [self.tableView reloadData];
     } onFailure:^(NSError *error, NSInteger statusCode) {
         NSLog(@"error = %@, code = %ld", [error localizedDescription], statusCode);
     }];
}

@end

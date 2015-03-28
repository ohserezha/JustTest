//
//  YourCitiesTableViewController.h
//  JustTest
//
//  Created by Sergey Gorelov on 3/17/15.
//  Copyright (c) 2015 Sergey Gorelov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YourCitiesTableViewController : UITableViewController
@property (strong, nonatomic) NSMutableArray *savedCities;
- (void)addCityIDToUsersList:(NSNumber *)cityID ;
@end

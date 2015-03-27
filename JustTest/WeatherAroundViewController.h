//
//  WeatherAroundViewController.h
//  JustTest
//
//  Created by Sergey Gorelov on 3/17/15.
//  Copyright (c) 2015 Sergey Gorelov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherAroundViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *cityName;
@property (weak, nonatomic) IBOutlet UILabel *temp;
@property (weak, nonatomic) IBOutlet UILabel *pressure;
@property (weak, nonatomic) IBOutlet UILabel *humidity;
@property (weak, nonatomic) IBOutlet UILabel *tempMin;
@property (weak, nonatomic) IBOutlet UILabel *tempMax;
@property (weak, nonatomic) IBOutlet UILabel *windSpeed;
@property (weak, nonatomic) IBOutlet UILabel *windDirection;

@end

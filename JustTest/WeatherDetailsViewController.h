//
//  WeatherDetailsViewController.h
//  JustTest
//
//  Created by Sergey Gorelov on 3/17/15.
//  Copyright (c) 2015 Sergey Gorelov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherStatus.h"

@interface WeatherDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempMinLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempMaxLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpdLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDirectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunriseLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunsetLabel;
@property (strong, nonatomic) WeatherStatus *weatherStatus;
@end

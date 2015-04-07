//
//  WeatherDetailsViewController.m
//  JustTest
//
//  Created by Sergey Gorelov on 3/17/15.
//  Copyright (c) 2015 Sergey Gorelov. All rights reserved.
//

#import "WeatherDetailsViewController.h"

@interface WeatherDetailsViewController ()

@end

@implementation WeatherDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.weatherStatus) {
        [self setLabelsWithWeatherStatus:self.weatherStatus];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLabelsWithWeatherStatus:(WeatherStatus *)weatherStatus {
    self.cityNameLabel.text = weatherStatus.cityName;
    self.tempLabel.text = [NSString stringWithFormat:@"%.1f °C", [weatherStatus.temp doubleValue]];
    self.pressureLabel.text = [NSString stringWithFormat:@"%.2f mbar", [weatherStatus.pressure doubleValue]];
    self.humidityLabel.text = [NSString stringWithFormat:@"%.1f %%", [weatherStatus.humidity doubleValue]];
    self.tempMinLabel.text = [NSString stringWithFormat:@"%.1f °C", [weatherStatus.tempMin doubleValue]];
    self.tempMaxLabel.text = [NSString stringWithFormat:@"%.1f °C", [weatherStatus.tempMax doubleValue]];
    self.windSpdLabel.text = [NSString stringWithFormat:@"%.2f m/s", [weatherStatus.windSpeed doubleValue]];
    self.windDirectionLabel.text = [NSString stringWithFormat:@"%.f °", [weatherStatus.windDirection doubleValue]];
    self.sunriseLabel.text = [NSString stringWithFormat:@"%@", weatherStatus.sunriseTime];
    self.sunsetLabel.text = [NSString stringWithFormat:@"%@", weatherStatus.sunsetTime];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

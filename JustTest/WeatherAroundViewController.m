//
//  WeatherAroundViewController.m
//  JustTest
//
//  Created by Sergey Gorelov on 3/17/15.
//  Copyright (c) 2015 Sergey Gorelov. All rights reserved.
//

#import "WeatherAroundViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "ServerManager.h"
#import "WeatherStatus.h"

@interface WeatherAroundViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) WeatherStatus *weatherStatus;

@end

@implementation WeatherAroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = 3000;
        self.locationManager.distanceFilter = 1000;
        // [self.locationManager startUpdatingLocation];
        // [self performSelector:@selector(stopUpdatingLocationWithMessage:) withObject:@"Timed Out" afterDelay:3];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Not Determined" message:@"location services are off for this app" delegate:nil cancelButtonTitle:@"Okaaay..." otherButtonTitles:nil];
        [alert show];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.locationManager startUpdatingLocation];
    [self getWeatherFromServer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.locationManager stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getWeatherFromServer {
    CLLocationCoordinate2D location = self.locationManager.location.coordinate;
    //NSLog(@"gettin weather for lat: %@ long: %@", @(location.latitude), @(location.longitude));
    [[ServerManager sharedServerManager] getWeatherByLatitude:@(location.latitude) longitude:@(location.longitude)
                                                    onSuccess:^(NSDictionary *responseDict) {
                                                        self.weatherStatus = [[WeatherStatus alloc] initWithServerResponse:responseDict];
                                                        [self updateViewWithWeatherStatus:self.weatherStatus];
                                                    } onFailure:^(NSError *error, NSInteger statusCode) {
                                                        NSLog(@"error = %@, code = %ld", [error localizedDescription], statusCode);
                                                    }];
}

- (void)updateViewWithWeatherStatus:(WeatherStatus *)weather {
    self.cityName.text = weather.cityName;
    self.temp.text = [NSString stringWithFormat:@"%@ °C", weather.temp];
    self.pressure.text = [NSString stringWithFormat:@"%@ mbar", weather.pressure];
    self.humidity.text = [NSString stringWithFormat:@"%@ %%", weather.humidity];
    self.tempMin.text = [NSString stringWithFormat:@"%@ °C", weather.tempMin];
    self.tempMax.text = [NSString stringWithFormat:@"%@ °C", weather.tempMax];
    self.windSpeed.text = [NSString stringWithFormat:@"%@ m/s", weather.windSpeed];
    self.windDirection.text = [NSString stringWithFormat:@"%@ °", weather.windDirection];
}

/*
- (void)defineLocation {
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = 3000;
        self.locationManager.distanceFilter = 1000;
        [self.locationManager startUpdatingLocation];
//        [self performSelector:@selector(stopUpdatingLocationWithMessage:) withObject:@"Timed Out" afterDelay:3];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Not Determined" message:@"location services are off for this app" delegate:nil cancelButtonTitle:@"Okaaay..." otherButtonTitles:nil];
        [alert show];
    }
} 
*/

- (void)stopUpdatingLocationWithMessage:(NSString *)state {
    [self.locationManager stopUpdatingLocation];
    CLLocation *recentLocation = self.locationManager.location;
    NSLog(@"%f %f message: %@", recentLocation.coordinate.latitude, recentLocation.coordinate.longitude, state);
}

#pragma mark - CLLocationManager Delegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] != kCLErrorLocationUnknown) {
        [self stopUpdatingLocationWithMessage:NSLocalizedString(@"Error", @"Error")];
    }
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [self getWeatherFromServer];
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

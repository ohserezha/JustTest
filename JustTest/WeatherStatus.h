//
//  WeatherStatus.h
//  JustTest
//
//  Created by Sergey Gorelov on 3/18/15.
//  Copyright (c) 2015 Sergey Gorelov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherStatus : NSObject

@property (strong, nonatomic) NSString *cityName;
@property (strong, nonatomic) NSString *country;
@property (assign, nonatomic) NSInteger cityID;
@property (strong, nonatomic) NSString *sunriseTime;
@property (strong, nonatomic) NSString *sunsetTime;
@property (strong, nonatomic) NSNumber *temp;
@property (strong, nonatomic) NSNumber *pressure;
@property (strong, nonatomic) NSNumber *humidity;
@property (strong, nonatomic) NSNumber *tempMin;
@property (strong, nonatomic) NSNumber *tempMax;
@property (strong, nonatomic) NSNumber *windSpeed;
@property (strong, nonatomic) NSNumber *windDirection;
@property (strong, nonatomic) NSString *commonDescription;

- (instancetype) initWithServerResponse:(NSDictionary *)responseObject;

@end

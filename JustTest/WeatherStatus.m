//
//  WeatherStatus.m
//  JustTest
//
//  Created by Sergey Gorelov on 3/18/15.
//  Copyright (c) 2015 Sergey Gorelov. All rights reserved.
//

#import "WeatherStatus.h"

@interface WeatherStatus()
@property (nonatomic, strong) NSDictionary *responseDict;
@end

@implementation WeatherStatus

- (id) initWithServerResponse:(NSDictionary*) responseObject
{
    self = [super init];
    if (self) {
        self.cityID = [[responseObject objectForKey:@"id"] integerValue];
        self.cityName = [responseObject objectForKey:@"name"];
        self.country = [[responseObject objectForKey:@"sys"] objectForKey:@"country"];
        double doubleSunriseTime = [[[responseObject objectForKey:@"sys"] objectForKey:@"sunrise"] doubleValue];
        self.sunriseTime = [self getStringRepresentationOfUnixTime:doubleSunriseTime];
        double doubleSunsetTime = [[[responseObject objectForKey:@"sys"] objectForKey:@"sunset"] doubleValue];
        self.sunsetTime = [self getStringRepresentationOfUnixTime:doubleSunsetTime];
        self.temp = [[responseObject objectForKey:@"main"] objectForKey:@"temp"];
        self.pressure = [[responseObject objectForKey:@"main"] objectForKey:@"pressure"];
        self.humidity = [[responseObject objectForKey:@"main"] objectForKey:@"humidity"];
        self.tempMin = [[responseObject objectForKey:@"main"] objectForKey:@"temp_min"];
        self.tempMax = [[responseObject objectForKey:@"main"] objectForKey:@"temp_max"];
        self.windSpeed = [[responseObject objectForKey:@"wind"] objectForKey:@"speed"];
        self.windDirection = [[responseObject objectForKey:@"wind"] objectForKey:@"deg"];
        self.commonDescription = [[[responseObject objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"description"];
    }
    return self;
}

- (NSString *)getStringRepresentationOfUnixTime:(double)unixTimeStamp {
    NSTimeInterval interval=unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterNoStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    [formatter setLocale:[NSLocale currentLocale]];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

@end

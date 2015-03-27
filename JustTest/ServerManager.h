//
//  ServerManager.h
//  JustTest
//
//  Created by Sergey Gorelov on 3/18/15.
//  Copyright (c) 2015 Sergey Gorelov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherStatus.h"

@interface ServerManager : NSObject

+ (instancetype)sharedServerManager;

- (instancetype)initWithBaseURL:(NSURL *)baseURL;

- (void)getWeatherByCityIDs:(NSArray *)cityIDs
                 onSuccess:(void(^)(NSArray* cities))success
                 onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void)searchCityByName:(NSString *)cityName;

- (void)getWeatherByLatitude:(NSNumber *)latitude
                   longitude:(NSNumber *)longitude
                   onSuccess:(void(^)(NSDictionary *responseDict))success
                   onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;

@end
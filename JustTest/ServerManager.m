//
//  ServerManager.m
//  JustTest
//
//  Created by Sergey Gorelov on 3/18/15.
//  Copyright (c) 2015 Sergey Gorelov. All rights reserved.
//

#import "ServerManager.h"
#import "AFNetworking.h"

static NSString *API_KEY = @"22741422a121cbd32c2694e9ecd1deac";
static NSString *DEFAULT_BASE_URL = @"http://api.openweathermap.org/data/2.5/";


@interface ServerManager ()

@property (strong, nonatomic) AFHTTPRequestOperationManager *requestOperationManager;

@end

@implementation ServerManager

+ (instancetype)sharedServerManager {
    static ServerManager *serverManager = nil;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        serverManager = [[ServerManager alloc] initWithBaseURL:[NSURL URLWithString:DEFAULT_BASE_URL]];
    });
    return serverManager;
}

- (instancetype)initWithBaseURL:(NSURL *)baseURL {
    if (self = [super init]) {
        self.requestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    }
    return self;
}

- (void)getWeatherByCityIDs:(NSArray *)cityIDs
                  onSuccess:(void(^)(NSArray *cities)) success
                  onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    NSString *idSet = [[cityIDs valueForKey:@"description"] componentsJoinedByString:@","];
    NSDictionary *parameters = @{@"id":idSet,
                                 @"units":@"metric" };
    [self.requestOperationManager GET:@"group"
                           parameters:parameters
                              success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
                                  //NSLog(@"JSON: %@", responseObject);
                                  NSArray* dictsArray = [responseObject objectForKey:@"list"];
                                  NSMutableArray* objectsArray = [NSMutableArray array];
                                  for (NSDictionary* dict in dictsArray) {
                                      WeatherStatus* wStatus = [[WeatherStatus alloc] initWithServerResponse:dict];
                                      [objectsArray addObject:wStatus];
                                  }
                                  if (success) {
                                      success(objectsArray);
                                  }
                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  NSLog(@"Error: %@", error);
                                  if (failure) {
                                      failure(error, operation.response.statusCode);
                                  }
                              }];
}

- (void)searchCityByName:(NSString *)cityName {
    
}

- (void)getWeatherByLatitude:(NSNumber *)latitude
                   longitude:(NSNumber *)longitude
                   onSuccess:(void(^)(NSDictionary  *responseDict)) success
                   onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    NSDictionary *parameters = @{ @"lat":latitude,
                                 @"lon":longitude,
                                  @"units":@"metric" };
    [self.requestOperationManager GET:@"weather" parameters:parameters
                              success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
//                                  NSLog(@"JSON: %@", responseObject);
                                  if (success) {
                                      success(responseObject);
                                  }
                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  NSLog(@"Error: %@", error);
                              }];
}

@end

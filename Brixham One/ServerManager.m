//
//  ServerManager.m
//  Brixham One
//
//  Created by Александр Чегошев on 29.08.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "ServerManager.h"
#import <AFNetworking.h>
#import "Person.h"
#import "Site.h"
#import "Router.h"
#import "User.h"
#import "Constants.h"

@implementation ServerManager

+(ServerManager *)sharedManager {

    static ServerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [ServerManager new];
    });
    return manager;
}

- (void)loginWithLogin:(NSString *)login
           andPassword:(NSString *)password
             onSuccees:(void(^)(NSString *accessToken))success
             onFailure:(void(^)(NSError *error))failure {

    NSLog(@"login = %@ password = %@",login,password);

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            login,@"username",
                            password,@"password",nil];

    [[AFHTTPSessionManager manager] POST:[[Router sharedManager] stringWithrequestType:LoginRequest]
                              parameters:params
                                progress:nil
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                     NSLog(@"token = %@",responseObject);
                                     User *user = [User new];
                                     user.token = responseObject;
                                     success(responseObject);
                                 }
                                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                     NSLog(@"eror = %@",error);
                                 }];

}

- (void)getSitesOnSuccees:(void(^)(NSArray *ranksArray))success
                onFailure:(void(^)(NSError *error))failure {

//    User *user = [User new];

    NSLog(@"request = %@",[[Router sharedManager] stringWithrequestType:SitesRequest]);

    [[AFHTTPSessionManager manager] GET:[[Router sharedManager] stringWithrequestType:SitesRequest]
                             parameters:nil
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    NSLog(@"Sites = %@",responseObject);
                                }
                                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    NSLog(@"error = %@",error);
                                }];
}


-(void)getRanksForPersonForDateArray:(NSArray *)dateArray
                            fromSite:(NSString *)site
                           onSuccees:(void(^)(NSArray *ranksArray))success
                           onFailure:(void(^)(NSError *error))failure {

    NSDate *begin = dateArray.firstObject;
    NSDate *end = dateArray.lastObject;

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            begin,@"",
                            end,@"",
                            site,@"", nil];

    [[AFHTTPSessionManager manager] GET:[[Router sharedManager] stringWithrequestType:RanksRequest]
                             parameters:params
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    NSLog(@"json = %@",responseObject);
                                }
                                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

                                }];

    
}

/*
-(void)getRanksForSitesForDateArray:(NSArray *)dateArray
                          forPerson:(NSString *)person
                          onSuccees:(void(^)(NSArray *ranksArray))success
                          onFailure:(void(^)(NSError *error))failure {

    NSDate *begin = dateArray.firstObject;
    NSDate *end = dateArray.lastObject;

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"beginDate",begin,
                            @"endDate",end,
                            @"person",person, nil];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"API"
      parameters:params
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

             NSArray *responseArray = responseObject[@"persons"];
             NSMutableArray *array = [NSMutableArray new];

             for (NSDictionary *dict in responseArray) {
                 Site *site = [Site new];
                 site.name = dict[@"name"];
                 site.ranks = dict[@"ranks"];
                 [array addObject:person];
             }
             success(array);
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"%@",error);
         }];
    
}
*/

@end

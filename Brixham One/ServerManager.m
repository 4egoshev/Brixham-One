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
#import "Site.h"
#import "Person.h"
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

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            login,@"username",
                            password,@"password",nil];

    [[AFHTTPSessionManager manager] POST:[[Router sharedManager] stringWithrequestType:LoginRequest]
                              parameters:params
                                progress:nil
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

                                     NSString *toketString = responseObject[@"token"];
                                     NSData *tokenData = [NSKeyedArchiver archivedDataWithRootObject:toketString];
                                     [[NSUserDefaults standardUserDefaults] setObject:tokenData forKey:@"Token"];
                                     success(responseObject);
                                 }
                                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                     NSLog(@"eror = %@",error);
                                 }];

}

- (void)getSitesOnSuccees:(void(^)(NSArray *sitesArray))success
                onFailure:(void(^)(NSError *error))failure {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSLog(@"token = %@",[self tokenString]);
    [manager.requestSerializer setValue:[self tokenString] forHTTPHeaderField:@"Authorization"];

    NSLog(@"request = %@",[[Router sharedManager] stringWithrequestType:SitesRequest]);

    [manager GET:[[Router sharedManager] stringWithrequestType:SitesRequest]
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

             NSMutableArray *sitesArray = [NSMutableArray new];
             for (NSDictionary *dict in responseObject) {
                 Site *site = [[Site alloc] initWithDictionary:dict];
                 [sitesArray addObject:site];
             }
             success(sitesArray);
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"error = %@",error);
         }];
}

- (void)getRanksForPersonFromSite:(NSString *)site
                        onSuccees:(void(^)(NSArray *ranksArray))success
                        onFailure:(void(^)(NSError *error))failure {

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:site,@"search", nil];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[self tokenString] forHTTPHeaderField:@"Authorization"];

    [manager GET:[[Router sharedManager] stringWithrequestType:RanksForPeriodRequest]
      parameters:params
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

             Person *javaP = [Person new];
             javaP.name = @"Java";
             javaP.ranks = 0;
             Person *pythonP = [Person new];
             pythonP.name = @"Python";
             pythonP.ranks = 0;

             for (NSDictionary *dict in responseObject) {
                 Person *person = [[Person alloc] initWithDictionary:dict];
                 if ([person.name isEqualToString:javaP.name]) {
                     javaP.ranks += person.ranks;
                 } else {
                     pythonP.ranks += person.ranks;
                 }
             }

             NSArray *personsArray = [NSArray arrayWithObjects:javaP,pythonP, nil];
             success(personsArray);
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

    NSString *dateString = [NSString stringWithFormat:@"%@:%@",begin,end];

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            dateString,@"from",
                            site,@"search", nil];

    NSLog(@"request = %@",[[Router sharedManager] stringWithrequestType:RanksForPeriodRequest]);

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[self tokenString] forHTTPHeaderField:@"Authorization"];

    [manager GET:[[Router sharedManager] stringWithrequestType:RanksForPeriodRequest]
      parameters:params
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"json = %@",responseObject);

             Person *javaP = [Person new];
             javaP.name = @"Java";
             javaP.ranks = 0;
             Person *pythonP = [Person new];
             pythonP.name = @"Python";
             pythonP.ranks = 0;

             for (NSDictionary *dict in responseObject) {
                 Person *person = [[Person alloc] initWithDictionary:dict];

                 if ([person.name isEqualToString:javaP.name]) {
                     javaP.ranks += person.ranks;
                 } else {
                     pythonP.ranks += person.ranks;
                 }
             }
        }
            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
}

#pragma mark - Token

- (NSString *)tokenString {

    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"Token"];
    NSString *token = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return [NSString stringWithFormat:@"JWT %@",token];
}

@end

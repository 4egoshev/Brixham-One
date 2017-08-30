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

@implementation ServerManager

+(ServerManager *)sharedManager {
    static ServerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [ServerManager new];
    });
    return manager;
}

//-(void)getRanksForPersonSinceDate:(NSDate *)begin
//                          forDate:(NSDate *)end
//                         fromSite:(NSString *)site
//                        onSuccees:(void(^)(NSArray *ranksArray))success
//                        onFailure:(void(^)(NSError *error))failure {
//
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            @"beginDate",begin,
//                            @"endDate",end,
//                            @"site",site, nil];
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager GET:@"API"
//      parameters:params
//         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//
//
//             for (NSDictionary *dict in responseObject) {
//                 NSArray *personsArray = [dict objectForKey:@""];
//                 for (int i=0; i<personsArray.count; i++) {
//                     Person *person = [Person new];
//                     person.name = personsArray[i][@""];
//                     person.ranks = personsArray[i][@""];
//                     person.date = dict[@""];
//
//                 }
//             }
//
//         }
//         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//             <#code#>
//         }];
//    
//}

@end

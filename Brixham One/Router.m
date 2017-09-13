//
//  Router.m
//  Brixham One
//
//  Created by Александр Чегошев on 08.09.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "Router.h"

@implementation Router

+ (Router *)sharedManager {

    static Router *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [Router new];
    });
    return manager;
}

- (NSString *)stringWithrequestType:(RequestType)requestType {

    NSString *baseURL = @"http://nerine.space:8000/";;
    NSString *method = @"";

    switch (requestType) {
        case LoginRequest:
            method = @"api/user/api-token-auth/";
            break;
        case SitesRequest:
            method = @"api/user/sites/";
            break;
        case RanksRequest:
            method = @"api/user/personrank/";
            break;
        case RanksForPeriodRequest:
            method = @"api/user/period/";
            break;

        default:
            break;
    }

    return [NSString stringWithFormat:@"%@%@",baseURL,method];
}



@end

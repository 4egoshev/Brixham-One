//
//  Router.h
//  Brixham One
//
//  Created by Александр Чегошев on 08.09.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    LoginRequest = 0,
    SitesRequest,
    RanksRequest
} RequestType;

@interface Router : NSObject

@property (assign, nonatomic) RequestType requestType;

+ (Router *)sharedManager;

- (NSString *)stringWithrequestType:(RequestType)requestType;

@end

//
//  ServerManager.h
//  Brixham One
//
//  Created by Александр Чегошев on 29.08.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerManager : NSObject

+(ServerManager *)sharedManager;


- (void)loginWithLogin:(NSString *)login
           andPassword:(NSString *)password
             onSuccees:(void(^)(NSString *accessToken))success
             onFailure:(void(^)(NSError *error))failure;

- (void)getSitesOnSuccees:(void(^)(NSArray *ranksArray))success
                onFailure:(void(^)(NSError *error))failure;


- (void)getRanksForPersonForDateArray:(NSArray *)dateArray
                            fromSite:(NSString *)site
                           onSuccees:(void(^)(NSArray *ranksArray))success
                           onFailure:(void(^)(NSError *error))failure;

- (void)getRanksForSitesForDateArray:(NSArray *)dateArray
                         forPerson:(NSString *)person
                        onSuccees:(void(^)(NSArray *ranksArray))success
                        onFailure:(void(^)(NSError *error))failure;

@end

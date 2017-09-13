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
             onSuccees:(void(^)())success
             onFailure:(void(^)())failure;

- (void)getSitesOnSuccees:(void(^)(NSArray *sitesArray))success
                onFailure:(void(^)(NSError *error))failure;

- (void)getRanksForPersonFromSite:(NSString *)site
                        onSuccees:(void(^)(NSArray *ranksArray))success
                        onFailure:(void(^)(NSError *error))failure;

- (void)getRanksForPersonForDateArray:(NSArray *)dateArray
                            fromSite:(NSString *)site
                           onSuccees:(void(^)(NSArray *ranksArray))success
                           onFailure:(void(^)(NSError *error))failure;

@end

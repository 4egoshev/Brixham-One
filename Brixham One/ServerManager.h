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

-(void)getRanksForPersonSinceDate:(NSDate *)begin
                          forDate:(NSDate *)end
                         fromSite:(NSString *)site
                        onSuccees:(void(^)(NSArray *ranksArray))success
                        onFailure:(void(^)(NSError *error))failure;

@end

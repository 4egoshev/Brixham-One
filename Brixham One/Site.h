//
//  Site.h
//  Brixham One
//
//  Created by Александр Чегошев on 01.09.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Site : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSDate *date;
@property (assign, nonatomic) NSInteger ranks;

@end

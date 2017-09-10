//
//  Person.h
//  Brixham One
//
//  Created by Александр Чегошев on 30.08.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSDate *date;
@property (assign, nonatomic) NSInteger ranks;

@end

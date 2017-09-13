//
//  Person.m
//  Brixham One
//
//  Created by Александр Чегошев on 30.08.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _name = dict[@"Person"];
        NSString *ranksString = dict[@"Rank"];
        _ranks = ranksString.integerValue;
    }
    return self;
}

@end

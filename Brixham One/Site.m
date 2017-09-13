//
//  Site.m
//  Brixham One
//
//  Created by Александр Чегошев on 01.09.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "Site.h"

@implementation Site

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _name = dict[@"Name"];
        _id = (NSInteger)dict[@"id"];
    }
    return self;
}

@end

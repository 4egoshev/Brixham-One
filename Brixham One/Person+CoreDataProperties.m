//
//  Person+CoreDataProperties.m
//  Brixham One
//
//  Created by Александр Чегошев on 01.09.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "Person+CoreDataProperties.h"

@implementation Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Person"];
}

@dynamic name;
@dynamic ranks;

@end

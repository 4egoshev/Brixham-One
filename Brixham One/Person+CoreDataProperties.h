//
//  Person+CoreDataProperties.h
//  Brixham One
//
//  Created by Александр Чегошев on 01.09.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "Person+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int64_t ranks;

@end

NS_ASSUME_NONNULL_END

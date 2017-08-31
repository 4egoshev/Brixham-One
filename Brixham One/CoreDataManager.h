//
//  CoreDataManager.h
//  Brixham One
//
//  Created by Александр Чегошев on 01.09.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

+ (CoreDataManager *)sharedManager;

- (void)saveContext;

@end

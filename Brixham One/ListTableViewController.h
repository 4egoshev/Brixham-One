//
//  SitiesTableViewController.h
//  Stat
//
//  Created by Александр Чегошев on 18.08.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ListDelegate;

@interface ListTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *array;

@property (strong, nonatomic) id<ListDelegate> delegate;

@end

@protocol ListDelegate <NSObject>

- (void)getObject:(NSString *)object;

@end

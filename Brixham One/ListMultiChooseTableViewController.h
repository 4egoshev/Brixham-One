//
//  SitiesTableViewController.h
//  Stat
//
//  Created by Александр Чегошев on 18.08.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@protocol ListMultiChooseDelegate;

@interface ListMultiChooseTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *contentArray;

@property (strong, nonatomic) id<ListMultiChooseDelegate> delegate;

- (instancetype)initWithContentType:(ContentType)contentType andSaveTpe:(SaveType)saveType;

@end

@protocol ListMultiChooseDelegate <NSObject>

- (void)getArray:(NSArray *)array;

@end


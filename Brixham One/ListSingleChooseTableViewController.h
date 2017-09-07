//
//  ListTableViewController.h
//  Brixham One
//
//  Created by Александр Чегошев on 05.09.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@protocol ListDelegate;

@interface ListSingleChooseTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *contentArray;

@property (strong, nonatomic) id<ListDelegate> delegate;

- (instancetype)initWithContentType:(ContentType)contentType andSaveTpe:(SaveType)saveType;

@end

@protocol ListDelegate <NSObject>

- (void)getObject:(NSString *)object;

@end

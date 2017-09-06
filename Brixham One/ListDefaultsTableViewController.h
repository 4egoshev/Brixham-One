//
//  SitiesTableViewController.h
//  Stat
//
//  Created by Александр Чегошев on 18.08.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

//typedef enum {
//    SingleChooseType = 0,
//    MultiChooseType
//}ListType;
//
//typedef enum {
//    NameType = 0,
//    SiteType
//}ContentType;

@interface ListDefaultsTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *array;

- (instancetype)initWithListType:(ListType)listType andContentType:(ContentType)contentType;

@end


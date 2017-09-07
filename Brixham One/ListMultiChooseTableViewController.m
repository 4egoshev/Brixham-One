//
//  SitiesTableViewController.m
//  Stat
//
//  Created by Александр Чегошев on 18.08.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "ListMultiChooseTableViewController.h"
#import "Constants.h"

@interface ListMultiChooseTableViewController ()

@property (strong, nonatomic) NSMutableArray *selectedAray;
@property (assign, nonatomic) NSIndexPath *selectedIndex;
@property (strong, nonatomic) NSMutableArray *selectedIndexArray;

@property (strong, nonatomic) NSString *object;

@property (assign, nonatomic) BOOL isChanged;

@property (assign, nonatomic) ContentType contentType;
@property (assign, nonatomic) SaveType saveType;

@end

@implementation ListMultiChooseTableViewController

- (instancetype)initWithContentType:(ContentType)contentType andSaveTpe:(SaveType)saveType {
    self = [super init];
    if (self) {
        self.contentType = contentType;
        self.saveType = saveType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getIndexSelectedRows];
}

- (void)getIndexSelectedRows {

    switch (self.contentType) {
        case NameType:
        {
            NSData *indexData = [[NSUserDefaults standardUserDefaults] objectForKey:NAME_MULTI_SELECTION_INDEX];
            self.selectedIndexArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:indexData]];
            NSData *arrayData = [[NSUserDefaults standardUserDefaults] objectForKey:NAME_LIST];
            self.selectedAray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:arrayData]];
        }
            break;
        case SiteType:
        {
            NSData *indexData = [[NSUserDefaults standardUserDefaults] objectForKey:SITE_MULTI_SELECTION_INDEX];
            self.selectedIndexArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:indexData]];
            NSData *arrayData = [[NSUserDefaults standardUserDefaults] objectForKey:SITE_LIST];
            self.selectedAray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:arrayData]];
        }
            break;
        default:
            break;
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contentArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    for (NSIndexPath *index in self.selectedIndexArray) {
        if (indexPath.row == index.row) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }

    cell.textLabel.text = self.contentArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    NSString *object = self.contentArray[indexPath.row];

    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.selectedAray addObject:object];
        [self.selectedIndexArray addObject:indexPath];
    } else if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.selectedAray removeObject:object];
        [self.selectedIndexArray removeObject:indexPath];
    }

    switch (self.saveType) {
        case SettingsType:
            [self saveListArray:self.selectedAray andIndexArray:self.selectedIndexArray];
            break;
        case ViewType:
            [self.delegate getArray:self.selectedAray];
            break;
        default:
            break;
    }
    [self saveListArray:self.selectedAray andIndexArray:self.selectedIndexArray];
}

#pragma mark - Save Data

- (void)saveListArray:(NSArray *)listArray andIndexArray:(NSArray *)indexArray {

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:listArray];
    NSData *indexData = [NSKeyedArchiver archivedDataWithRootObject:indexArray];
    switch (self.contentType) {
        case NameType:
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:NAME_LIST];
            [[NSUserDefaults standardUserDefaults] setObject:indexData forKey:NAME_MULTI_SELECTION_INDEX];
            break;
        case SiteType:
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:SITE_LIST];
            [[NSUserDefaults standardUserDefaults] setObject:indexData forKey:SITE_MULTI_SELECTION_INDEX];
            break;
        default:
            break;
    }
}

@end

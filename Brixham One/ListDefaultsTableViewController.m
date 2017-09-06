//
//  SitiesTableViewController.m
//  Stat
//
//  Created by Александр Чегошев on 18.08.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "ListDefaultsTableViewController.h"
#import "Constants.h"

@interface ListDefaultsTableViewController ()

@property (strong, nonatomic) NSMutableArray *selectedAray;
@property (assign, nonatomic) NSIndexPath *selectedIndex;
@property (strong, nonatomic) NSMutableArray *selectedIndexArray;

@property (strong, nonatomic) NSString *object;

@property (assign, nonatomic) BOOL isChanged;

@property (assign, nonatomic) ListType listType;
@property (assign, nonatomic) ContentType contentType;

@end

@implementation ListDefaultsTableViewController

- (instancetype)initWithListType:(ListType)listType andContentType:(ContentType)contentType {
    self = [super init];
    if (self) {
        self.listType = listType;
        self.contentType = contentType;
        self.selectedAray = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    switch (self.listType) {
        case SingleChooseType:
            [self getIndexForSingleRow];
            break;
        case MultiChooseType:
            [self getIndexForMultiRows];
            break;
        default:
            break;
    }
}

- (void)getIndexForSingleRow {

    switch (self.contentType) {
        case NameType:
        {
            NSData *indexData = [[NSUserDefaults standardUserDefaults] objectForKey:NAME_SINGLE_SELECTION_INDEX];
            NSDictionary *indexDict = [NSKeyedUnarchiver unarchiveObjectWithData:indexData];
            NSInteger section = [indexDict[@"section"] integerValue];
            NSInteger row = [indexDict[@"row"] integerValue];
            self.selectedIndex = [NSIndexPath indexPathForRow:row inSection:section];
        }
            break;
        case SiteType:
        {
            NSData *indexData = [[NSUserDefaults standardUserDefaults] objectForKey:SITE_SINGLE_SELECTION_INDEX];
            NSDictionary *indexDict = [NSKeyedUnarchiver unarchiveObjectWithData:indexData];
            NSInteger section = [indexDict[@"section"] integerValue];
            NSInteger row = [indexDict[@"row"] integerValue];
            self.selectedIndex = [NSIndexPath indexPathForRow:row inSection:section];
        }
            break;
        default:
            break;
    }
}

- (void)getIndexForMultiRows {

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
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    switch (self.listType) {
        case SingleChooseType:
            if (indexPath == self.selectedIndex) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            break;
        case MultiChooseType:
            for (NSIndexPath *index in self.selectedIndexArray) {
                if (indexPath.row == index.row) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
            }
            break;
        default:
            break;
    }

    cell.textLabel.text = self.array[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UITableViewCell *selectedSingleCell = [tableView cellForRowAtIndexPath:self.selectedIndex];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    NSString *object = self.array[indexPath.row];

    [self dismissViewControllerAnimated:true completion:nil];

    switch (self.listType) {
        case SingleChooseType:
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            if (!self.isChanged) {
                selectedSingleCell.accessoryType = UITableViewCellAccessoryNone;
                self.isChanged = YES;
            }
            [self saveObject:object forIndexPath:indexPath];
            break;
        case MultiChooseType:
            if (cell.accessoryType == UITableViewCellAccessoryNone) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                [self.selectedAray addObject:object];
                [self.selectedIndexArray addObject:indexPath];
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self.selectedAray removeObject:object];
                [self.selectedIndexArray removeObject:indexPath];
            }
            [self saveListArray:self.selectedAray andIndexArray:self.selectedIndexArray];
            break;
        default:
            break;
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (self.listType == SingleChooseType) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

#pragma mark - Save Data

- (void)saveListArray:(NSArray *)listArray andIndexArray:(NSArray *)indexArray {

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:listArray];
    NSData *indexData = [NSKeyedArchiver archivedDataWithRootObject:indexArray];

    NSLog(@"save count = %ld",listArray.count);
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

- (void)saveObject:(NSString *)object forIndexPath:(NSIndexPath *)indexPath {

    NSData *objectData = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSDictionary *indexDict = [NSDictionary dictionaryWithObjectsAndKeys:
                               @(indexPath.section),@"section",
                               @(indexPath.row),@"row", nil];
    NSData *indexData = [NSKeyedArchiver archivedDataWithRootObject:indexDict];
    switch (self.contentType) {
        case NameType:
            [[NSUserDefaults standardUserDefaults] setObject:objectData forKey:NAME];
            [[NSUserDefaults standardUserDefaults] setObject:indexData forKey:NAME_SINGLE_SELECTION_INDEX];
//            [[NSUserDefaults standardUserDefaults] setObject:indexData forKey:NAME_SELECTION_INDEX_FOR_LIST];
            break;
        case SiteType:
            [[NSUserDefaults standardUserDefaults] setObject:objectData forKey:SITE];
            [[NSUserDefaults standardUserDefaults] setObject:indexData forKey:SITE_SINGLE_SELECTION_INDEX];
//            [[NSUserDefaults standardUserDefaults] setObject:indexData forKey:NAME_SELECTION_INDEX_FOR_LIST];
            break;
        default:
            break;
    }
}

@end

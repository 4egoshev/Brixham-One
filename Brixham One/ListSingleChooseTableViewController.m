//
//  ListTableViewController.m
//  Brixham One
//
//  Created by Александр Чегошев on 05.09.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "ListSingleChooseTableViewController.h"

@interface ListSingleChooseTableViewController ()

@property (assign, nonatomic) ContentType contentType;
@property (assign, nonatomic) SaveType saveType;

@property (strong, nonatomic) NSIndexPath *selectedIndex;

@property (assign, nonatomic) BOOL isChanged;

@end

@implementation ListSingleChooseTableViewController

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

    [self getContent];
}

//Заменить на Core Data
- (void)getContent {

    switch (self.contentType) {
    case NameType:
        {
            NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:NAME_LIST];
            self.contentArray = [NSArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
        }
        break;
    case SiteType:
        {
            NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:SITE_LIST];
            self.contentArray = [NSArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
        }
        break;
    default:
        break;
    }

    [self getIndexForSelectedRow];
}

- (void)getIndexForSelectedRow {

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

    if (indexPath == self.selectedIndex) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    cell.textLabel.text = self.contentArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UITableViewCell *selectedSingleCell = [tableView cellForRowAtIndexPath:self.selectedIndex];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    NSString *object = self.contentArray[indexPath.row];

    NSLog(@"obj = %@", object);
    switch (self.saveType) {
        case SettingsType:
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            if (!self.isChanged) {
                selectedSingleCell.accessoryType = UITableViewCellAccessoryNone;
                self.isChanged = YES;
            }
            [self saveObject:object forIndexPath:indexPath];
            break;
        case ViewType:
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            if (!self.isChanged) {
                selectedSingleCell.accessoryType = UITableViewCellAccessoryNone;
                self.isChanged = YES;
            }
            [self.delegate getObject:object];
            [self dismissViewControllerAnimated:self completion:nil];
            break;
        default:
            break;
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
}

#pragma mark - Save Data

- (void)saveObject:(NSString *)object forIndexPath:(NSIndexPath *)indexPath {
 NSLog(@"obj  save= %@", object);
    NSData *objectData = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSDictionary *indexDict = [NSDictionary dictionaryWithObjectsAndKeys:
                               @(indexPath.section),@"section",
                               @(indexPath.row),@"row", nil];
    NSData *indexData = [NSKeyedArchiver archivedDataWithRootObject:indexDict];
    switch (self.contentType) {
        case NameType:
            [[NSUserDefaults standardUserDefaults] setObject:objectData forKey:NAME];
            [[NSUserDefaults standardUserDefaults] setObject:indexData forKey:NAME_SINGLE_SELECTION_INDEX];
            break;
        case SiteType:
            [[NSUserDefaults standardUserDefaults] setObject:objectData forKey:SITE];
            [[NSUserDefaults standardUserDefaults] setObject:indexData forKey:SITE_SINGLE_SELECTION_INDEX];
            break;
        default:
            break;
    }
}

@end

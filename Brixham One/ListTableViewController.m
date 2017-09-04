//
//  SitiesTableViewController.m
//  Stat
//
//  Created by Александр Чегошев on 18.08.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "ListTableViewController.h"
#import "Constants.h"

@interface ListTableViewController ()

@property (strong, nonatomic) NSMutableArray *selectedAray;
@property (assign, nonatomic) NSIndexPath *selectedindex;
@property (strong, nonatomic) NSString *object;

@property (assign, nonatomic) BOOL isChanged;

@property (assign, nonatomic) ListType listType;
@property (assign, nonatomic) ContentType contentType;

@end

@implementation ListTableViewController

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

    [self getIndex];

}

- (void)getIndex {

    switch (self.contentType) {
        case NameType:
        {
            NSLog(@"name");
            NSData *indexData = [[NSUserDefaults standardUserDefaults] objectForKey:@"SelectedIndexName"];
            NSDictionary *indexDict = [NSKeyedUnarchiver unarchiveObjectWithData:indexData];
            NSInteger section = [indexDict[@"section"] integerValue];
            NSInteger row = [indexDict[@"row"] integerValue];
            self.selectedindex = [NSIndexPath indexPathForRow:row inSection:section];
            NSLog(@"index = %@",self.selectedindex);
        }
            break;
        case SiteType:
        {
            NSLog(@"site");
            NSData *indexData = [[NSUserDefaults standardUserDefaults] objectForKey:@"SelectedIndexSite"];
            NSDictionary *indexDict = [NSKeyedUnarchiver unarchiveObjectWithData:indexData];
            NSInteger section = [indexDict[@"section"] integerValue];
            NSInteger row = [indexDict[@"row"] integerValue];
            self.selectedindex = [NSIndexPath indexPathForRow:row inSection:section];
            NSLog(@"index = %@",self.selectedindex);
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
            if (indexPath == self.selectedindex) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            break;
        case MultiChooseType:
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
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
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:self.selectedindex];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    NSString *object = self.array[indexPath.row];
    self.selectedAray = self.array.mutableCopy;

    [self.delegate getObject:object];
    [self dismissViewControllerAnimated:true completion:nil];

    switch (self.listType) {
        case SingleChooseType:
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            if (!self.isChanged) {
                selectedCell.accessoryType = UITableViewCellAccessoryNone;
                self.isChanged = YES;
            }
            [self saveObject:object forIndexPath:indexPath];
            break;
        case MultiChooseType:
            if (cell.accessoryType == UITableViewCellAccessoryNone) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                [self.selectedAray addObject:object];
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self.selectedAray removeObject:object];
            }

            NSLog(@"selected array = %@",self.selectedAray);
            [self saveListArray:self.selectedAray];
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

- (void)saveListArray:(NSArray *)listArray {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:listArray];
    switch (self.contentType) {
        case NameType:
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"NameList"];
            break;
        case SiteType:
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"SiteList"];
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
            NSLog(@"name type");
            [[NSUserDefaults standardUserDefaults] setObject:objectData forKey:@"Name"];
            [[NSUserDefaults standardUserDefaults] setObject:indexData forKey:@"SelectedIndexName"];
            break;
        case SiteType:
            NSLog(@"site type");
            [[NSUserDefaults standardUserDefaults] setObject:objectData forKey:@"Site"];
            [[NSUserDefaults standardUserDefaults] setObject:indexData forKey:@"SelectedIndexSite"];
            break;
        default:
            break;
    }
}

@end

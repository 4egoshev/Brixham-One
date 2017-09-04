//
//  SitiesTableViewController.m
//  Stat
//
//  Created by Александр Чегошев on 18.08.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "ListTableViewController.h"

@interface ListTableViewController ()

@property (strong, nonatomic) NSMutableArray *selectedAray;
@property (strong, nonatomic) NSString *object;

@end

@implementation ListTableViewController

- (instancetype)initWithListType:(ListType)listType andContentType:(ContentType)contentType {
    self = [super init];
    if (self) {
        self.listType = listType;
        self.contentType = contentType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
//        if (self.listType == SingleChooseType) {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        }
    }
    if (self.listType == MultiChooseType) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }

    
    cell.textLabel.text = self.array[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    NSString *object = self.array[indexPath.row];

    [self.delegate getObject:object];
    [self dismissViewControllerAnimated:true completion:nil];

    switch (self.listType) {
        case SingleChooseType:
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [self saveObject:object];
            break;
        case MultiChooseType:
            if (cell.accessoryType == UITableViewCellAccessoryNone) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                [self.selectedAray addObject:object];
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self.selectedAray removeObject:object];
            }
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

- (void)saveObject:(NSString *)object {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    switch (self.contentType) {
        case NameType:
            NSLog(@"name type");
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"Name"];
            break;
        case SiteType:
            NSLog(@"site type");
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"Site"];
            break;
        default:
            break;
    }
}

@end

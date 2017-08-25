//
//  StatSitiesTableViewController.m
//  Brixham One
//
//  Created by Александр Чегошев on 26.08.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "StatSitesTableViewController.h"
#import "ListTableViewController.h"

@interface StatSitesTableViewController () <ListDelegate>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *sitesArray;

@end

@implementation StatSitesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sitesArray = [NSArray arrayWithObjects:@"www.mail.ru",@"www.yandex.ru",@"www.rambler.ru",@"www.google.com",@"www.yahoo.com",nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    NSLog(@"name = %@",self.name);
}

- (IBAction)reloadAction:(id)sender {
    NSLog(@"Reload");
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sitesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SityCell" forIndexPath:indexPath];

    cell.textLabel.text = self.sitesArray[indexPath.row];
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"toNameList"]) {
        ListTableViewController *lvc = [segue destinationViewController];
        lvc.array = [NSArray arrayWithObjects:@"Путин",@"Медведев",@"Навальный", nil];

        lvc.delegate = self;
    }
}

#pragma mark - ListDelegate

- (void)getObject:(NSString *)object {
    self.name = object;
}

@end

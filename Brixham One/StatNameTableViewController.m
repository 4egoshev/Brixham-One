//
//  StaticTableViewController.m
//  Stat
//
//  Created by Александр Чегошев on 18.08.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "StatNameTableViewController.h"
#import "ListTableViewController.h"
#import "DateViewController.h"

@interface StatNameTableViewController () <ListDelegate, DateDelegate>

@property (strong, nonatomic) NSString *site;
@property (strong, nonatomic) NSArray *dateArray;
@property (strong, nonatomic) NSArray *namesAraay;

@end

@implementation StatNameTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.namesAraay = [NSArray arrayWithObjects:@"Путин",@"Медведев",@"Навальный", nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    NSLog(@"site = %@",self.site);
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
   return self.namesAraay.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NameCell" forIndexPath:indexPath];

    cell.textLabel.text = self.namesAraay[indexPath.row];

    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"toSiteList"]) {
        ListTableViewController *lvc = [segue destinationViewController];
        lvc.array = [NSArray arrayWithObjects:@"www.mail.ru",@"www.yandex.ru",@"www.rambler.ru",@"www.google.com",@"www.yahoo.com",nil];

        lvc.delegate = self;
    }

}

#pragma mark - ListDelegate

- (void)getObject:(NSString *)object {
    self.site = object;
}

#pragma mark - DateDelegate

- (void)getDateArray:(NSArray *)dateArray {
    self.dateArray = dateArray;
}

@end

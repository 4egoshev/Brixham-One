//
//  StatTableViewController.m
//  Brixham One
//
//  Created by Александр Чегошев on 27.08.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "StatTableViewController.h"
#import "ListTableViewController.h"

@interface StatTableViewController ()

@property (strong, nonatomic) NSString *site;
@property (strong, nonatomic) NSArray *dateArray;

@property (strong, nonatomic) NSArray *namesArray;
@property (strong, nonatomic) NSArray *sitesArray;
@property (copy, nonatomic) NSArray *array;
@end

@implementation StatTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.namesArray = [NSArray arrayWithObjects:@"Путин",@"Медведев",@"Навальный", nil];
    self.sitesArray = [NSArray arrayWithObjects:@"www.mail.ru",@"www.yandex.ru",@"www.rambler.ru",@"www.google.com",@"www.yahoo.com",nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    NSLog(@"site = %@",self.site);

    if (self.tabBarController.selectedViewController == self.tabBarController.viewControllers[0]) {
        self.array = self.namesArray;
    } else {
        self.array = self.sitesArray;
    }
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
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.textLabel.text = self.array[indexPath.row];

    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"toSiteList"]) {
        ListTableViewController *lvc = [segue destinationViewController];
        lvc.array = self.sitesArray;

        lvc.delegate = self;
    } else if ([segue.identifier isEqualToString:@"toNameList"]) {
        ListTableViewController *lvc = [segue destinationViewController];
        lvc.array = self.namesArray;

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

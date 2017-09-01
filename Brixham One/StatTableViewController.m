//
//  StatTableViewController.m
//  Brixham One
//
//  Created by Александр Чегошев on 27.08.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "StatTableViewController.h"
#import "ListTableViewController.h"
#import "DateViewController.h"
#import "SWRevealViewController.h"
#import "ServerManager.h"
#import <AFNetworking.h>

@interface StatTableViewController () <ListDelegate, DateDelegate>

@property (strong, nonatomic) NSString *object;
@property (strong, nonatomic) NSArray *dateArray;

@property (strong, nonatomic) NSArray *namesArray;
@property (strong, nonatomic) NSArray *sitesArray;
@property (copy, nonatomic) NSArray *array;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end

@implementation StatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.namesArray = [NSMutableArray arrayWithObjects:@"Путин",@"Медведев",@"Навальный", nil];
//    self.sitesArray = [NSArray arrayWithObjects:@"www.mail.ru",@"www.yandex.ru",@"www.rambler.ru",@"www.google.com",@"www.yahoo.com",nil];

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }


//Server response

    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

    [self getRanksFromServer];

    if (!self.dateArray) {
        self.navigationItem.title = @"Сегодня";
    } else {
        self.navigationItem.title = [NSString stringWithFormat:@"%@-%@",self.dateArray[0],self.dateArray[1]];
    }
}

#pragma mark - Server

- (void)getRanksFromServer {

    NSLog(@"date = %@", self.dateArray);

    if (self.tabBarController.selectedViewController == self.tabBarController.viewControllers[0]) {
        [[ServerManager sharedManager] getRanksForPersonForDateArray:self.dateArray
                                                            fromSite:self.object
                                                           onSuccees:^(NSArray *ranksArray) {
                                                               self.array = ranksArray;
                                                           }
                                                            onFailure:^(NSError *error) {
                                                                NSLog(@"%@",error.localizedDescription);
                                                            }];
    } else {
        [[ServerManager sharedManager] getRanksForSitesForDateArray:self.dateArray
                                                          forPerson:self.object
                                                          onSuccees:^(NSArray *ranksArray) {
                                                              self.array = ranksArray;
                                                          }
                                                          onFailure:^(NSError *error) {
                                                              NSLog(@"%@",error.localizedDescription);
                                                          }];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.textLabel.text = self.array[indexPath.row];

    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"toList"] && self.tabBarController.selectedViewController == self.tabBarController.viewControllers[0]) {
        ListTableViewController *lvc = [segue destinationViewController];
        lvc.array = self.sitesArray;
        lvc.delegate = self;

    } else if ([segue.identifier isEqualToString:@"toList"] && self.tabBarController.selectedViewController == self.tabBarController.viewControllers[1]) {
        ListTableViewController *lvc = [segue destinationViewController];
        lvc.array = self.namesArray;
        lvc.delegate = self;

    } else if ([segue.identifier isEqualToString:@"toDate"]) {
        DateViewController *dvc = [segue destinationViewController];
        dvc.delegate = self;
    }


}

#pragma mark - ListDelegate

- (void)getObject:(NSString *)object {
    self.object = object;
}

#pragma mark - DateDelegate

- (void)getDateArray:(NSArray *)dateArray {
    self.dateArray = dateArray;
}


@end

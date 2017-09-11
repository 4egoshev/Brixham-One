//
//  StatTableViewController.m
//  Brixham One
//
//  Created by Александр Чегошев on 27.08.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "StatTableViewController.h"
#import "ListSingleChooseTableViewController.h"
#import "DateViewController.h"
#import "SWRevealViewController.h"
#import "ServerManager.h"

@interface StatTableViewController () <ListDelegate, DateDelegate>

@property (strong, nonatomic) NSString *object;
@property (strong, nonatomic) NSArray *dateArray;

@property (strong, nonatomic) NSArray *namesArray;
@property (strong, nonatomic) NSArray *sitesArray;
@property (copy, nonatomic) NSArray *array;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *listButton;

@end

@implementation StatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.namesArray = [NSArray arrayWithObjects:@"Путин",@"Медведев",@"Навальный", nil];
    self.sitesArray = [NSArray arrayWithObjects:@"www.mail.ru",@"www.yandex.ru",@"www.rambler.ru",@"www.google.com",@"www.yahoo.com",nil];

    [self getContentFromServer];

    NSLog(@"date = %@",self.dateArray);
    [self sideBarButtonAction];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

    if (self.tabBarController.selectedViewController == self.tabBarController.viewControllers.firstObject) {
        self.array = self.namesArray;
    } else {
        self.array = self.sitesArray;
    }
    
    if (!self.dateArray) {
        self.navigationItem.title = @"Сегодня";
    } else {
        self.navigationItem.title = [NSString stringWithFormat:@"%@-%@",self.dateArray[0],self.dateArray[1]];
    }
}

- (void)sideBarButtonAction {

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)getContentFromServer {
    [[ServerManager sharedManager] getRanksForPersonForDateArray:self.dateArray
                                                        fromSite:self.sitesArray[0]
                                                       onSuccees:^(NSArray *ranksArray) {

                                                       }
                                                       onFailure:^(NSError *error) {

                                                       }];
}

- (IBAction)listButtonAction:(id)sender {

    if (self.tabBarController.selectedViewController == self.tabBarController.viewControllers.firstObject) {
        ListSingleChooseTableViewController *lvc = [[ListSingleChooseTableViewController alloc] initWithContentType:SiteType andSaveTpe:ViewType];
        lvc.delegate = self;
        [self.navigationController presentViewController:lvc animated:YES completion:nil];
    } else {
        ListSingleChooseTableViewController *lvc = [[ListSingleChooseTableViewController alloc] initWithContentType:NameType andSaveTpe:ViewType];
        lvc.delegate = self;
        [self.navigationController presentViewController:lvc animated:YES completion:nil];;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

//    if ([segue.identifier isEqualToString:@"toList"] && self.tabBarController.selectedViewController == self.tabBarController.viewControllers[0]) {
//        ListTableViewController *lvc = [segue destinationViewController];
//        lvc.array = self.sitesArray;
//        lvc.delegate = self;
//
//    } else if ([segue.identifier isEqualToString:@"toList"] && self.tabBarController.selectedViewController == self.tabBarController.viewControllers[1]) {
//        ListTableViewController *lvc = [segue destinationViewController];
//        lvc.array = self.namesArray;
//        lvc.delegate = self;
//
//    } else if ([segue.identifier isEqualToString:@"toDate"]) {
//        DateViewController *dvc = [segue destinationViewController];
//        dvc.delegate = self;
//    }


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

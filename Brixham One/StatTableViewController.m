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
#import "DateView.h"
#import "Site.h"
#import "Person.h"

@interface StatTableViewController () <ListDelegate, DateDelegate>

@property (strong, nonatomic) NSString *object;
@property (strong, nonatomic) NSArray *dateArray;

@property (copy, nonatomic) NSArray *contentArray;

@property (strong, nonatomic) IBOutlet UITableView *dateView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *listButton;

@end

@implementation StatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self sideBarButtonAction];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

    [self chooseData];
//    [self chooseController];
//    [self getSitesArrayFromServer];
    [self loadNavView];
    [self getContentFromServer];
}

#pragma mark - Config View

- (void)chooseData {

    if (!self.dateArray) {
        NSData *dateData = [[NSUserDefaults standardUserDefaults] objectForKey:DATE];
        self.dateArray = [NSKeyedUnarchiver unarchiveObjectWithData:dateData];
        if (!self.dateArray) {
            [self configDateToday];
        }
    }
    if (!self.object) {
        NSData *siteData = [[NSUserDefaults standardUserDefaults] objectForKey:SITE];
        self.object = [NSKeyedUnarchiver unarchiveObjectWithData:siteData];
    }
}

- (void)configDateToday {

    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd.MM.yy"];
    NSString *todayString = [formatter stringFromDate:today];
    self.dateArray = [NSArray arrayWithObjects:todayString,todayString, nil];
}

/*
- (void)chooseController {

    if (self.tabBarController.selectedViewController == self.tabBarController.viewControllers.firstObject) {
        self.contentArray = self.namesArray;
    } else {
        self.contentArray = self.sitesArray;
    }
}
 */

- (void)loadNavView {

    DateView *dateView = [[NSBundle mainBundle] loadNibNamed:@"DateView" owner:self options:nil].firstObject;
    self.navigationItem.titleView = dateView;

    [dateView configTitleWithObject:self.object andDateArray:self.dateArray];
}

#pragma mark - Server

- (void)getSitesArrayFromServer {

    [[ServerManager sharedManager] getSitesOnSuccees:^(NSArray *sitesArray) {
//                                                Site *site = sitesArray.firstObject;
//                                                self.object = site.name;
                                                [self getContentFromServer];
                                                [self loadNavView];
                                           }
                                           onFailure:^(NSError *error) {

                                           }];
}

- (void)getContentFromServer {

    [[ServerManager sharedManager] getRanksForPersonFromSite:self.object
                                                   onSuccees:^(NSArray *ranksArray) {

                                                       self.contentArray = ranksArray;
                                                       [self.tableView reloadData];

                                                   }
                                                   onFailure:^(NSError *error) {
                                                   }];
}

#pragma mark - Navigation Buttons

- (void)sideBarButtonAction {

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
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
    return self.contentArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Person *person = self.contentArray[indexPath.row];
    cell.textLabel.text = person.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",person.ranks];
    return cell;
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

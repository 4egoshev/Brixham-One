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

@interface StatTableViewController () <ListDelegate, DateDelegate>

@property (strong, nonatomic) NSString *object;
@property (strong, nonatomic) NSArray *dateArray;

@property (strong, nonatomic) NSArray *namesArray;
@property (strong, nonatomic) NSArray *sitesArray;
@property (copy, nonatomic) NSArray *array;

@property (strong, nonatomic) IBOutlet UITableView *dateView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *listButton;

@end

@implementation StatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.namesArray = [NSArray arrayWithObjects:@"Путин",@"Медведев",@"Навальный", nil];
    self.sitesArray = [NSArray arrayWithObjects:@"www.mail.ru",@"www.yandex.ru",@"www.rambler.ru",@"www.google.com",@"www.yahoo.com",nil];

    NSLog(@"date = %@",self.dateArray);
    [self sideBarButtonAction];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

    if (!self.dateArray) {
        NSData *dateData = [[NSUserDefaults standardUserDefaults] objectForKey:DATE];
        self.dateArray = [NSKeyedUnarchiver unarchiveObjectWithData:dateData];
    }
    if (!self.object) {
        NSData *siteData = [[NSUserDefaults standardUserDefaults] objectForKey:SITE];
        self.object = [NSKeyedUnarchiver unarchiveObjectWithData:siteData];
    }

    DateView *dateView = [[NSBundle mainBundle] loadNibNamed:@"DateView" owner:self options:nil].firstObject;
    self.navigationItem.titleView = dateView;

    [dateView configTitleWithObject:self.object andDateArray:self.dateArray];


    if (self.tabBarController.selectedViewController == self.tabBarController.viewControllers.firstObject) {
        self.array = self.namesArray;
    } else {
        self.array = self.sitesArray;
    }
    [self getSitesArrayFromSeever];
//    [self getContentFromServer];
}


#pragma mark - Server

- (void)getSitesArrayFromSeever {

    [[ServerManager sharedManager] getSitesOnSuccees:^(NSArray *sitesArray) {
                                                Site *site = sitesArray.firstObject;
                                                self.object = site.name;
                                                [self getContentFromServer];
                                           }
                                           onFailure:^(NSError *error) {

                                           }];
}

- (void)getContentFromServer {

    [[ServerManager sharedManager] getRanksForPersonFromSite:self.object
                                                   onSuccees:^(NSArray *ranksArray) {

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

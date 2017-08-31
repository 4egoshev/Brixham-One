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
#import "Person+CoreDataClass.h"
#import "CoreDataManager.h"

@interface StatTableViewController () <ListDelegate, DateDelegate>

@property (strong, nonatomic) NSString *object;
@property (strong, nonatomic) NSArray *dateArray;

@property (strong, nonatomic) NSArray *namesArray;
@property (strong, nonatomic) NSArray *sitesArray;
@property (copy, nonatomic) NSArray *array;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end

@implementation StatTableViewController

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize managedObjectContext = _managedObjectContext;


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.namesArray = [NSArray arrayWithObjects:@"Путин",@"Медведев",@"Навальный", nil];
//    self.sitesArray = [NSArray arrayWithObjects:@"www.mail.ru",@"www.yandex.ru",@"www.rambler.ru",@"www.google.com",@"www.yahoo.com",nil];

    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person"
                                                   inManagedObjectContext:_managedObjectContext];
    person.name = @"Путин";
//    [[CoreDataManager sharedManager] saveContext];
    [self.managedObjectContext save:nil];


    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

    NSLog(@"date = %@", self.dateArray);

    if (self.tabBarController.selectedViewController == self.tabBarController.viewControllers[0]) {
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

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    [fetchRequest setFetchBatchSize:20];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];

    NSFetchedResultsController *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:_managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];

    aFetchedResultsController.delegate = self;

    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }

    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
}

#pragma mark - Table view data source

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

    Person *person = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = person.name;
}

/*
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
*/

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

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
#import "Person.h"

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
    self.namesArray = [NSMutableArray arrayWithObjects:@"Путин",@"Медведев",@"Навальный", nil];
    self.sitesArray = [NSArray arrayWithObjects:@"www.mail.ru",@"www.yandex.ru",@"www.rambler.ru",@"www.google.com",@"www.yahoo.com",nil];

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

#pragma mark - Server

- (void)getRanksFromServer {

    NSDate *begin = self.dateArray[0];
    NSDate *end = self.dateArray[1];

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"beginDate",begin,
                            @"endDate",end,
                            @"site",self.object, nil];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"API"
      parameters:params
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

             NSArray *responseArray = responseObject[@"response"];

             for (NSDictionary *dict in responseObject) {
                 NSArray *personsArray = [dict objectForKey:@""];
                 NSMutableArray *array = [NSMutableArray new];

                 for (int i=0; i<personsArray.count; i++) {
                     Person *person = [Person new];
                     person.name = personsArray[i][@""];
                     person.ranks = personsArray[i][@""];
                     person.date = dict[@""];

                     [array addObject:person];

                 }
             }

         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             <#code#>
         }];
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

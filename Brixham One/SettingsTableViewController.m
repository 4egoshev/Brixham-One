//
//  SettingsTableViewController.m
//  Brixham One
//
//  Created by Александр Чегошев on 04.09.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "SWRevealViewController.h"
#import "ListTableViewController.h"

#define SECOND_SECTION 1
#define FIRST_ROW 0
#define SECOND_ROW 1
#define THIRD_ROW 2
#define FOUTH_ROW 3

@interface SettingsTableViewController ()

@property (strong, nonatomic) NSArray *namesArray;
@property (strong, nonatomic) NSArray *sitesArray;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UILabel *choosedNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *choosedSiteLabel;

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sidebarButton];
    
    self.namesArray = [NSArray arrayWithObjects:@"Путин",@"Медведев",@"Навальный", nil];
    self.sitesArray = [NSArray arrayWithObjects:@"www.mail.ru",@"www.yandex.ru",@"www.rambler.ru",@"www.google.com",@"www.yahoo.com",nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    NSData *nameData = [[NSUserDefaults standardUserDefaults] objectForKey:@"Name"];
    self.choosedNameLabel.text = [NSKeyedUnarchiver unarchiveObjectWithData:nameData];
    NSData *siteData = [[NSUserDefaults standardUserDefaults] objectForKey:@"Site"];
    self.choosedSiteLabel.text = [NSKeyedUnarchiver unarchiveObjectWithData:siteData];

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

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"row = %ld",indexPath.row);

    ListTableViewController *lvc = [ListTableViewController new];
    if (indexPath.section == SECOND_SECTION) {
        switch (indexPath.row) {
            case FIRST_ROW:
                lvc.array = self.namesArray;
                lvc.listType = MultiChooseType;
                lvc.contentType = NameType;
                [self.navigationController pushViewController:lvc animated:YES];
                break;
            case SECOND_ROW:
                lvc.array = self.namesArray;
                lvc.listType = SingleChooseType;
                lvc.contentType = NameType;
                [self.navigationController pushViewController:lvc animated:YES];
                break;
            case THIRD_ROW:
                lvc.array = self.sitesArray;
                lvc.listType = MultiChooseType;
                lvc.contentType = SiteType;
                [self.navigationController pushViewController:lvc animated:YES];
                break;
            case FOUTH_ROW:
                lvc.array = self.sitesArray;
                lvc.listType = SingleChooseType;
                lvc.contentType = SiteType;
                [self.navigationController pushViewController:lvc animated:YES];
                break;
            default:
                break;
        }
    }
}

@end

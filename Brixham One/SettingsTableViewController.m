//
//  SettingsTableViewController.m
//  Brixham One
//
//  Created by Александр Чегошев on 04.09.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "SWRevealViewController.h"
#import "ListDefaultsTableViewController.h"
#import "Constants.h"

@interface SettingsTableViewController ()

@property (strong, nonatomic) NSArray *namesArray;
@property (strong, nonatomic) NSArray *sitesArray;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) IBOutlet UILabel *nameCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *siteCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *choosedNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *choosedSiteLabel;

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sideBarButtonAction];
    
    self.namesArray = [NSArray arrayWithObjects:@"Путин",@"Медведев",@"Навальный", nil];
    self.sitesArray = [NSArray arrayWithObjects:@"www.mail.ru",@"www.yandex.ru",@"www.rambler.ru",@"www.google.com",@"www.yahoo.com",nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

    [self loadDataForRows];
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

- (void)loadDataForRows {

    NSData *nameData = [[NSUserDefaults standardUserDefaults] objectForKey:NAME];
    self.choosedNameLabel.text = [NSKeyedUnarchiver unarchiveObjectWithData:nameData];
    NSData *siteData = [[NSUserDefaults standardUserDefaults] objectForKey:SITE];
    self.choosedSiteLabel.text = [NSKeyedUnarchiver unarchiveObjectWithData:siteData];

    NSData *nameArrayData = [[NSUserDefaults standardUserDefaults] objectForKey:NAME_MULTI_SELECTION_INDEX];
    NSArray *nameArray = [NSKeyedUnarchiver unarchiveObjectWithData:nameArrayData];
    self.nameCountLabel.text = [NSString stringWithFormat:@"%ld",nameArray.count];
    NSData *siteArrayData = [[NSUserDefaults standardUserDefaults] objectForKey:SITE_MULTI_SELECTION_INDEX];
    NSArray *siteArray = [NSKeyedUnarchiver unarchiveObjectWithData:siteArrayData];
    self.siteCountLabel.text = [NSString stringWithFormat:@"%ld",siteArray.count];
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == SECOND_SECTION) {
        switch (indexPath.row) {
            case FIRST_ROW:
            {
                ListDefaultsTableViewController *lvc = [[ListDefaultsTableViewController alloc] initWithListType:MultiChooseType
                                                                                                  andContentType:NameType];
                lvc.array = self.namesArray;
                [self.navigationController pushViewController:lvc animated:YES];
            }
                break;
            case SECOND_ROW:
            {
                ListDefaultsTableViewController *lvc = [[ListDefaultsTableViewController alloc] initWithListType:SingleChooseType
                                                                                                  andContentType:NameType];
                lvc.array = self.namesArray;
                [self.navigationController pushViewController:lvc animated:YES];
            }
                break;
            case THIRD_ROW:
            {
                ListDefaultsTableViewController *lvc = [[ListDefaultsTableViewController alloc] initWithListType:MultiChooseType
                                                                                                  andContentType:SiteType];
                lvc.array = self.sitesArray;
                [self.navigationController pushViewController:lvc animated:YES];
            }
                break;
            case FOUTH_ROW:
            {
                ListDefaultsTableViewController *lvc = [[ListDefaultsTableViewController alloc] initWithListType:SingleChooseType
                                                                                                  andContentType:SiteType];
                lvc.array = self.sitesArray;
                [self.navigationController pushViewController:lvc animated:YES];
            }
                break;
            default:
                break;
        }
    }
}

@end

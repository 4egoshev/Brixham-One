//
//  PieViewController.m
//  Brixham One
//
//  Created by Александр Чегошев on 11.09.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "PieViewController.h"
#import <drCharts/DrGraphs.h>
#import "Constants.h"
#import "SWRevealViewController.h"
#import "ServerManager.h"
#import "ListSingleChooseTableViewController.h"
#import "DateView.h"

@interface PieViewController () <PieChartDataSource,PieChartDelegate>

@property (strong, nonatomic) NSString *object;
@property (strong, nonatomic) NSArray *dateArray;

@property (strong, nonatomic) NSArray *contentArray;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIView *pieView;

@end

@implementation PieViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadNavView];
    [self sideBarButtonAction];
    [self createPieChart];
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
    NSLog(@"date = %@",self.dateArray);
    NSLog(@"site = %@",self.object);
}

- (void)configDateToday {

    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd.MM.yy"];
    NSString *todayString = [formatter stringFromDate:today];
    self.dateArray = [NSArray arrayWithObjects:todayString,todayString, nil];
}

- (void)loadNavView {

    DateView *dateView = [[NSBundle mainBundle] loadNibNamed:@"DateView" owner:self options:nil].firstObject;
    self.navigationItem.titleView = dateView;

    [dateView configTitleWithObject:self.object andDateArray:self.dateArray];
}

- (IBAction)listButtonAction:(id)sender {

    ListSingleChooseTableViewController *lvc = [[ListSingleChooseTableViewController alloc] initWithContentType:SiteType andSaveTpe:ViewType];
    lvc.delegate = self;
    [self.navigationController presentViewController:lvc animated:YES completion:nil];
}


#pragma mark - Server

- (void)getContentFromServer {

    [[ServerManager sharedManager] getRanksForPersonFromSite:self.object
                                                   onSuccees:^(NSArray *ranksArray) {

                                                       self.contentArray = ranksArray;
                                                   }
                                                   onFailure:^(NSError *error) {
                                                   }];
}

#pragma - mark CreatePieChart

- (void)createPieChart{
    PieChart *chart = [[PieChart alloc] initWithFrame:CGRectMake(0, header_height, WIDTH(self.view), (HEIGHT(self.view) - header_height)/2)];
    [chart setDataSource:self];
    [chart setDelegate:self];
    [chart setLegendViewType:LegendTypeHorizontal];
    [chart setShowCustomMarkerView:TRUE];
    [chart drawPieChart];
    [self.view addSubview:chart];
}

#pragma - mark PieChartDataSource
- (NSInteger)numberOfValuesForPieChart{
    return self.contentArray.count;
}

- (UIColor *)colorForValueInPieChartWithIndex:(NSInteger)lineNumber{
    NSInteger aRedValue = arc4random()%255;
    NSInteger aGreenValue = arc4random()%255;
    NSInteger aBlueValue = arc4random()%255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue/255.0f green:aGreenValue/255.0f blue:aBlueValue/255.0f alpha:1.0f];
    return randColor;
}

- (NSString *)titleForValueInPieChartWithIndex:(NSInteger)index{
    return [NSString stringWithFormat:@"data %ld",(long)index];
}

- (NSNumber *)valueInPieChartWithIndex:(NSInteger)index{
    return [NSNumber numberWithLong:random() % 100];
}

- (UIView *)customViewForPieChartTouchWithValue:(NSNumber *)value{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor whiteColor]];
    [view.layer setCornerRadius:4.0F];
    [view.layer setBorderWidth:1.0F];
    [view.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [view.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [view.layer setShadowRadius:2.0F];
    [view.layer setShadowOpacity:0.3F];

    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont systemFontOfSize:12]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:[NSString stringWithFormat:@"Pie Data: %@", value]];
    [label setFrame:CGRectMake(0, 0, 100, 30)];
    [view addSubview:label];

    [view setFrame:label.frame];
    return view;
}

#pragma - mark PieChartDelegate
- (void)didTapOnPieChartWithValue:(NSString *)value{
    NSLog(@"Pie Chart: %@",value);
}

@end

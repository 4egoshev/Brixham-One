//
//  PieViewController.m
//  Brixham One
//
//  Created by Александр Чегошев on 29.08.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "PieViewController.h"
#import "SWRevealViewController.h"
#import "PieChart.h"
#import "Constants.h"

#define header_height 65

@interface PieViewController () <PieChartDataSource,PieChartDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end

@implementation PieViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [self createPieChart];
}

#pragma Mark CreatePieChart
- (void)createPieChart{
    PieChart *chart = [[PieChart alloc] initWithFrame:CGRectMake(0, header_height, WIDTH(self.view), (HEIGHT(self.view) - header_height)/2)];
    [chart setDataSource:self];
    [chart setDelegate:self];
    [chart setLegendViewType:LegendTypeHorizontal];
    [chart setShowCustomMarkerView:TRUE];
    [chart drawPieChart];
    [self.view addSubview:chart];
}

#pragma mark PieChartDataSource
- (NSInteger)numberOfValuesForPieChart{
    return 8;
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

#pragma mark PieChartDelegate
- (void)didTapOnPieChartWithValue:(NSString *)value{
    NSLog(@"Pie Chart: %@",value);
}

@end

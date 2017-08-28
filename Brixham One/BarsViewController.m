//
//  BarsViewController.m
//  Brixham One
//
//  Created by Александр Чегошев on 28.08.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "BarsViewController.h"
#import "SWRevealViewController.h"
#import "BarChart.h"
#import "Constants.h"

#define header_height 65

@interface BarsViewController () <BarChartDataSource,BarChartDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end

@implementation BarsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [self createBarChart];
}

#pragma Mark CreateHorizontalChart

- (void)createBarChart{
    BarChart *barChartView = [[BarChart alloc] initWithFrame:CGRectMake(0, header_height, WIDTH(self.view), HEIGHT(self.view) - header_height)];
    [barChartView setDataSource:self];
    [barChartView setDelegate:self];

    [barChartView setShowLegend:TRUE];
    [barChartView setLegendViewType:LegendTypeHorizontal];

    [barChartView setDrawGridY:TRUE];
    [barChartView setDrawGridX:TRUE];

    [barChartView setGridLineColor:[UIColor lightGrayColor]];
    [barChartView setGridLineWidth:0.3];

    [barChartView setTextFontSize:12];
    [barChartView setTextColor:[UIColor blackColor]];
    [barChartView setTextFont:[UIFont systemFontOfSize:barChartView.textFontSize]];

    [barChartView setShowCustomMarkerView:TRUE];
    [barChartView drawBarGraph];

    [self.view addSubview:barChartView];
}

#pragma mark BarChartDataSource

- (NSMutableArray *)xDataForBarChart{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 20; i++) {
        [array addObject:[NSString stringWithFormat:@"%d", 2000 + i]];
    }
    return  array;
}

- (NSInteger)numberOfBarsToBePlotted{
    return 2;
}

- (UIColor *)colorForTheBarWithBarNumber:(NSInteger)barNumber{
    NSInteger aRedValue = arc4random()%255;
    NSInteger aGreenValue = arc4random()%255;
    NSInteger aBlueValue = arc4random()%255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue/255.0f green:aGreenValue/255.0f blue:aBlueValue/255.0f alpha:1.0f];
    return randColor;
}

- (CGFloat)widthForTheBarWithBarNumber:(NSInteger)barNumber{
    return 40;
}

- (NSString *)nameForTheBarWithBarNumber:(NSInteger)barNumber{
    return [NSString stringWithFormat:@"Data %d",(int)barNumber];
}

- (NSMutableArray *)yDataForBarWithBarNumber:(NSInteger)barNumber{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 20; i++) {
        [array addObject:[NSNumber numberWithLong:random() % 100]];
    }
    return array;
}

- (UIView *)customViewForBarChartTouchWithValue:(NSNumber *)value{
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
    [label setText:[NSString stringWithFormat:@"Bar Data: %@", value]];
    [label setFrame:CGRectMake(0, 0, 100, 30)];
    [view addSubview:label];

    [view setFrame:label.frame];
    return view;
}

#pragma mark BarChartDelegate

- (void)didTapOnBarChartWithValue:(NSString *)value{
    NSLog(@"Bar Chart: %@",value);
}

@end

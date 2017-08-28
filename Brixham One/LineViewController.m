//
//  LineViewController.m
//  Brixham One
//
//  Created by Александр Чегошев on 28.08.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "LineViewController.h"
#import "SWRevealViewController.h"
#import "MultiLineGraphView.h"
#import "Constants.h"

#define header_height 65

@interface LineViewController () <MultiLineGraphViewDataSource,MultiLineGraphViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end

@implementation LineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [self createLineGraph];
}

#pragma Mark CreateLineGraph

- (void)createLineGraph{
    MultiLineGraphView *graph = [[MultiLineGraphView alloc] initWithFrame:CGRectMake(0, header_height, WIDTH(self.view), HEIGHT(self.view) - header_height)];

    [graph setDelegate:self];
    [graph setDataSource:self];

    [graph setShowLegend:TRUE];
    [graph setLegendViewType:LegendTypeHorizontal];

    [graph setDrawGridY:TRUE];
    [graph setDrawGridX:TRUE];

    [graph setGridLineColor:[UIColor lightGrayColor]];
    [graph setGridLineWidth:0.3];

    [graph setTextFontSize:12];
    [graph setTextColor:[UIColor blackColor]];
    [graph setTextFont:[UIFont systemFontOfSize:graph.textFontSize]];

    [graph setMarkerColor:[UIColor orangeColor]];
    [graph setMarkerTextColor:[UIColor whiteColor]];
    [graph setMarkerWidth:0.4];
    [graph setShowMarker:TRUE];
    [graph setShowCustomMarkerView:TRUE];

    [graph drawGraph];
    [self.view addSubview:graph];
}

#pragma mark MultiLineGraphViewDataSource

- (NSMutableArray *)xDataForLineToBePlotted{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 30; i++) {
        [array addObject:[NSString stringWithFormat:@"%d", 1000 + i]];
    }
    return array;
}
- (NSInteger)numberOfLinesToBePlotted{
    return 3;
}

- (LineDrawingType)typeOfLineToBeDrawnWithLineNumber:(NSInteger)lineNumber{
    switch (lineNumber) {
        case 0:
            return LineDefault;
            break;
        case 1:
            return LineDefault;
            break;
        case 2:
            return LineDefault;
            break;
        case 3:
            return LineParallelXAxis;
            break;
        case 4:
            return LineParallelYAxis;
            break;
        default:
            break;
    }
    return LineDefault;
}

- (UIColor *)colorForTheLineWithLineNumber:(NSInteger)lineNumber{
    NSInteger aRedValue = arc4random()%255;
    NSInteger aGreenValue = arc4random()%255;
    NSInteger aBlueValue = arc4random()%255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue/255.0f green:aGreenValue/255.0f blue:aBlueValue/255.0f alpha:1.0f];
    return randColor;
}

- (CGFloat)widthForTheLineWithLineNumber:(NSInteger)lineNumber{
    return 1;
}

- (NSString *)nameForTheLineWithLineNumber:(NSInteger)lineNumber{
    return [NSString stringWithFormat:@"data %ld",(long)lineNumber];
}

- (BOOL)shouldFillGraphWithLineNumber:(NSInteger)lineNumber{
    switch (lineNumber) {
        case 0:
            return false;
            break;
        case 1:
            return true;
            break;
        case 2:
            return false;
            break;
        case 3:
            return false;
            break;
        case 4:
            return true;
            break;
        default:
            break;
    }
    return false;
}

- (BOOL)shouldDrawPointsWithLineNumber:(NSInteger)lineNumber{
    switch (lineNumber) {
        case 0:
            return true;
            break;
        case 1:
            return false;
            break;
        case 2:
            return false;
            break;
        case 3:
            return false;
            break;
        case 4:
            return false;
            break;
        default:
            break;
    }
    return false;
}

- (NSMutableArray *)dataForYAxisWithLineNumber:(NSInteger)lineNumber {
    switch (lineNumber) {
        case 0:
        {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (int i = 20; i < 30; i++) {
                [array addObject:[NSNumber numberWithLong:random() % 100]];
            }
            return array;
        }
            break;
        case 1:
        {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (int i = 0; i < 10; i++) {
                [array addObject:[NSNumber numberWithLong:random() % 100]];
            }
            return array;
        }
            break;
        case 2:
        {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (int i = 0; i < 30; i++) {
                [array addObject:[NSNumber numberWithLong:random() % 50]];
            }
            return array;
        }
            break;
        case 3:
        {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            [array addObject:[NSNumber numberWithLong:random() % 100]];
            [array addObject:[NSNumber numberWithLong:random() % 100]];
            return array;
        }
            break;
        case 4:
        {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            return array;
        }
            break;
        default:
            break;
    }
    return [[NSMutableArray alloc] init];
}

- (NSMutableArray *)dataForXAxisWithLineNumber:(NSInteger)lineNumber {
    switch (lineNumber) {
        case 0:
        {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (int i = 21; i <= 30; i++) {
                [array addObject:[NSString stringWithFormat:@"%d Jun", i]];
            }
            return array;
        }
            break;
        case 1:
        {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (int i = 1; i <= 30; i++) {
                [array addObject:[NSString stringWithFormat:@"%d Jun", i]];
            }
            return array;
        }
            break;
        case 2:
        {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (int i = 1; i <= 30; i++) {
                [array addObject:[NSString stringWithFormat:@"%d Jun", i]];
            }
            return array;
        }
            break;
        case 3:
        {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (int i = 1; i <= 30; i+=10) {
                [array addObject:[NSString stringWithFormat:@"%d Jun", i]];
            }
            return array;
        }
            break;
        case 4:
        {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            [array addObject:@"6 Jun"];
            [array addObject:@"28 Jun"];
            return array;
        }
            break;
        default:
            break;
    }
    return [[NSMutableArray alloc] init];
}

- (UIView *)customViewForLineChartTouchWithXValue:(id)xValue andYValue:(id)yValue{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor whiteColor]];
    [view.layer setCornerRadius:4.0F];
    [view.layer setBorderWidth:1.0F];
    [view.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [view.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [view.layer setShadowRadius:2.0F];
    [view.layer setShadowOpacity:0.3F];

    CGFloat y = 0;
    CGFloat width = 0;
    for (int i = 0; i < 3 ; i++) {
        UILabel *label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:12]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setText:[NSString stringWithFormat:@"Line Data:y = %@ x = %@", yValue, xValue]];
        [label setFrame:CGRectMake(0, y, 200, 30)];
        [view addSubview:label];

        width = WIDTH(label);
        y = BOTTOM(label);
    }

    [view setFrame:CGRectMake(0, 0, width, y)];
    return view;
}

#pragma mark MultiLineGraphViewDelegate

- (void)didTapWithValuesAtX:(NSString *)xValue valuesAtY:(NSString *)yValue{
    NSLog(@"Line Chart: Value-X:%@, Value-Y:%@",xValue, yValue);
}

@end

//
//  ViewController.m
//  Stat
//
//  Created by Александр Чегошев on 15.08.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "DateViewController.h"

@interface DateViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *beginDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDate;

@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDate *today = [NSDate date];
    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:-86400];
    NSDate *begin = [NSDate dateWithTimeIntervalSinceReferenceDate:0];
    
    self.beginDate.minimumDate = begin;
    self.endDate.minimumDate = begin;
    self.beginDate.maximumDate = yesterday;
    self.endDate.maximumDate = today;

}

- (IBAction)doneAction:(id)sender {

    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd.MM.yy"];
    NSString *beginDate = [formatter stringFromDate:self.beginDate.date];
    NSString *endData = [formatter stringFromDate:self.endDate.date];
    NSArray *dateArray = [NSArray arrayWithObjects:beginDate,endData, nil];

    [self.delegate getDateArray:dateArray];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

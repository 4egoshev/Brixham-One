//
//  DatePickerView.m
//  Brixham One
//
//  Created by Александр Чегошев on 04.09.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "DatePickerView.h"

#define DAY_AGO -86400

@implementation DatePickerView

- (void)awakeFromNib {
    [super awakeFromNib];

    NSDate *today = [NSDate date];
    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:DAY_AGO];
    NSDate *since = [NSDate dateWithTimeIntervalSinceReferenceDate:0];

    self.beginDate.minimumDate = since;
    self.endDate.minimumDate = since;
    self.beginDate.maximumDate = yesterday;
    self.endDate.maximumDate = today;

}

- (void)configDateArray {

    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd.MM.yy"];
    NSString *beginDate = [formatter stringFromDate:self.beginDate.date];
    NSString *endDate = [formatter stringFromDate:self.endDate.date];
    NSArray *array = [NSArray arrayWithObjects:beginDate,endDate, nil];
    [self.delegate getDateArray:array];
}

- (void)configTodayArray {

    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd.MM.yy"];
    NSString *todayString = [formatter stringFromDate:today];
    NSArray *array = [NSArray arrayWithObjects:todayString,todayString, nil];
    [self.delegate getDateArray:array];
}

- (void)checkDate {

    BOOL isFail = self.beginDate.date > self.endDate.date;

    switch ((NSInteger)isFail) {
        case YES:
            [self fail];
            break;
        case NO:
            [self success];
            break;

        default:
            break;
    }
}

-(void)success {

    NSString *title = @"Сохранено!";
    NSString *description = @"Выбранный временной интервал сохранен";
    NSString *button = @"Ok";
    NSArray *array = [NSArray arrayWithObjects:title,description,button, nil];
    [self.delegate getTextForAlert:array];

}

-(void)fail {

    NSString *title = @"Ошибка!";
    NSString *description = @"Дата окончания не может быть позднее даты начала";
    NSString *button = @"Cencel";
    NSArray *array = [NSArray arrayWithObjects:title,description,button, nil];
    [self.delegate getTextForAlert:array];
    
}

- (void)fixDate {

    NSDate *beforeDay = [NSDate dateWithTimeInterval:DAY_AGO
                                           sinceDate:self.endDate.date];
    [self.beginDate setDate:beforeDay];
}


@end

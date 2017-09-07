//
//  DatePickerView.h
//  Brixham One
//
//  Created by Александр Чегошев on 04.09.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewDelegate;

@interface DatePickerView : UIView

@property (strong, nonatomic) NSDate *begin;
@property (strong, nonatomic) NSDate *end;

@property (weak, nonatomic) IBOutlet UIDatePicker *beginDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDate;

@property (strong, nonatomic) id<DatePickerViewDelegate> delegate;

- (void)configDateArray;
- (void)configTodayArray;

- (void)checkDate;

@end

@protocol DatePickerViewDelegate <NSObject>

- (void)getDateArray:(NSArray *)dateArray;
- (void)getTextForAlert:(NSArray *)textArray;

@end

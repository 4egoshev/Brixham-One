//
//  DateView.m
//  Brixham One
//
//  Created by Александр Чегошев on 12.09.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "DateView.h"

@implementation DateView

- (void)configTitleWithObject:(NSString *)object
                 andDateArray:(NSArray *)dateArray {

    self.objectLabel.text = object;
    NSString *begin = dateArray.firstObject;
    NSString *end = dateArray.lastObject;
    if ([begin isEqualToString:end] || begin == nil || end == nil) {
        self.dateLabel.text = @"Сегодня";
    } else {
        self.dateLabel.text = [NSString stringWithFormat:@"%@-%@",begin,end];
    }
}

@end

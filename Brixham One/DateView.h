//
//  DateView.h
//  Brixham One
//
//  Created by Александр Чегошев on 12.09.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateView : UIView

@property (weak, nonatomic) IBOutlet UILabel *objectLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (void)configTitleWithObject:(NSString *)object
                 andDateArray:(NSArray *)dateArray;

@end

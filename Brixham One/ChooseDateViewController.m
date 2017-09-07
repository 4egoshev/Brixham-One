//
//  ChooseDateViewController.m
//  Brixham One
//
//  Created by Александр Чегошев on 04.09.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "ChooseDateViewController.h"
#import "DatePickerView.h"
#import "Constants.h"

@interface ChooseDateViewController () <DatePickerViewDelegate>

@property (strong, nonatomic) NSArray *dateArray;
@property (strong, nonatomic) NSArray *textForAlertArray;

@property (strong, nonatomic) DatePickerView *datePickerView;

@property (weak, nonatomic) IBOutlet UIView *appearanceView;
@property (weak, nonatomic) IBOutlet UISwitch *todaySwitch;

@end

@implementation ChooseDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.datePickerView = [DatePickerView new];
    self.datePickerView.delegate = self;
}

- (IBAction)todaySegmentedAction:(id)sender {

    switch (self.todaySwitch.on) {
        case NO:
            [self loadDatePickerView];
            break;
        case YES:
            [self removeDatePickerView];
            break;
        default:
            break;
    }

}

- (IBAction)saveAction:(id)sender {

    [self.datePickerView checkDate];

    if (self.todaySwitch.on) {
        [self.datePickerView configTodayArray];
    } else {
        [self.datePickerView configDateArray];
    }

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.dateArray];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:DATE];

    [self showAlert];
}

- (void)showAlert {

    NSString *title = self.textForAlertArray.firstObject;
    NSString *description = self.textForAlertArray[1];
    NSString *button = self.textForAlertArray.lastObject;

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:description
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:button
                                                       style:UIAlertActionStyleCancel
                                                     handler:nil];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];

}

#pragma mark Load View

- (void)loadDatePickerView {
    self.datePickerView = [[NSBundle mainBundle] loadNibNamed:@"DatePickerView" owner:self options:nil].firstObject;
    self.datePickerView.frame = CGRectMake(self.appearanceView.bounds.origin.x, self.appearanceView.bounds.origin.y, self.appearanceView.bounds.size.width, self.appearanceView.bounds.size.height);
    self.datePickerView.delegate = self;
    [self.appearanceView addSubview:self.datePickerView];
}

- (void)removeDatePickerView {
    for (DatePickerView *view in self.appearanceView.subviews) {
        [view removeFromSuperview];
    }

}

#pragma mark DatePickerViewDelegate

- (void)getDateArray:(NSArray *)dateArray{
    self.dateArray = dateArray;
}

-(void)getTextForAlert:(NSArray *)textArray {
    self.textForAlertArray = textArray;

}

@end

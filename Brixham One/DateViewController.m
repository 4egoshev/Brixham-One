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


}

- (IBAction)doneAction:(id)sender {

    NSLog(@"begin = %@",self.beginDate.date);
    NSLog(@"end = %@",self.endDate.date);
    NSArray *dateArray = [NSArray arrayWithObjects:self.beginDate.date,self.endDate.date, nil];

    [self.delegate getDateArray:dateArray];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

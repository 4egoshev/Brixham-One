//
//  ViewController.h
//  Stat
//
//  Created by Александр Чегошев on 15.08.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DateDelegate;

@interface DateViewController : UIViewController

@property (strong, nonatomic) id<DateDelegate> delegate;

@end

@protocol DateDelegate <NSObject>

- (void)getDateArray:(NSArray *)dateArray;

@end



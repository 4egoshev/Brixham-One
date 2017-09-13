//
//  LoginView.m
//  Brixham One
//
//  Created by Александр Чегошев on 08.09.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UIView* view in self.subviews)
        [view resignFirstResponder];
}

- (void)showWorning {
    self.worningLabel.text = @"Неверный логин или пароль";
    self.worningLabel.textColor = [UIColor redColor];
}


@end

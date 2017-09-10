//
//  LoginView.m
//  Brixham One
//
//  Created by Александр Чегошев on 08.09.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView* view in self.subviews)
        [view resignFirstResponder];
}
@end

//
//  LoginView.h
//  Brixham One
//
//  Created by Александр Чегошев on 08.09.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UIButton *enterButton;

@end

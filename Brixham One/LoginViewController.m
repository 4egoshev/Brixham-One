//
//  LoginViewController.m
//  Brixham One
//
//  Created by Александр Чегошев on 08.09.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "ServerManager.h"

@interface LoginViewController ()// <UITextFieldDelegate>

@property (strong, nonatomic) LoginView *loginView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [UITextField new].delegate = self;

    LoginView *loginView = [[NSBundle mainBundle] loadNibNamed:@"LoginView" owner:self options:nil].firstObject;

    loginView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height);

    [loginView.enterButton addTarget:self action:@selector(enter:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginView];

    self.loginView = loginView;


}

- (void)enter:(id)sender {

    [[ServerManager sharedManager] loginWithLogin:self.loginView.loginField.text
                                      andPassword:self.loginView.passwordField.text
                                        onSuccees:^(NSString *accessToken) {
                                            NSLog(@"Enter");
                                        }
                                        onFailure:^(NSError *error) {
                                            NSLog(@"Not");
                                        }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

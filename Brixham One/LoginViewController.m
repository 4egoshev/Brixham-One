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
#import "SWRevealViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *enterButton;

@property (strong, nonatomic) LoginView *loginView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
                                            if (accessToken) {
                                                UIStoryboard *storuboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                SWRevealViewController *swvc = [storuboard instantiateViewControllerWithIdentifier:@"SWVC"];
                                                [self presentViewController:swvc animated:YES completion:nil];
                                            }
                                        }
                                        onFailure:^(NSError *error) {
                                            NSLog(@"Not");
                                        }];
}

@end

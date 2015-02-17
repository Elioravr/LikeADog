//
//  LoginViewController.m
//  LikeADog2
//
//  Created by Elior on 14/1/15.
//  Copyright (c) 2015 EliorGalRotem. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.passwordInput.secureTextEntry = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButton:(id)sender {
    NSString *mail = self.mailInput.text;
    NSString *password = self.passwordInput.text;
    [PFUser logInWithUsernameInBackground:mail password:password
        block:^(PFUser *user, NSError *error) {
        if (user) {
            [self.delegate onLoggedIn:sender];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            // The login failed. Check error to see why.
            [self showValidationError:@"Something went wrong" message:error.userInfo[@"error"]];
        }
    }];
}

- (void)showValidationError:(NSString*)title message:(NSString*)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

// Close the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"createAccountSegue"]) {
        CreateAccountViewController *createAccountViewController = segue.destinationViewController;
        createAccountViewController.delegate = self;
    }
}

- (IBAction)onSignedIn:(id)sender {
    [self.delegate onSignedIn:sender];
}
@end

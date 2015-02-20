//
//  CreateAccountViewController.m
//  LikeADog2
//
//  Created by Elior on 14/1/15.
//  Copyright (c) 2015 EliorGalRotem. All rights reserved.
//

#import "CreateAccountViewController.h"
#import <Parse/Parse.h>

@interface CreateAccountViewController ()

@end

@implementation CreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.birthdayDatetimepicker.datePickerMode = UIDatePickerModeDate;
    self.passwordInput.secureTextEntry = YES;
    self.confirmationInput.secureTextEntry = YES;
    
    self.birthdayDatetimepicker.maximumDate = [NSDate date];
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

- (IBAction)signupButton:(id)sender {
    User* user = [self serializeUser];
    if (user != nil) {
        [self addUser:user sender:sender];
    }
}

- (User*)serializeUser {
    NSString* password = self.passwordInput.text;
    NSString* passwordConfirmation = self.confirmationInput.text;
    NSString* nickname = self.nicknameInput.text;
    NSString* email = self.emailInput.text;
    NSDate*   birthday = self.birthdayDatetimepicker.date;
    NSString* gender = [self.genderSegmentedControl titleForSegmentAtIndex:self.genderSegmentedControl.selectedSegmentIndex];
    
    User* user = nil;
    
    if ([self isWhiteSpaceOrEmpty:email]) {
        [self showValidationError:@"Email required" message:@"Please enter your email address and try again."];
    }
    else if ([self isWhiteSpaceOrEmpty:nickname]) {
        [self showValidationError:@"Nickname required" message:@"Please enter your nickname and try again."];
    }
    else if ([self isWhiteSpaceOrEmpty:password]) {
        [self showValidationError:@"Password required" message:@"Please enter your password and try again."];
    }
    else if (![password isEqualToString:passwordConfirmation]) {
        [self showConfirmationAlert];
    }
    else {
        user = [[User alloc] initWithNickname:nickname email:email password:password passwordConfirmation:passwordConfirmation birthday:birthday gender:gender userId:@""];
    }
    
    return user;
}

- (void)showConfirmationAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Passwords are not the same"
                                                    message:@"Password confirmation doesn't match Password. Please fix it."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)showValidationError:(NSString*)title message:(NSString*)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (BOOL)isWhiteSpaceOrEmpty:(NSString*)string {
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    return ([[string stringByTrimmingCharactersInSet:set] length] == 0);
}

- (void)addUser:(User*)serializedUser sender:(id)sender {
    PFUser *user = [PFUser user];
    user.username = serializedUser.email;
    user.email = serializedUser.email;
    user.password = serializedUser.password;
    
    // other fields can be set if you want to save more information
    user[@"birthday"] = [serializedUser getBirthdayString];
    user[@"gender"] = serializedUser.gender;
    user[@"nickname"] = serializedUser.nickname;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            [self showValidationError:@"Hooray!!" message:@"You just registered to LikeADog!"];
            [self.delegate onSignedIn:self];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            NSString *errorString = [error localizedDescription];
            // Show the errorString somewhere and let the user try again.
            [self showValidationError:@"Something went wrong!!" message:errorString];
        }
    }];
}

// Close the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

@end

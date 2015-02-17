//
//  LoginViewController.h
//  LikeADog2
//
//  Created by Elior on 14/1/15.
//  Copyright (c) 2015 EliorGalRotem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateAccountViewController.h"

@protocol LoginViewControllerParent <NSObject>

- (IBAction)onLoggedIn:(id)sender;
- (IBAction)onSignedIn:(id)sender;

@end

@interface LoginViewController : UIViewController <UITextFieldDelegate, CreateAccountViewControllerParent>

@property (weak, nonatomic) IBOutlet UITextField *mailInput;
@property (weak, nonatomic) IBOutlet UITextField *passwordInput;
@property (weak, nonatomic) id<LoginViewControllerParent> delegate;
- (IBAction)loginButton:(id)sender;
- (IBAction)backgroundTap:(id)sender;

@end


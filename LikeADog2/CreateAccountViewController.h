//
//  CreateAccountViewController.h
//  LikeADog2
//
//  Created by Elior on 14/1/15.
//  Copyright (c) 2015 EliorGalRotem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import <Foundation/Foundation.h>

@protocol CreateAccountViewControllerParent <NSObject>

- (IBAction)onSignedIn:(id)sender;

@end

@interface CreateAccountViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailInput;
@property (weak, nonatomic) IBOutlet UITextField *nicknameInput;
@property (weak, nonatomic) IBOutlet UITextField *passwordInput;
@property (weak, nonatomic) IBOutlet UITextField *confirmationInput;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegmentedControl;
@property (weak, nonatomic) IBOutlet UIDatePicker *birthdayDatetimepicker;
@property id<CreateAccountViewControllerParent> delegate;
- (IBAction)signupButton:(id)sender;
- (IBAction)backgroundTap:(id)sender;

@end

//
//  MainViewController.m
//  LikeADog2
//
//  Created by Elior on 14/2/15.
//  Copyright (c) 2015 EliorGalRotem. All rights reserved.
//

#import "MainViewController.h"
#import <Parse/Parse.h>

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        [self updateLabel];
    } else {
        [self performLoginForm];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutButton:(id)sender {
    [PFUser logOut];
    [self performLoginForm];
    
}

- (void)performLoginForm {
    // show the signup or login screen
    [self performSegueWithIdentifier:@"unregisteredUser" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"unregisteredUser"]) {
        UINavigationController *navigationViewController = (UINavigationController*)segue.destinationViewController;
        LoginViewController *loginViewController = navigationViewController.viewControllers[0];
        loginViewController.delegate = self;
    }
}

// Implements the LoginParent methods
- (IBAction)onLoggedIn:(id)sender {
    [self updateLabel];
}

// Implements the RegisterParent methods
- (IBAction)onSignedIn:(id)sender {
    [self updateLabel];
}

- (void)updateLabel {
    PFUser *currentUser = [PFUser currentUser];
    self.usernameLabel.text = [NSString stringWithFormat:@"%@ %@!", @"Welcome", currentUser[@"nickname"]];
}
@end

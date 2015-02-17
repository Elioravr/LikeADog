//
//  MainViewController.h
//  LikeADog2
//
//  Created by Elior on 14/2/15.
//  Copyright (c) 2015 EliorGalRotem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface MainViewController : UIViewController <LoginViewControllerParent>
- (IBAction)logoutButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end

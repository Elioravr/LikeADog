//
//  NewPostViewController.m
//  LikeADog2
//
//  Created by Elior on 19/2/15.
//  Copyright (c) 2015 EliorGalRotem. All rights reserved.
//

#import "NewPostViewController.h"
#import "AppModel.h"
#import <Parse/Parse.h>

@interface NewPostViewController ()

@end

@implementation NewPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Draw border to the post text view
    [self initTextViewDesign];
    
    self.clearImageButton.hidden = YES;
    self.hasUserImage = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTextViewDesign {
    //To make the border look very close to a UITextField
    [self.postText.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [self.postText.layer setBorderWidth:1.0];
    
    //The rounded corner part, where you specify your view's corner radius:
    self.postText.layer.cornerRadius = 5;
    self.postText.clipsToBounds = YES;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [self.imageView setImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)browseImageClicked:(id)sender {
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:self.imagePicker animated:YES completion:NULL];
    self.clearImageButton.hidden = NO;
    self.hasUserImage = YES;
}

- (IBAction)clearImageClicked:(id)sender {
    self.imageView.image = [UIImage imageNamed:@"unicorn.jpg"];
    self.clearImageButton.hidden = YES;
    self.hasUserImage = NO;
}

- (IBAction)saveClicked:(id)sender {
    NSString *postText = self.postText.text;
    User *currentUser = [[AppModel instance] getCurrentUser];
//    PFUser *user = [PFUser currentUser];
//    NSString *userId = [user objectId];
    
    UIImage *image;
    if (self.hasUserImage) {
        image = self.imageView.image;
    }
//
//    Post *post = [[Post alloc] initWithParameters:postText userId:currentUser.userId image:image];
    Post *post = [[Post alloc] initWithUser:currentUser postId:@"" text:postText image:image];
    [[AppModel instance] addNewPostWithBlock:post callback:^(BOOL *succeeded) {
        if (succeeded) {
            [self newPostSaved];
        }
        else {
            [self showSaveError];
        }
    }];
}

-(void)showSaveError {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something went wrong"
                                                    message:@"We could not save your post. please try again later"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

-(void)newPostSaved {
    [self.delegate newPostSaved];
    [self.navigationController popViewControllerAnimated:YES];
}
@end

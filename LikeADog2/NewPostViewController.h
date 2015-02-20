//
//  NewPostViewController.h
//  LikeADog2
//
//  Created by Elior on 19/2/15.
//  Copyright (c) 2015 EliorGalRotem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@protocol NewPostViewControllerParent <NSObject>

-(void) newPostSaved;

@end


@interface NewPostViewController : UIViewController

@property BOOL hasUserImage;
@property UIImagePickerController *imagePicker;

@property (weak, nonatomic) IBOutlet UITextView *postText;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *clearImageButton;
@property id<NewPostViewControllerParent> delegate;

- (IBAction)browseImageClicked:(id)sender;
- (IBAction)clearImageClicked:(id)sender;
- (IBAction)saveClicked:(id)sender;

@end

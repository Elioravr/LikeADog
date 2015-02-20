//
//  NewsFeedViewController.h
//  LikeADog2
//
//  Created by Elior on 19/2/15.
//  Copyright (c) 2015 EliorGalRotem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "NewPostViewController.h"
#import "AddCommentViewController.h"

@interface NewsFeedViewController : UITableViewController <NewPostViewControllerParent>

- (IBAction)logoutClicked:(id)sender;

@property NSMutableArray *data;
@property Post* lastClickedPost;
- (void)loadData;

- (IBAction)likeButtonClicked:(id)sender;

- (Post*)getClickedPost:(id)senderButton;
- (BOOL)isUserLikedPost:(Post*)post;

- (void)newComment:(NSString*)text;

@end

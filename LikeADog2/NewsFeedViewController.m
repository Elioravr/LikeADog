//
//  NewsFeedViewController.m
//  LikeADog2
//
//  Created by Elior on 19/2/15.
//  Copyright (c) 2015 EliorGalRotem. All rights reserved.
//

#import "NewsFeedViewController.h"
#import "LikesListViewController.h"
#import "CommentsViewController.h"
#import "AddCommentViewController.h"
#import "PostViewCell.h"
#import "AppModel.h"
#import "Comment.h"

@interface NewsFeedViewController ()

@end

@implementation NewsFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    User *currentUser = [[AppModel instance] getCurrentUser];
    if (currentUser) {
        [self loadData];
    } else {
        [self performLoginForm];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData {
    [[AppModel instance] getAllPostsWithBlock:^(NSMutableArray* list) {
        self.data = list;
        [self.tableView reloadData];
    }];
    // Fill the list by the DB...
}
//
//- (IBAction)likeButtonClicked:(id)sender {
//    Post* clickedPost = [self getClickedPost:sender];
//    
//    if ([self isUserLikedPost:clickedPost])
//        [[AppModel instance] unlike:clickedPost];
//    else
//        [[AppModel instance] addLikeWithBlock:clickedPost callback:^(BOOL succeeded) {
//            if (succeeded) {
//                [self loadData];
////                // Update the likes list
////                [[AppModel instance] getAllPostsWithBlock:^(NSMutableArray *likedUsers) {
////                    clickedPost.likedUsers = likedUsers;
////                    [self.tableView reloadData];
////                }
//            }
//        }];
//    
//    // [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
//}

-(Post*)getClickedPost:(id)senderButton {
    CGPoint buttonPosition = [senderButton convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath* indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    
    Post* clickedPost = [self.data objectAtIndex:indexPath.row];
    return clickedPost;
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    return self.data.count;
}

//-(BOOL)isUserLikedPost:(Post*)post {
//    BOOL isCurrUserliked = NO;
//    User* currUser = [[AppModel instance] getCurrentUser];
//    for (User* iUser in post.likedUsers)
//    {
//        if (iUser.email == currUser.email)
//        {
//            isCurrUserliked = YES;``
//            break;
//        }
//    }
//    
//    return isCurrUserliked;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellPostIdentifier" forIndexPath:indexPath];
    
    Post* currPost = [self.data objectAtIndex:indexPath.row];
    
    cell.userNameLabel.text = currPost.user.nickname;
    cell.postText.text = currPost.text;
    
//    NSString* likeButtonContent = [self isUserLikedPost:currPost] ? @"Unlike": @"Like";
//    [cell.likeButton setTitle:likeButtonContent forState:UIControlStateNormal];
    
//    NSNumber* likesCount = [NSNumber numberWithInt:[currPost.likedUsers count]];
//    NSString* likesStatusToShow = [NSString stringWithFormat:@"%@ Likes", likesCount];
//    [cell.likesStatusButton setTitle:likesStatusToShow forState:UIControlStateNormal];
//
    NSNumber* commentsCount = [NSNumber numberWithInt:[currPost.comments count]];
    NSString* commentsStatusToShow = [NSString stringWithFormat:@"%@ Comments", commentsCount];
    [cell.commentsButton setTitle:commentsStatusToShow forState:UIControlStateNormal];
    
    UIImage* img = currPost.image;
    
    if (img != nil) {
        [cell.imageView setImage:img];
        CGFloat widthScale = 130 / img.size.width;
        CGFloat heightScale = 99 / img.size.height;
        
        cell.imageView.transform = CGAffineTransformMakeScale(widthScale, heightScale);
        cell.postText.frame = CGRectMake(151, 30, 130, 99);
        
    }
    else {
        cell.postText.frame = CGRectMake(13, 37, 300, 99);
    }
        
    return (UITableViewCell*)cell;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"newPost"]) {
        NewPostViewController *newPost = segue.destinationViewController;
        newPost.delegate = self;
    }
//    if ([segue.identifier isEqualToString:@"LikesListSegue"]){
//        NSMutableArray* likes;
//        [[AppModel instance] getLikedUsersForPostWithBlock:clickedPost callback:^(NSMutableArray *likedUsers) {
//            __block likes = likedUsers;
//        }];
//        LikesListViewController* nextCtrl = segue.destinationViewController;
//        [nextCtrl setContext:likes];
//    }
    else if ([segue.identifier isEqualToString:@"CommentsListSegue"]){
        Post* clickedPost = [self getClickedPost:sender];
        NSMutableArray* comments = clickedPost.comments;
        CommentsViewController* nextCtrl = segue.destinationViewController;
        [nextCtrl setContext:comments];
    }
    else if ([segue.identifier isEqualToString:@"AddCommentSegue"]){
        Post* clickedPost = [self getClickedPost:sender];
        self.lastClickedPost = clickedPost;
        AddCommentViewController* nextCtrl = segue.destinationViewController;
        nextCtrl.delegate = self;
    }
}

//-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
//    if ([identifier isEqualToString:@"CommentsListSegue"]) {
//        Post* clickedPost = [self getClickedPost:sender];
//        if (clickedPost.comments.count == 0)
//            return NO;
//    }
//    
//    return YES;
//}

//
-(void)newComment:(NSString*)text{
    Post* post = self.lastClickedPost;
    
    Comment* comment = [[Comment alloc] init];
    comment.userName = [[AppModel instance] getCurrentUser].nickname;
//    NSDate* today = [NSDate date];
//    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
//    comment.time = [dateFormatter stringFromDate:today];
//    comment.time =
    comment.content = text;
    
    [[AppModel instance] addCommentWithBlock:post comment:comment callback:^(BOOL *succeeded) {
        if (succeeded) {
            // Update the comments list
            [[AppModel instance] getCommentsForPostWithBlock:post callback:^(NSMutableArray *comments) {
                post.comments = comments;
                [self.tableView reloadData];
            }];
        }
    }];
}

//- (IBAction)privateMessageButtonClicked:(id)sender{
//    Post* clickedPost = [self getClickedPost:sender];
//    [self sendMail:clickedPost.user.email];
//}
//
//-(void)sendMail:(NSString*)emailAddress{
//    NSString* message = [NSString stringWithFormat:@"Send an email to : %@", emailAddress];
//    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Like A Dog" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    
//    [alert show];
//}

- (void)newPostSaved {
    [self loadData];
}

- (IBAction)logoutClicked:(id)sender {
    [[AppModel instance] logOut];
    [self performLoginForm];
}

- (void)performLoginForm {
    // show the signup or login screen
    [self performSegueWithIdentifier:@"unregisteredUser" sender:nil];
}

@end

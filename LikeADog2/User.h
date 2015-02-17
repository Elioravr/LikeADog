//
//  User.h
//  LikeADog2
//
//  Created by Elior on 14/1/15.
//  Copyright (c) 2015 EliorGalRotem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property NSString* nickname;
@property NSString* email;
@property NSString* password;
@property NSDate* birthday;
@property NSString* gender;

- (id)initWithNickname:(NSString*)nickname email:(NSString*)email password:(NSString*)password passwordConfirmation:(NSString*)passwordConfirmation birthday: (NSDate*)birthday gender:(NSString*)gender;
- (NSString*)getBirthdayString;

@end

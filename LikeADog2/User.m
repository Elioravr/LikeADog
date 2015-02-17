//
//  User.m
//  LikeADog2
//
//  Created by Elior on 14/1/15.
//  Copyright (c) 2015 EliorGalRotem. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithNickname:(NSString*)nickname email:(NSString*)email password:(NSString*)password passwordConfirmation:(NSString*)passwordConfirmation birthday: (NSDate*)birthday gender:(NSString*)gender
{
    self = [super init];
    if (self)
    {
        self.nickname = nickname;
        self.email = email;
        self.password = password;
        self.birthday = birthday;
        self.gender = gender;
        
    }
    return self;
}


- (NSString*)getBirthdayString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    
    return [dateFormatter stringFromDate:self.birthday];
}
@end

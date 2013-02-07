//
//  tfFacebookFriend.h
//  tableandfriends_iOS
//
//  Created by Filipe Araujo on 2/4/13.
//  Copyright (c) 2013 Filipe Araujo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface tfFacebookFriend : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSURL *photoUrl;
@end

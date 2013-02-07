//
//  tfDinner.h
//  tableandfriends_iOS
//
//  Created by Filipe Araujo on 2/1/13.
//  Copyright (c) 2013 Filipe Araujo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface tfDinner : NSObject
    @property (nonatomic, copy) NSString *name;
    @property (nonatomic, copy) NSString *address;
    @property (nonatomic, copy) NSString *restaurant;
    @property (nonatomic, copy) NSString *date;
    @property (nonatomic, copy) NSString *photoUrl;
    @property (nonatomic, copy) NSArray *participants;
@end

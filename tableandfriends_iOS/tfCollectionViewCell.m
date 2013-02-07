//
//  tfCollectionViewCell.m
//  tableandfriends_iOS
//
//  Created by Filipe Araujo on 2/4/13.
//  Copyright (c) 2013 Filipe Araujo. All rights reserved.
//

#import "tfCollectionViewCell.h"

@implementation tfCollectionViewCell

@synthesize image;
@synthesize label;
@synthesize activity;
@synthesize selectedT;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        // Initialization code
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

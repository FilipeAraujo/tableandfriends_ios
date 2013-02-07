//
//  tfTableViewCell.m
//  tableandfriends_iOS
//
//  Created by Filipe Araujo on 2/1/13.
//  Copyright (c) 2013 Filipe Araujo. All rights reserved.
//

#import "tfTableViewCell.h"

@implementation tfTableViewCell

@synthesize activity1;
@synthesize activity2;
@synthesize activity3;
@synthesize activity4;
@synthesize image1;
@synthesize image2;
@synthesize image3;
@synthesize label1;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)hidePhotos
{
    [image1 setHidden:TRUE];
    [image2 setHidden:TRUE];
    [image3 setHidden:TRUE];
    [label1 setHidden:TRUE];
}

- (void)showPhoto:(NSInteger*)photoId
{
    if(photoId == (NSInteger*)0)
    [image1 setHidden:FALSE];
    else
        if(photoId == (NSInteger*)1)
            [image2 setHidden:FALSE];
        else if(photoId == (NSInteger*)2)
            [image3 setHidden:FALSE];
        else if(photoId == (NSInteger*)3)
            [label1 setHidden:FALSE];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  tfTableViewCell.h
//  tableandfriends_iOS
//
//  Created by Filipe Araujo on 2/1/13.
//  Copyright (c) 2013 Filipe Araujo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tfTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity1;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity2;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity3;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity4;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;

@property (weak, nonatomic) IBOutlet UILabel *label1;

-(void)hidePhotos;
-(void)showPhoto:(NSInteger*)photoId;

@end

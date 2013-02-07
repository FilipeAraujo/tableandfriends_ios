//
//  tfCollectionViewCell.h
//  tableandfriends_iOS
//
//  Created by Filipe Araujo on 2/4/13.
//  Copyright (c) 2013 Filipe Araujo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tfCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (nonatomic, getter=isSelected) BOOL selectedT;

@end

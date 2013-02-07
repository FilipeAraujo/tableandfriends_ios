//
//  tfCreateDinnerViewController.h
//  tableandfriends_iOS
//
//  Created by Filipe Araujo on 2/4/13.
//  Copyright (c) 2013 Filipe Araujo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tfAppDelegate.h"
#import "tfFacebookFriend.h"
#import "tfCollectionViewCell.h"

@interface tfCreateDinnerViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) __block NSMutableArray *friends ;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionViewForm;

@end

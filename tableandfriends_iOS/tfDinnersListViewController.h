//
//  tfDinnersListViewController.h
//  tableandfriends_iOS
//
//  Created by Filipe Araujo on 1/31/13.
//  Copyright (c) 2013 Filipe Araujo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tfAppDelegate.h"
#import "SBJson.h"
#import "tfDinner.h"
#import "tfTableViewCell.h"

@interface tfDinnersListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define kLatestDinnersURL [NSURL URLWithString:@"http://tableandfriends.com/meals.json"] //2


- (IBAction)buttonClickLogOut:(id)sender;


@property (weak, nonatomic) IBOutlet UITableView *uiTableView;
@property (strong, nonatomic) __block NSMutableArray *dinners ;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

//
//  tfHomeViewController.h
//  tableandfriends_iOS
//
//  Created by Filipe Araujo on 1/31/13.
//  Copyright (c) 2013 Filipe Araujo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "tfAppDelegate.h"


@interface tfHomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (nonatomic) NSNumber *login;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

- (IBAction)buttonLoginClickHandler:(id)sender;
- (IBAction)buttonFaceClickHandler:(id)sender;

@end

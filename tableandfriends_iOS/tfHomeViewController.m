//
//  tfHomeViewController.m
//  tableandfriends_iOS
//
//  Created by Filipe Araujo on 1/31/13.
//  Copyright (c) 2013 Filipe Araujo. All rights reserved.
//

#import "tfHomeViewController.h"

@interface tfHomeViewController ()


@end

@implementation tfHomeViewController

@synthesize firstLabel;
@synthesize secondLabel;
@synthesize loginButton;
@synthesize activityView;


// FBSample logic
// handler for button click, logs sessions in or out
- (IBAction)buttonLoginClickHandler:(id)sender {
    // get the app delegate so that we can access the session property
    return [self buttonClick:sender];
 }

- (IBAction)buttonFaceClickHandler:(id)sender {
    // get the app delegate so that we can access the session property
    return [self buttonClick:sender];
}

- (IBAction)buttonClick:(id)sender
{
    [activityView startAnimating];
    
    [self.view addSubview:activityView];
    
    tfAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    // this button's job is to flip-flop the session from open to closed
    if (appDelegate.session.isOpen) {
        // if a user logs out explicitly, we delete any cached token information, and next
        // time they run the applicaiton they will be presented with log in UX again; most
        // users will simply close the app or switch away, without logging out; this will
        // cause the implicit cached-token login to occur on next launch of the application
        [appDelegate.session closeAndClearTokenInformation];
        [self performSegueWithIdentifier: @"toApp" sender: self];
        
    } else {
        if (appDelegate.session.state != FBSessionStateCreated) {
            // Create a new, logged out session.
            appDelegate.session = [[FBSession alloc] init];
        }
        
        // if the session isn't open, let's open it now and present the login UX to the user
        [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                         FBSessionState status,
                                                         NSError *error) {
            // and here we make sure to update our UX according to the new session state
            [self performSegueWithIdentifier: @"toApp" sender: self];
            
        }];
    }
    
    



}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [activityView  stopAnimating];
    
    tfAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (!appDelegate.session.isOpen) {
        
        // create a fresh session object
        appDelegate.session = [[FBSession alloc] init];
        
        // if we don't have a cached token, a call to open here would cause UX for login to
        // occur; we don't want that to happen unless the user clicks the login button, and so
        // we check here to make sure we have a token before calling open
        if (appDelegate.session.state == FBSessionStateCreatedTokenLoaded) {
            // even though we had a cached token, we need to login to make the session usable
            [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                             FBSessionState status,
                                                             NSError *error) {
                // we recurse here, in order to update buttons and labels
               // [self updateView];
                [self performSegueWithIdentifier: @"toApp" sender: self];
            }];
        }
    }
    
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    tfAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    if (!appDelegate.session.isOpen){
        return NO;
    }
    
    [activityView stopAnimating];
    
    return YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

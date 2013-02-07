//
//  tfCreateDinnerViewController.m
//  tableandfriends_iOS
//
//  Created by Filipe Araujo on 2/4/13.
//  Copyright (c) 2013 Filipe Araujo. All rights reserved.
//

#import "tfCreateDinnerViewController.h"

@interface tfCreateDinnerViewController ()

@end

@implementation tfCreateDinnerViewController

@synthesize friends;
@synthesize collectionViewForm;


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
    tfAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    friends = [[NSMutableArray alloc] init];
    [collectionViewForm setAllowsMultipleSelection:YES];
    collectionViewForm.delegate = self;
    collectionViewForm.dataSource = self;

    if (appDelegate.session.isOpen) {
        
        // create the request object, using the fbid as the graph path
        FBRequest *friendRequest = [[FBRequest alloc] initWithSession:appDelegate.session graphPath:@"me/friends"];
        
        [friendRequest startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            NSDictionary *resultDictionary = (NSDictionary *)result;
            
            NSArray *data = [resultDictionary objectForKey:@"data"];
   
            NSLog(@"Data:- %@",data);
            
            for (NSDictionary *dic in data) {
                tfFacebookFriend *friend = [[tfFacebookFriend alloc] init];
                friend.name = [dic objectForKey:@"name"];
                friend.token = [dic objectForKey:@"id"];
                friend.photoUrl = [NSURL URLWithString:[[NSString alloc] initWithFormat:@"https://graph.facebook.com/%@/picture",friend.token]];
                NSLog(@"ID:- %@",[dic objectForKey:@"id"]);
                [friends addObject:friend];
            }
         [collectionViewForm reloadData];
   
        }];
    }
    

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionVIew

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [friends count]/2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}


- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    ((tfCollectionViewCell*)cell).selectedT =  !((tfCollectionViewCell*)cell).selectedT;
    
    
    if(((tfCollectionViewCell*)cell).selectedT == NO)
        [collectionViewForm deselectItemAtIndexPath:indexPath animated:YES];
    else
        [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];

    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    tfCollectionViewCell *cell = (tfCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    return cell.selectedT;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    tfCollectionViewCell *cell = (tfCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    return !cell.selectedT;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (tfCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    tfCollectionViewCell *cell = [collectionViewForm dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor: [UIColor blueColor]];
    cell.selectedBackgroundView =view;
    
    int pos = 0;
    if(indexPath.section == 0)
        pos = indexPath.section + indexPath.item;
    else
        pos = indexPath.section + indexPath.section + indexPath.item ;
  
    
    if(pos > [friends count]-1 )
        return cell;
    
    tfFacebookFriend *friend = [friends objectAtIndex:pos];
    NSLog(@"pos:- %i",(pos));
 
    
    cell.label.text = friend.name;

    [cell.image setHidden:TRUE];
    [cell.activity startAnimating];


    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSURL *url = friend.photoUrl;
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
          
            cell.image.image = image;
            [cell.image setHidden:FALSE];
            [cell.activity  stopAnimating];
        });
    });
        

    
    return cell;
}

@end

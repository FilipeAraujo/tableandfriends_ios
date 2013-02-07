//
//  tfDinnersListViewController.m
//  tableandfriends_iOS
//
//  Created by Filipe Araujo on 1/31/13.
//  Copyright (c) 2013 Filipe Araujo. All rights reserved.
//

#import "tfDinnersListViewController.h"

@interface tfDinnersListViewController ()

@end

@implementation tfDinnersListViewController

@synthesize uiTableView;
@synthesize dinners;
@synthesize activityIndicator;



- (IBAction)buttonClickLogOut:(id)sender
{
    tfAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    [appDelegate closeSessionFacebook];
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
    uiTableView.dataSource = self;
    uiTableView.delegate = self;
    
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        kLatestDinnersURL];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
    [uiTableView setHidden:YES];
 	// Do any additional setup after loading the view.
}

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;

    id results = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
    
    dinners = [[NSMutableArray alloc] init];
     
    if ([results isKindOfClass: [NSArray class]])
    {
        // probably iterate through whtever is in it
        for (id object in results) {
            // do something with object
            if ([object isKindOfClass: [NSDictionary class]])
            {
                id name = [object objectForKey:@"name"];
                id date = [object objectForKey:@"date"];
                id participants = [object objectForKey:@"participants"];
                //json dont give address, so hardcoded
                id address = @"Rua da Escola Politécnica 27 1250-099 Lisboa";

                id venue_id = [object objectForKey:@"venue_id"];
                NSString* teste = @"http://www.tableandfriends.com/venues/id.json";
                NSString*  urlvenue = [teste stringByReplacingOccurrencesOfString:@"id"                                   withString:venue_id];
                NSURL *url = [NSURL URLWithString:[urlvenue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                
                
                NSData* dataVenue = [NSData dataWithContentsOfURL:
                                url];

                id resultsVenue = [NSJSONSerialization JSONObjectWithData:dataVenue options:NSJSONReadingAllowFragments error:&error];
                
                id photourl = @"http://s3.amazonaws.com/tablefriends_prod/meals/medium/509bc4d4fe08072d6a000001/meal_img.jpg";
                tfDinner *dinner = [[tfDinner alloc] init];
                dinner.photoUrl = photourl;
                dinner.restaurant = [resultsVenue objectForKey:@"name"];
                dinner.name = name;
                dinner.date = date;
                dinner.participants = participants;
                dinner.address = address;
                
                [dinners addObject:dinner];
                
            }
 
        
        }
    }
    else if ([results isKindOfClass: [NSDictionary class]])
    {
     /*   NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:responseData //1
                              
                              options:kNilOptions
                              error:&error];*/
    }
    else
    {
        // something went horribly wrong.
    }
    
    
    [activityIndicator stopAnimating];
    [activityIndicator setHidden:YES];
    [uiTableView setHidden:NO];
    [uiTableView reloadData];
    
   }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        // Return the number of rows in the section.
        return [dinners count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        tfTableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"dinner"];
        [cell hidePhotos];  
        [cell.activity1 startAnimating];
        [cell.activity2 startAnimating];
        [cell.activity3 startAnimating];
        [cell.activity4 startAnimating];
    
        tfDinner *dinner = [dinners objectAtIndex:indexPath.row];
    
        UILabel *nameLabel = (UILabel *)[cell viewWithTag:100];
        nameLabel.text = dinner.name;
    
        nameLabel = (UILabel *)[cell viewWithTag:101];
        nameLabel.text = dinner.restaurant;

        nameLabel = (UILabel *)[cell viewWithTag:102];
        nameLabel.text = dinner.address;
    
     nameLabel = (UILabel *)[cell viewWithTag:103];
    nameLabel.text=[self dateToString:dinner.date ];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSURL *url = [NSURL URLWithString:[dinner.photoUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView * ImageView = (UIImageView *)
            [cell viewWithTag:200];
            ImageView.image = image;
        });
    });
    
    
    queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSInteger idN = 200;
        for(NSInteger i=0; i < [dinner.participants count]; i++)
        {
            if(i < 4)
            {
                idN = idN+1;
            NSString* urlName = [[dinner.participants objectAtIndex:i] objectForKey:@"medium_photo_url"];
            NSURL *url = [NSURL URLWithString:[urlName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImageView * ImageView = (UIImageView *)
                [cell viewWithTag:idN];
                ImageView.image = image;
                
                if(i==0)
                {
                    [cell.activity1 stopAnimating];
                    [cell.activity1 setHidden:TRUE];
                    [cell showPhoto:(NSInteger*)0];
                }
                else if(i==1)
                {
                    [cell.activity2 stopAnimating];
                    [cell.activity2 setHidden:TRUE];
                    [cell showPhoto:(NSInteger*)1];
                }
                else if(i ==2){
                    [cell.activity3 stopAnimating];
                    [cell.activity3 setHidden:TRUE];
                    [cell showPhoto:(NSInteger*)2];
                }
                
            });
            }else
            {
                [cell.activity4 stopAnimating];
                [cell.activity4 setHidden:TRUE];
                   dispatch_async(dispatch_get_main_queue(), ^{
                    [cell showPhoto:(NSInteger*)3];
                       [cell.label1 setText:[NSString stringWithFormat:@"+%i",[dinner.participants count] -3]];
                   });

            }

            
        }
        //REPENSAR, DEVIDO A N EXISTIR RESULTADOS (participants)
        //TODO: RETHINK, CASE PARTICIPANTS NIL
        [cell.activity1 stopAnimating];
        [cell.activity1 setHidden:TRUE];

        [cell.activity2 stopAnimating];
        [cell.activity2 setHidden:TRUE];

        [cell.activity3 stopAnimating];
        [cell.activity3 setHidden:TRUE];

        [cell.activity4 stopAnimating];
        [cell.activity4 setHidden:TRUE];

    });
    
    
        return cell;
    
}

- (NSString *) dateToString:(NSString *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //Specify only 1 M for month, 1 d for day and 1 h for hour
    //    2013-02-13T21:00:00+00:00
    //   M/d/yyyy h:mm:ss a
    NSString* currentDateString = date;
    NSRange rangeOfDash = [currentDateString rangeOfString:@"T"];
    [dateFormatter setDateFormat:@"yyyy-M-d"];
    NSString* dateToUse = [currentDateString substringToIndex:rangeOfDash.location ];
    NSDate *currentDate = [dateFormatter dateFromString:dateToUse];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* compoNents = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate]; // Get necessary date components
    
    NSMutableString* res = [NSMutableString stringWithFormat:@"%i", [compoNents day]];
    switch ([compoNents month]) {
            
        case 1:
            [res appendFormat: @" Jan"];
            break;
            
        case 2:
            [res appendFormat: @" Fev"];
            break;
            
        case 3:
            [res appendFormat: @" Mar"];
            break;
        case 4:
            [res appendFormat: @" Abr"];
            break;
        case 5:
            [res appendFormat: @" Mai"];
            break;
        case 6:
            [res appendFormat: @" Jun"];
            break;
        case 7:
            [res appendFormat: @" Jul"];
            break;
        case 8:
            [res appendFormat: @" Aug"];
            break;
        case 9:
            [res appendFormat: @" Set"];
            break;
        case 10:
            [res appendFormat: @" Out"];
            break;
        case 11:
            [res appendFormat: @" Nov"];
            break;
        case 12:
            [res appendFormat: @" Dez"];
            break;
        
        default:
            return nil;
            break;
            
    }
    
  
    return res;
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


@end

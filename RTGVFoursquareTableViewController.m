//
//  RTGVFoursquareTableViewController.m
//  Me App
//
//  Created by XCode Developer on 7/25/13.
//  Copyright (c) 2013 Toni Raffael. All rights reserved.
//


#define REST_API_URL @"https://api.foursquare.com/v2/venues/search?ll="
#define SECURE_PARAMETERS @"&client_id=NT02XMM3MFLORPTHYVOUT0X2L4JPNJWW5ETD3AWFJ015EQ11&client_secret=RF0DIM3SBPVUT5TMNQFDWA2JNSXET0XCKL1UFGLIAZ4J3Z44"

#import "RTGVFoursquareTableViewController.h"
#import "RTGVTableViewCell.h"
#import "GVMyDownloader.h"
#import "RTGVVenue.h"

@interface RTGVFoursquareTableViewController ()
@property (nonatomic,strong) NSMutableArray* venues;
@property (nonatomic,strong) NSMutableDictionary* images;
@property (nonatomic) int imageFetchCount;
@end

@implementation RTGVFoursquareTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.venues = [[NSMutableArray alloc] init];
    self.images = [[NSMutableDictionary alloc] init];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *lat = @"42.9722";
    NSString *lon = @"-85.9536";
    NSString *date = @"&v=20130718";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@,%@%@%@",
                                       REST_API_URL,
                                       lat,
                                       lon,
                                       SECURE_PARAMETERS,
                                       date]];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  GVMyDownloader *d = [[GVMyDownloader alloc] initWithRequest:request];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishFetching:) name:@"connectionFinished" object:d];
  //[(RTGVAppDelegate*)[[UIApplication sharedApplication] delegate] incrementNetworkActivity];
  //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
  [d.connection start];
  
  }
  
  - (void) finishFetching: (NSNotification *) n
  {
      //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
      GVMyDownloader *d = [n object];
      NSError *error;
      if ([n userInfo]){
          //error happens
      } else {
          NSData* data = d.receivedData;
          NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
          NSDictionary *response = [json objectForKey:@"response"];
          NSArray *venues = [response objectForKey:@"venues"];
          for(int i = 0; i < venues.count; i++){
              NSDictionary *venue = [venues objectAtIndex:i];
              NSString *name = [venue objectForKey:@"name"];
              NSString *venueUrl = [venue objectForKey:@"canonicalUrl"];
              NSDictionary *location = [venue objectForKey:@"location"];
              NSString *address = @"";
              NSString *city = @"";
              NSString *state = @"";
              if (location) {
                  address = [location objectForKey:@"address"];
                  city = [location objectForKey:@"city"];
                  state = [location objectForKey:@"state"];
              }
              NSArray *categories = [venue objectForKey:@"categories"];
              NSString *categoryName = nil;
              NSString *categoryImageUrl = nil;
              if (categories.count > 0) {
                  NSDictionary *category = [categories objectAtIndex:0];
                  categoryName = [category objectForKey:@"name"];
                  NSDictionary *icon =  [category objectForKey:@"icon"];
                  if(icon){
                      categoryImageUrl = @"";
                      categoryImageUrl = [NSString stringWithFormat:@"%@%@",categoryImageUrl,[icon objectForKey:@"prefix"]];
                      categoryImageUrl = [NSString stringWithFormat:@"%@%@",categoryImageUrl,@"bg_88"];
                      categoryImageUrl = [NSString stringWithFormat:@"%@%@",categoryImageUrl,[icon objectForKey:@"suffix"]];
                  }
              } else {
                  categoryName = @"No category";
              }
              RTGVVenue *venueObject = [RTGVVenue alloc];
              venueObject.name = name;
              venueObject.venueUrl = venueUrl;
              venueObject.address = address;
              venueObject.city = city;
              venueObject.state = state;
              venueObject.category = categoryName;
              venueObject.categoryImageUrl = categoryImageUrl;
              if([self.images objectForKey:categoryImageUrl] == nil && categoryImageUrl != nil){
                  NSURL *imageUrl = [NSURL URLWithString:categoryImageUrl];
                  NSURLRequest *requestImage = [NSURLRequest requestWithURL:imageUrl];
                  GVMyDownloader *d = [[GVMyDownloader alloc] initWithRequest:requestImage];
                  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishImageFetching:) name:@"connectionFinished" object:d];
                  //[(RTGVAppDelegate*)[[UIApplication sharedApplication] delegate] incrementNetworkActivity];
                  //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
                  [d.connection start];
              }
              
              [self.venues addObject:venueObject];
          }
          
          [self.tableView reloadData];
      }
  }

- (void) finishImageFetching: (NSNotification *) n
{
    //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    GVMyDownloader *d = [n object];
    if ([n userInfo]){
        //error happens
    } else {
        self.imageFetchCount += 1;
        NSData* data = d.receivedData;
        UIImage *image = [UIImage imageWithData:data];
        [self.images setObject:image forKey:[[d.request URL] absoluteString]];
    }
    if (self.imageFetchCount > 5) {
        self.imageFetchCount = 0;
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (self.venues) {
        return [self.venues count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"venueCell";
    RTGVTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    RTGVVenue *venue = [self.venues objectAtIndex:indexPath.row];
    cell.venueLabel.text = venue.name;
    cell.locationLabel.text = [NSString stringWithFormat:@"%@, %@",venue.city,venue.state];
    if([self.images objectForKey:venue.categoryImageUrl] != nil){
        cell.categoryImage.image = [self.images objectForKey:venue.categoryImageUrl];
    }
    
    return cell;
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

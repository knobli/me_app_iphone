//
//  RTGVFoursquareViewController.m
//  Me App
//
//  Created by XCode Developer on 7/25/13.
//  Copyright (c) 2013 Toni Raffael. All rights reserved.
//

#define REST_API_URL = "https://api.foursquare.com/v2/venues/"
#define CLIENT_ID = "NT02XMM3MFLORPTHYVOUT0X2L4JPNJWW5ETD3AWFJ015EQ11"
#define CLIENT_SECRET = "RF0DIM3SBPVUT5TMNQFDWA2JNSXET0XCKL1UFGLIAZ4J3Z44"
#define SECURE_PARAMETERS = "&client_id="+CLIENT_ID+"&client_secret="+CLIENT_SECRET

#import "RTGVFoursquareViewController.h"
#import "GVMyDownloader.h"

@interface RTGVFoursquareViewController ()

@end

@implementation RTGVFoursquareViewController

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

    //NSURLConnection* conn = [NSURLConnection connectionWithRequest:request delegate:self];
   // NSOperationQueue *q = [NSoperationQueue mainQueue];
    //[NSURLRequest ]
	// Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *lat = @"42.9722";
    NSString *lon = @"85.9536";
    NSString *date = @"&v=20130718";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@,%@%@%@",REST_API_URL,lat,lon,SECURE_PARAMETERS,date];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    GVMyDownloader *d = [[GVMyDownloader alloc] initWithRequest:request];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishFetching:) name:@"connectionFinished" object:d];
    //[(RTGVAppDelegate*)[[UIApplication sharedApplication] delegate] incrementNetworkActivity];
    //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [d.connection start];
    
}

- (void) finishFetching: (NSNotificationn *) n
{
    //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    GVMyDownloader *d = [n object];
    NSError *error;
    if (n userInfo){
        //error happens
    } else {
        NSData* data = d.receiveData;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSDictionary *response = [json objectForKey:@"response"];
        NSArray *venues = [results objectForKey:@"venues"];
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
            NSString categoryImageUrl = nil;
            if (categories.count > 0) {
                NSDictionary *category = [categories objectAtIndex:0];
                categoryName = [category objectForKey:@"name"];
                NSDictionary icon =  [category objectForKey:@"icon"];
                if(icon){
                    categoryImageUrl = "";
                    categoryImageUrl += [category objectForKey:@"prefix"];
                    categoryImageUrl += "bg_88";
                    categoryImageUrl += [category objectForKey:@"suffix"];
                }
                
            }
        }
        
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

NSData* data = d.receivedDate;
NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];

NSDictionary *topTracks = [json objectForKey:@"ballla"];

@end

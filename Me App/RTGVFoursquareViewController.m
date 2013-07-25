//
//  RTGVFoursquareViewController.m
//  Me App
//
//  Created by XCode Developer on 7/25/13.
//  Copyright (c) 2013 Toni Raffael. All rights reserved.
//

#import "RTGVFoursquareViewController.h"
#import "GVMyDownloader"

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
    NSString *s = @"http://";
    NSURL *url = [NSURL URLWithString:s];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    GVMyDownloader *d = [[GVMyDownloader alloc] initWithRequest:request];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishFetching:) name:@"connectionFinished" object:d];
    [d.connection start];
    
}

- (void) finishFetching: (NSNotificationn *) n
{
    GVMyDownloader *d = [n object];
    NSError *error;
    if (n userInfo){
        //error happens
    } else {
        NSData* data = d.receiveData;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSDictionary *results = [json objectForKey:@"results"];
        NSDictionary *venues = [results objectForKey:@"venues"];
        
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
